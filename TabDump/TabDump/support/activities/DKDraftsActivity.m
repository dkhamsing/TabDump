//
//  DKDraftsActivity.m
//  TabDump
//
//  Created by Daniel on 5/3/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import "DKDraftsActivity.h"


NSString *kDraftsURLScheme = @"drafts:";

@implementation DKDraftsActivity

- (NSString *)activityType {
    return @"Drafts";
}


- (NSString *)activityTitle {
    return @"Drafts";
}


- (UIImage *)activityImage {
    return [UIImage imageNamed:@"activity-drafts"];
}


- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    //NSLog(@"%s", __FUNCTION__);
    return YES;
}

/*
- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    //NSLog(@"%s",__FUNCTION__);
}*/


- (UIViewController *)activityViewController {
    //NSLog(@"%s",__FUNCTION__);
    return nil;
}


- (void)performActivity {
    NSString *contentEncoded = [self.content stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    
    NSString *contentString = [NSString stringWithFormat:@"%@//x-callback-url/create?text=%@",kDraftsURLScheme,contentEncoded];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:contentString]];
    
    [self activityDidFinish:YES];
}


@end
