//
//  UIViewController+TD.m
//  TabDump
//
//  Created by Daniel on 5/12/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import "UIViewController+TD.h"

// Categories
#import "UIColor+TD.h"
#import "UIImage+DK.h"

// Defines
#import "DKTabDumpDefines.h"


@implementation UIViewController (TD)

/*
- (void)td_addBackButtonPop {
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top-left"] style:UIBarButtonItemStylePlain target:self action:@selector(ds_actionPop)];
    
    UIBarButtonItem *spacerBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spacerBarButton.width = -10;
    
    self.navigationItem.leftBarButtonItems = @[spacerBarButton,backBarButtonItem];
}*/


- (void)td_addCloseButtomDismiss {
    // navigation buttons
    UIImage *xImage = [UIImage dk_maskedImageNamed:@"top-x" color:[UIColor td_highlightColor]];
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [closeButton setImage:xImage forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(ds_actionDismiss) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *closeBarButton = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    
    UIBarButtonItem *spacerBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spacerBarButton.width = -14;
    
    self.navigationItem.leftBarButtonItems = @[spacerBarButton, closeBarButton];
    
}


- (void)td_updateBackgroundColorForNightMode {
    NSNumber *nightMode = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsSettingsNightMode];
    
    if ([nightMode isEqual:@1]) {
        self.view.backgroundColor = [UIColor blackColor];
    }
    else {
        self.view.backgroundColor = [UIColor whiteColor];
    }    
}


#pragma mark - Private
/*
- (void)ds_actionPop {
    [self.navigationController popViewControllerAnimated:YES];
}*/


- (void)ds_actionDismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
