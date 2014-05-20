//
//  UIViewController+TD.m
//  TabDump
//
//  Created by Daniel on 5/12/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import "UIViewController+TD.h"

@implementation UIViewController (TD)

- (void)td_addBackButtonPop {
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top-left"] style:UIBarButtonItemStylePlain target:self action:@selector(ds_actionPop)];
    
    UIBarButtonItem *spacerBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spacerBarButton.width = -10;
    
    self.navigationItem.leftBarButtonItems = @[spacerBarButton,backBarButtonItem];
}


- (void)ds_actionPop {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
