//
//  DKListSelectionController.m
//  TabDump
//
//  Created by Daniel on 5/17/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import "DKListSelectionController.h"

// Categories
#import "UIViewController+DK.h"
#import "UIViewController+TD.h"

// Controllers
#import "DKTabDumpsController.h"
#import "DKCategoriesController.h"

// Defines
//#import "DKTabDumpDefines.h"


@interface DKListSelectionController ()
@property (nonatomic,strong) UISegmentedControl *segmentedControl;
@end

@implementation DKListSelectionController

NSUInteger kSegmentedControlTag = 88;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self td_addCloseButtomDismiss];
        
        self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Calendar",@"Categories"]];
        self.segmentedControl.tag = kSegmentedControlTag;
        CGFloat width = 180;
        self.segmentedControl.frame = CGRectMake((320-width)/2, 5, width, 30);
        [self.segmentedControl addTarget:self action:@selector(actionSelect:) forControlEvents:UIControlEventValueChanged];
        
        self.categoriesController = [[DKCategoriesController alloc] init];
        [self dk_addChildController:self.categoriesController];
        
        self.calendarController = [[DKTabDumpsController alloc] init];
        [self dk_addChildController:self.calendarController];
    
        [@[self.calendarController] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIViewController *controller = obj;
            CGRect frame;
            frame = controller.view.frame;
            frame.origin.y = 64;
            frame.size.height -= frame.origin.y;
            controller.view.frame = frame;
        }];
        
        self.segmentedControl.selectedSegmentIndex = 0;
        self.categoriesController.view.hidden = YES;
    }
    return self;
}


#pragma mark - UIViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController.navigationBar addSubview:self.segmentedControl];
}


- (void)viewWillDisappear:(BOOL)animated {
    [self.segmentedControl removeFromSuperview];
    
    [super viewWillDisappear: YES];
}


#pragma mark - Private

- (void)actionSelect:(UISegmentedControl*)control {
    switch (control.selectedSegmentIndex) {
        case 0:
            self.calendarController.view.hidden = NO;
            self.categoriesController.view.hidden = YES;
            break;
            
        default:
            self.calendarController.view.hidden = YES;
            self.categoriesController.view.hidden = NO;
            break;
    }
}


@end
