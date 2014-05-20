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
        [list addObject:dump];
    }
    
    return [list copy];
}

/*
- (CGSize)sizeForContent {
    CGFloat padding=10;
    CGRect textRect = [self.allCategories boundingRectWithSize:CGSizeMake(320 -padding*2, 500)
                                                         options:NSStringDrawingUsesLineFragmentOrigin
                                                      attributes:@{NSFontAttributeName:kListFont}
                                                         context:nil];
    return textRect.size;    
}*/


- (NSString*)title {
    return [NSString stringWithFormat:@"%@: %@ tabs", self.date, self.numberOfTabs];
}


#pragma mark - Private

+ (NSString*)stringByStrippingHTML:(NSString*)input {
    NSRange r;
    NSString *s = input;
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    
    //s = [s stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    
    s = [s gtm_stringByUnescapingFromHTML];
    
    return s;
}


+ (DKTabDump*)newDumpFromHTMLElement:(HTMLElement*)element {
    DKTabDump *dump = [[DKTabDump alloc] init];
    
    HTMLElement *titleElement = [element firstNodeMatchingSelector:@"title"];
    NSString *titleText = titleElement.innerHTML;
    //NSLog(@"title Text = %@",titleText);
    
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
    
    NSMutableArray *linksTemp = [[NSMutableArray alloc] init];
    NSString *categories = @"";
    NSString *readingContent = @"";
    for (HTMLElement *linkElement in list) {
        
        //NSLog(@"link elelemtn=%@",linkElement.innerHTML);
        if ((linkElement.innerHTML.length>0) && (![linkElement.innerHTML dk_containsString:@"The Real World"])) {
            DKTab *link = [[DKTab alloc] init];
            //link.html = linkElement.innerHTML;
            //   NSLog(@"html=%@",link.html);
            
            NSString *temp = linkElement.innerHTML;
            temp = [temp substringFromIndex:[temp rangeOfString:@"href="].location];
            temp = [temp substringToIndex:[temp rangeOfString:@">"].location];
            temp = [temp stringByReplacingOccurrencesOfString:@"href=" withString:@""];
            temp = [temp stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            //NSLog(@"temp=%@",temp);
            link.urlString = temp;
            
            link.strippedHTML = [self stringByStrippingHTML:linkElement.innerHTML];
            
            readingContent = [readingContent stringByAppendingFormat:@" %@",link.strippedHTML];
            //            NSLog(@"stripped=%@",link.strippedHTML);
            temp = link.strippedHTML;
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
            link.category = temp;
            link.categoryOnly = [temp stringByReplacingOccurrencesOfString:@":" withString:@""];
            //            NSLog(@"temp=%@",temp);
            
            NSString *newTemp = [temp stringByReplacingOccurrencesOfString:@":" withString:@""];
            if ((![temp dk_containsString:@"Sponsor"]) && (temp.length>0) && (![categories dk_containsString:newTemp])){
                if (categories.length>0) {
                    categories = [categories stringByAppendingString:@", "];
                }
                categories = [categories stringByAppendingString:newTemp];
            }            
            
            NSString *number = [link.strippedHTML substringToIndex:[link.strippedHTML rangeOfString:@" "].location];
            //            NSLog(@"number=%@",number);
            link.tabNumber = number;
            
            NSString *textToShare = link.strippedHTML;
            textToShare = [textToShare stringByReplacingOccurrencesOfString:link.category withString:@""];
            textToShare = [textToShare stringByReplacingOccurrencesOfString:link.tabNumber withString:@""];
            textToShare = [textToShare stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            link.tabText = textToShare;
                        
            [linksTemp addObject:link];
        }
    }
    
    __block NSUInteger wordCount = 0;
    [readingContent enumerateSubstringsInRange:NSMakeRange(0, readingContent.length)
                                       options:NSStringEnumerationByWords
                                    usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                        wordCount++;
                                    }];
    NSUInteger wordsPerMin = 270;
    dump.readingTime = [NSString stringWithFormat:@"%d mins",wordCount/wordsPerMin];
    
    dump.links = [linksTemp copy];
    
    //dump.allCategories = [categories stringByAppendingString:@"."];
    
    //NSLog(@"categories=%@",categories);
    
    return dump;
}


#pragma mark - Subclass

- (NSString*)description {
    return [NSString stringWithFormat:@"<%p %@> date=%@, number of tabs=%@, %@ links", self, self.class, self.date, self.numberOfTabs, @(self.links.count)];
}


@end
