//
//  UIColor+TD.m
//  TabDump
//
//  Created by Daniel on 4/23/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import "UIColor+TD.h"

@implementation UIColor (TD)

+ (UIColor*)td_highlightColor {
    return [self rgbWithRed:223 green:188 blue:115];
}


#pragma mark - Private
+ (UIColor*)rgbWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    return [UIColor colorWithRed:red/255 green:green/255 blue:blue/255 alpha:1];
}

@end
