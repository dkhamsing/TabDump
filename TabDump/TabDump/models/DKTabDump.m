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
#import "GTMNSString+HTML.h"
#import "HTMLReader.h"

// Models
#import "DKTab.h"


@implementation DKTabDump

#pragma mark - Public

+ (NSArray*)newListOfDumpsFromHTML:(NSString *)html {
    NSMutableArray *list = [[NSMutableArray alloc] init];
    
    HTMLDocument *document = [HTMLDocument documentWithString:html];
    
    NSArray *items = [document nodesMatchingSelector:@"item"];
    
    for (HTMLElement *element in items) {
        DKTabDump *dump = [DKTabDump newDumpFromHTMLElement:element];
        if (dump) {
            [list addObject:dump];
        }
    }
    
    return [list copy];
}


- (NSString*)title {
    return [NSString stringWithFormat:@"%@: %@ tabs", self.date, self.numberOfTabs];
}


#pragma mark - Private

+ (NSString*)stringByStrippingHTML:(NSString*)input {
    NSRange r;
    NSString *s = input;
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound) {
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    }
    
    s = [s gtm_stringByUnescapingFromHTML];
    
    return s;
}


+ (DKTabDump*)newDumpFromHTMLElement:(HTMLElement*)element {
    DKTabDump *dump = [[DKTabDump alloc] init];
    
    HTMLElement *titleElement = [element firstNodeMatchingSelector:@"title"];
    NSString *titleText = titleElement.innerHTML;
    
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
    
    HTMLElement *descriptionElement = [element firstNodeMatchingSelector:@"description"];
    //    NSLog(@"description html=%@",descriptionElement.innerHTML);
    
    NSArray *list = [descriptionElement nodesMatchingSelector:@"p"];
    //[descriptionElement nodesMatchingParsedSelector:[HTMLSelector selectorForString:@"a"]];
    
    NSMutableArray *tabsTechTemp = [[NSMutableArray alloc] init];
    NSMutableArray *tabsWorldTemp = [[NSMutableArray alloc] init];
    BOOL tabsTypeRealWorld = NO;
    NSString *categories = @"";
    NSString *readingContent = @"";
    NSMutableArray *categoriesTechTemp = [[NSMutableArray alloc] init];
    NSMutableArray *categoriesWorldTemp = [[NSMutableArray alloc] init];
    
    for (HTMLElement *linkElement in list) {
        
        //NSLog(@"link elelemtn=%@",linkElement.innerHTML);
        //if ((linkElement.innerHTML.length>0) && (![linkElement.innerHTML dk_containsString:@"The Real World"])) {
        if (linkElement.innerHTML.length>0) {
            if ([linkElement.innerHTML dk_containsString:@"The Real World"]) {
                tabsTypeRealWorld = YES;
            }
            else {
                
                DKTab *tab = [[DKTab alloc] init];
                
                tab.tabDay = dump.date;
                
                //link.html = linkElement.innerHTML;
                //   NSLog(@"html=%@",link.html);
                
                NSString *temp = linkElement.innerHTML;
                temp = [temp substringFromIndex:[temp rangeOfString:@"href="].location];
                temp = [temp substringToIndex:[temp rangeOfString:@">"].location];
                temp = [temp stringByReplacingOccurrencesOfString:@"href=" withString:@""];
                temp = [temp stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                //NSLog(@"temp=%@",temp);
                tab.urlString = temp;
                
                tab.strippedHTML = [self stringByStrippingHTML:linkElement.innerHTML];
                
                readingContent = [readingContent stringByAppendingFormat:@" %@",tab.strippedHTML];
                //            NSLog(@"stripped=%@",link.strippedHTML);
                temp = tab.strippedHTML;
                NSRange range = [temp rangeOfString:@" "];
                if (range.location != NSNotFound) {
                    temp = [temp substringFromIndex:range.location+1];
                }
                range = [temp rangeOfString:@":"];
                if (range.location != NSNotFound ) {
                    temp = [temp substringToIndex:range.location+1];
                }
                else {
                    temp = @"";
                }
                tab.category = temp;
                tab.categoryOnly = [temp stringByReplacingOccurrencesOfString:@":" withString:@""];
                //            NSLog(@"temp=%@",temp);
                
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
                
                NSString *number = [tab.strippedHTML substringToIndex:[tab.strippedHTML rangeOfString:@" "].location];
                //            NSLog(@"number=%@",number);
                tab.tabNumber = number;
                
                NSString *textToShare = tab.strippedHTML;
                textToShare = [textToShare stringByReplacingOccurrencesOfString:tab.category withString:@""];
                textToShare = [textToShare stringByReplacingOccurrencesOfString:tab.tabNumber withString:@""];
                textToShare = [textToShare stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                tab.tabText = textToShare;
                
                if (tabsTypeRealWorld) {
                    [tabsWorldTemp addObject:tab];
                }
                else {
                    [tabsTechTemp addObject:tab];
                }
            }
        }
    }
    
    //dump.categories = [categoriesTemp copy];
    dump.categoriesTech = [categoriesTechTemp copy];
    dump.categoriesWorld = [categoriesWorldTemp copy];
    
    __block NSUInteger wordCount = 0;
    [readingContent enumerateSubstringsInRange:NSMakeRange(0, readingContent.length)
                                       options:NSStringEnumerationByWords
                                    usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                        wordCount++;
                                    }];
    NSUInteger wordsPerMin = 270;
    //TODO: handle if this is 0 or 1
    dump.readingTime = [NSString stringWithFormat:@"%tu mins",wordCount/wordsPerMin];
    
    dump.tabsWorld = [tabsWorldTemp copy];
    dump.tabsTech = [tabsTechTemp copy];
    
    //dump.allCategories = [categories stringByAppendingString:@"."];
    
    //NSLog(@"categories=%@",categories);
    
    return dump;
}


#pragma mark - Subclass

- (NSString*)description {
    return [NSString stringWithFormat:@"<%p %@> date=%@, number of tabs=%@, %@ links", self, self.class, self.date, self.numberOfTabs, @(self.tabsTech.count)];
}


@end
