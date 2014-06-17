//
//  DKTabDump.m
//  TabDump
//
//  Created by Daniel on 4/22/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import "DKTabDump.h"

// Categories
#import "NSString+DK.h"

// Defines
#import "DKTabDumpDefines.h"

// Libraries
#import "Ono.h"

// Models
#import "DKTab.h"


@implementation DKTabDump

#pragma mark - Public

+ (NSArray*)newListOfDumpsFromResponseData:(NSData*)data {
    NSMutableArray *list = [[NSMutableArray alloc] init];
    
    ONOXMLDocument *responseDocument = [ONOXMLDocument XMLDocumentWithData:data error:nil];
    //TODO: handle error
    for (ONOXMLElement *element in [responseDocument XPath:@"//item"]) {
        DKTabDump *post = [DKTabDump newTabDumpFromXMLElement:element];
        if (post) {
            [list addObject:post];
        }
    }
    
    return [list copy];
}


- (NSString*)title {
    return [NSString stringWithFormat:@"%@: %@ tabs", self.date, self.numberOfTabs];
}


#pragma mark - Private

+ (DKTabDump*)newTabDumpFromXMLElement:(ONOXMLElement*)element {
    DKTabDump *dump = [[DKTabDump alloc] init];
    
    for (ONOXMLElement *childElement in [element CSS:@"title"] ) {
        NSString *titleText = childElement.stringValue;
        //NSLog(@"title=%@",title);
        if ([titleText rangeOfString:@":"].location == NSNotFound) {
            NSLog(@"tab dump - new dump from html - error, missing :, skipping entry in rss");
            return nil;
        }
        
        NSString *title = [titleText substringWithRange:NSMakeRange(0, [titleText rangeOfString:@":"].location)];
        dump.date = title;
        
        NSString *tabsText = [titleText substringToIndex:[titleText rangeOfString:@"tabs"].location];
        tabsText = [tabsText substringFromIndex:[tabsText rangeOfString:@":"].location+2];
        //NSLog(@"tabstext = %@",tabsText);
        dump.numberOfTabs = @(tabsText.integerValue);
    }
    
    for (ONOXMLElement *childElement in [element CSS:@"description"] ) {
        //NSLog(@"ono - child element = %@",childElement.stringValue);
        NSMutableArray *tabsTechTemp = [[NSMutableArray alloc] init];
        NSMutableArray *tabsWorldTemp = [[NSMutableArray alloc] init];
        BOOL tabsTypeRealWorld = NO;
        NSString *categories = @"";
        NSString *readingContent = @"";
        NSMutableArray *categoriesTechTemp = [[NSMutableArray alloc] init];
        NSMutableArray *categoriesWorldTemp = [[NSMutableArray alloc] init];
        
        ONOXMLDocument *responseDocument = [ONOXMLDocument HTMLDocumentWithString:childElement.stringValue encoding:NSUTF8StringEncoding error:nil];
        
        for (ONOXMLElement *tabElement in [responseDocument CSS:@"p"]) {
            //NSLog(@"tabElement=%@",tabElement);
            if ([tabElement.stringValue isEqualToString:@"The Real World"]) {
                tabsTypeRealWorld = YES;
            }
            
            DKTab *tab = [DKTab newTabFromXMLElement:tabElement];
            
            tab.tabDay = tab.tabDay = dump.date;
            
            readingContent = [readingContent stringByAppendingFormat:@" %@",tab.strippedHTML];
            
            if (tab) {
                if (tabsTypeRealWorld) {
                    [tabsWorldTemp addObject:tab];
                }
                else {
                    [tabsTechTemp addObject:tab];
                }
            }
            
            NSString *temp = tab.category;
            NSString *newTemp = [temp stringByReplacingOccurrencesOfString:@":" withString:@""];
            if ((![temp dk_containsString:@"Sponsor"]) && (temp.length>0) && (![categories dk_containsString:newTemp])){
                if (categories.length>0) {
                    categories = [categories stringByAppendingString:@", "];
                }
                categories = [categories stringByAppendingString:newTemp];
                if (tabsTypeRealWorld)
                    [categoriesWorldTemp addObject:newTemp];
                else
                    [categoriesTechTemp addObject:newTemp];
            }
        }
        
        dump.categoriesTech = [categoriesTechTemp copy];
        dump.categoriesWorld = [categoriesWorldTemp copy];
        
        dump.tabsWorld = [tabsWorldTemp copy];
        dump.tabsTech = [tabsTechTemp copy];
        
        __block NSUInteger wordCount = 0;
        [readingContent enumerateSubstringsInRange:NSMakeRange(0, readingContent.length)
                                           options:NSStringEnumerationByWords
                                        usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                            wordCount++;
                                        }];
        NSUInteger wordsPerMin = 270;
        //TODO: handle if this is 0 or 1
        dump.readingTime = [NSString stringWithFormat:@"%tu mins",wordCount/wordsPerMin];    
    }
    
    return dump;
}


#pragma mark - Subclass

- (NSString*)description {
    return [NSString stringWithFormat:@"<%p %@> date=%@, number of tabs=%@, %@ links", self, self.class, self.date, self.numberOfTabs, @(self.tabsTech.count)];
}



#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.date = [decoder decodeObjectForKey:@"date"];
        self.numberOfTabs = [decoder decodeObjectForKey:@"numberOfTabs"];
        self.tabsTech = [decoder decodeObjectForKey:@"tabsTech"];
        self.tabsWorld = [decoder decodeObjectForKey:@"tabsWorld"];
        self.readingTime = [decoder decodeObjectForKey:@"readingTime"];
        
        self.categoriesTech = [decoder decodeObjectForKey:@"categoriesTech"];
        self.categoriesWorld = [decoder decodeObjectForKey:@"categoriesWorld"];
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_date forKey:@"date"];
    [encoder encodeObject:_numberOfTabs forKey:@"numberOfTabs"];
    [encoder encodeObject:_tabsTech forKey:@"tabsTech"];
    [encoder encodeObject:_tabsWorld forKey:@"tabsWorld"];
    [encoder encodeObject:_readingTime forKey:@"readingTime"];
    
    [encoder encodeObject:_categoriesTech forKey:@"categoriesTech"];
    [encoder encodeObject:_categoriesWorld forKey:@"categoriesWorld"];    
}



@end
