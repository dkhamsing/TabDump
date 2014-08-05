//
//  DKBufferActivity.m
//  TabDump
//
//  Created by Daniel on 4/28/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import "DKBufferActivity.h"


NSString *kBufferURLScheme = @"bufferapp://";

@implementation DKBufferActivity

- (NSString *)activityType {
    return @"Buffer";
}


- (NSString *)activityTitle {
    return @"Buffer";
}


- (UIImage *)activityImage {
    return [UIImage imageNamed:@"activity-buffer"];
}


- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    //NSLog(@"%s", __FUNCTION__);
    return YES;
}


/*
- (void)prepareWithActivityItems:(NSArray *)activityItems {
    //NSLog(@"%s",__FUNCTION__);
}*/


- (UIViewController *)activityViewController {
    //NSLog(@"%s",__FUNCTION__);
    return nil;
}


- (void)performActivity {
    NSString *encodedText = [self encodeString:self.text];
    
    NSString *encodedUrl = [self encodeString:self.url];
    
    NSString *bufferString = [NSString stringWithFormat:@"%@?t=%@&u=%@",kBufferURLScheme,encodedText,encodedUrl];
    
    //NSLog(@"open buffer with %@",bufferString);
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:bufferString]];    
    
    [self activityDidFinish:YES];
}


- (NSString*)encodeString:(NSString*)unencodedString {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                 NULL,
                                                                                 (CFStringRef)unencodedString,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                 kCFStringEncodingUTF8 ));
}


@end
