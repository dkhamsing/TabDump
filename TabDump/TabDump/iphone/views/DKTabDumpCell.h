//
//  DKTabDumpCell.h
//  TabDump
//
//  Created by Daniel on 4/23/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKTabDump;
@class DKTab;
@interface DKTabDumpCell : UITableViewCell
- (void)setupWithDump:(DKTabDump*)dump link:(DKTab*)link;
@end
