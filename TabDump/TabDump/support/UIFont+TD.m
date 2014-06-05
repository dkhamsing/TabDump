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

@implementation UIFont (TD)

+ (UIFont*)td_fontFromSettings {
    NSNumber *largerText = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsSettingsLargeTextSize];
    if ([largerText isEqual:@1])
        return [UIFont fontWithName:kFontRegular size:18];
    
    return [UIFont fontWithName:kFontRegular size:14];
}


@end
