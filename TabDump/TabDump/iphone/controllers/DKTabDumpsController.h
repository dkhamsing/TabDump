//
//  DKTabDumpsController.h
//  TabDump
//
//  Created by Daniel on 4/22/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKTabDump;
@protocol DKTabDumpsControllerDelegate <NSObject>
- (void)DKTabDumpsControllerSelectedDump:(DKTabDump*)dump;
@end

@interface DKTabDumpsController : UITableViewController
@property (nonatomic,strong) NSArray *dataSource;
@property (nonatomic) id delegate;
@end
