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
    NSArray *brands = @[
                        @"Facebook",
                        @"Yahoo!"
                        ];
    
    __block BOOL retVal = NO;
    [brands enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([self.category dk_containsString:obj]) {
            //NSLog(@"found category %@ to be dark", self.category);
            retVal = YES;
            *stop = YES;
        }
    }];
    
    if (retVal) {
        return YES;
    }
    
    return NO;
}


- (UIColor*)colorForCategory {
    UIColor *color = [UIColor bc_colorForBrand:self.categoryOnly];
    
    if (color == BC_DEFAULT_COLOR) {
        color = [UIColor whiteColor];
    }
    
    NSArray *brandExcluded = @[
                               @"Qualcomm",
                               @"Snapchat",
                               ];
    if ([brandExcluded containsObject:self.categoryOnly]) {
        return [UIColor whiteColor];
    }
    
    return color;
}


- (NSDictionary*)contentAttributes {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    
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


@end
