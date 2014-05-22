//
//  DKListSelectionController.h
//  TabDump
//
//  Created by Daniel on 5/17/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKTabDumpsController;
@class DKCategoriesController;
@interface DKListSelectionController : UIViewController
@property (nonatomic,strong) DKCategoriesController *categoriesController;
@property (nonatomic,strong) DKTabDumpsController *calendarController;
@end
