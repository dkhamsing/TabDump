//
//  UIColor+TD.m
//  TabDump
//
//  Created by Daniel on 4/23/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import "UIColor+TD.h"
#import "UIColor+DK.h"
@implementation UIColor (TD)

+ (UIColor*)td_highlightColor {
    return [self dk_colorWithRed:223 green:188 blue:115];
}


+ (UIColor*)td_dayTabCategoryColor { 
    return [self dk_colorWithRed:66 green:66 blue:66];
}


@end
