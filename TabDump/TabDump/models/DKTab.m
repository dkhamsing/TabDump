//
//  DKTab.m
//  TabDump
//
//  Created by Daniel on 4/22/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import "DKTab.h"

// Categories
#import "NSString+DK.h"
#import "UIColor+BrandColors.h"
#import "UIFont+TD.h"

// Defines
#import "DKTabDumpDefines.h"

// Libraries
#import "Ono.h"

// Moedls
#import "DKDevice.h"


@implementation DKTab

+ (DKTab*)newTabFromXMLElement:(ONOXMLElement*)element {
    DKTab *tab = [[DKTab alloc] init];
    //NSLog(@"elemt = %@", element);
    
    tab.strippedHTML = element.stringValue;
    //NSLog(@"tab stripped = %@", tab.strippedHTML);
    
    tab.tabNumber = [element firstChildWithCSS:@"a"].stringValue;
    if (!tab.tabNumber)
        return nil;
    //NSLog(@"tab number=%@",tab.tabNumber);
    
    tab.urlString = [element firstChildWithXPath:
                     [NSString stringWithFormat:@"//a[text()='%@']/@href", tab.tabNumber]
                     ].stringValue;
    //NSLog(@"tab url = %@",tab.urlString);
    
    // category
    NSString *temp = tab.strippedHTML;
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

    //tabtext
    NSString *textToShare = tab.strippedHTML;
    textToShare = [textToShare stringByReplacingOccurrencesOfString:tab.category withString:@""];
    textToShare = [textToShare stringByReplacingOccurrencesOfString:tab.tabNumber withString:@""];
    textToShare = [textToShare stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    tab.tabText = textToShare;
    
    return tab;
}


- (BOOL)brandColorIsDark {
    if ([[UIColor bc_brandsWithDarkColor] containsObject:self.categoryOnly]) {
        
        if ([[self excludedBrands] containsObject:self.categoryOnly]) {
            return NO;
        }
        
        return YES;
    }
    return NO;
}


- (UIColor*)colorForCategory {
    UIColor *color = [UIColor bc_colorForBrand:self.categoryOnly];
    
    if (color == BC_DEFAULT_COLOR) {
        color = [UIColor whiteColor];
    }
       
    if ([[self excludedBrands] containsObject:self.categoryOnly]) {
        return [UIColor whiteColor];
    }
    
    return color;
}


- (NSDictionary*)contentAttributes {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5.45;
    if ([DKDevice isIpad])
        paragraphStyle.lineSpacing = 12;
    
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    attributes[NSParagraphStyleAttributeName] = paragraphStyle;
    attributes[NSFontAttributeName] = [UIFont td_fontFromSettings];
    
    return [attributes copy];
}


- (CGSize)sizeForTabText {    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self.tabText attributes:self.contentAttributes];
    CGRect textRect = [attributedString boundingRectWithSize:CGSizeMake([DKDevice cellWidth] -[DKDevice padding]*2, 800)
                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                      context:nil];
    return textRect.size;
}


- (CGFloat)heightForRow {
    CGFloat height = [DKDevice topOffset] +kCellHeightCategory +[self sizeForTabText].height +kCellBottomOffset;
    
    return height;
}


#pragma mark - Private

- (NSArray*)excludedBrands {
    NSArray *brandExcluded = @[
                               @"Snapchat",
                               @"Sprint",
                               ];

    return brandExcluded;
}


#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.tabDay = [decoder decodeObjectForKey:@"tabDay"];
        self.tabNumber = [decoder decodeObjectForKey:@"tabNumber"];
        self.category = [decoder decodeObjectForKey:@"category"];
        self.categoryOnly = [decoder decodeObjectForKey:@"categoryOnly"];
        self.strippedHTML = [decoder decodeObjectForKey:@"strippedHTML"];
        self.tabText = [decoder decodeObjectForKey:@"tabText"];
        self.urlString = [decoder decodeObjectForKey:@"urlString"];
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_tabDay forKey:@"tabDay"];
    [encoder encodeObject:_tabNumber forKey:@"tabNumber"];
    [encoder encodeObject:_category forKey:@"category"];
    [encoder encodeObject:_categoryOnly forKey:@"categoryOnly"];
    [encoder encodeObject:_strippedHTML forKey:@"strippedHTML"];
    [encoder encodeObject:_tabText forKey:@"tabText"];
    [encoder encodeObject:_urlString forKey:@"urlString"];
}


@end
