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

// Defines
#import "DKTabDumpDefines.h"


@implementation DKTab

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
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:kCellFont,
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 };
    return attributes;
}


- (CGSize)sizeForStrippedHTML {
    CGRect textRect = [self.strippedHTML boundingRectWithSize:CGSizeMake(kCellWidth -kCellPadding*2, 800)
                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                   attributes:[self contentAttributes]
                                                      context:nil];
    return textRect.size;
}


#pragma mark - Private

- (NSArray*)excludedBrands {
    NSArray *brandExcluded = @[
                               @"Qualcomm",
                               @"Snapchat",
                               ];

    return brandExcluded;
}


@end
