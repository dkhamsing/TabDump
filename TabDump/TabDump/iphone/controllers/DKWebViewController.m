//
//  DKWebViewController.m
//  TabDump
//
//  Created by Daniel on 5/27/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import "DKWebViewController.h"

// Categories
#import "UIColor+TD.h"


@implementation DKWebViewController

- (instancetype)initWithURLString:(NSString *)urlString {
    if (self = [self init])
        self = [self initWithURL:[NSURL URLWithString:urlString]];
    
    [self td_setup];
    
    return self;
}


- (void)td_setup {
    self.view.tintColor = [UIColor td_highlightColor];
    self.showUrlWhileLoading = NO;
    self.hideWebViewBoundaries = YES;
    self.title = @"Loading";
}


@end
