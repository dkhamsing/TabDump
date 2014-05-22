//
//  DKDayCell.h
//  TabDump
//
//  Created by Daniel on 4/22/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKTab;
@interface DKDayCell : UITableViewCell
@property (nonatomic,strong) DKTab *link;
@property (nonatomic,strong) UIButton *shareButton;
@property (nonatomic) BOOL isCategory;
@end
