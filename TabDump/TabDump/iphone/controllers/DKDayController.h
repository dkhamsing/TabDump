//
//  DKDayController.h
//  TabDump
//
//  Created by Daniel on 4/22/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DKDayControllerDelegate
- (void)DKDayControllerDidScroll;
- (void)DKDayControllerScrolledToTop;
- (void)DKDayControllerRequestRefresh;
@end

@class DKTabDump;
@interface DKDayController : UITableViewController
@property (nonatomic,strong) DKTabDump *dump;
@property (nonatomic) id delegate;
- (void)scrollToNextTab;
- (void)scrollToTop;
@end
