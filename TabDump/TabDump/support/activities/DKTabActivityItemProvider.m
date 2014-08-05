//
//  DKTabActivityItemProvider.m
//  TabDump
//
//  Created by Daniel on 4/28/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import "DKTabActivityItemProvider.h"

@implementation DKTabActivityItemProvider

- (id)initWithText:(NSString*)text {
    self = [super initWithPlaceholderItem:text];
    return self;
}


- (id)item {
    if ([self.placeholderItem isKindOfClass:[NSString class]]) {
        NSString *text = [self.placeholderItem copy];
        if ([self.activityType isEqualToString:UIActivityTypePostToTwitter]) {
            return [DKTabActivityItemProvider twitterShareStringFromText:text];
        }
        return text;
    }
    
    return self.placeholderItem;
}


+ (NSString*)twitterShareStringFromText:(NSString*)text {
    NSString *twitterText = text;
    twitterText = [NSString stringWithFormat:@"\"%@\"",text];
    
    NSUInteger cutOff = 100;
    if (twitterText.length>cutOff) {
        twitterText = [twitterText substringToIndex:cutOff];
        twitterText = [twitterText stringByAppendingString:@"…\""];
    }
    
    twitterText = [twitterText stringByAppendingString:@" via @TabDump"];
    //NSLog(@"twitter tet = %@",twitterText);

    return twitterText;
}


@end
