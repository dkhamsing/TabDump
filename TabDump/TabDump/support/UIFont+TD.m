//
//  UIFont+TD.m
//  TabDump
//
//  Created by Daniel on 5/27/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import "UIFont+TD.h"

// Defines
#import "DKTabDumpDefines.h"

// Models
#import "DKDevice.h"


@implementation UIFont (TD)

+ (UIFont*)td_fontFromSettings {
    NSNumber *largerText = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsSettingsLargeTextSize];
    if ([largerText isEqual:@1])
        return [self fontLarge];
    
    return [self fontSmall];
}


+ (UIFont*)fontLarge {
    CGFloat fontSize=18;
    
    if ([DKDevice isIpad])
        fontSize = 22;
        
    return [UIFont fontWithName:kFontRegular size:fontSize];
}


+ (UIFont*)fontSmall {
    CGFloat fontSize=14;
    
    if ([DKDevice isIpad])
        fontSize = 18;
    
    return [UIFont fontWithName:kFontRegular size:fontSize];
}


@end
