//
//  DKRoundedLabel.h
//  TabDump
//
//  Created by Daniel on 6/13/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKRoundedLabel : UILabel
@property (nonatomic, strong) NSString *dk_text;
+ (UIFont*)roundedLabelFont;
@end
