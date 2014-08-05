//
//  DKBufferActivity.h
//  TabDump
//
//  Created by Daniel on 4/28/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *kBufferURLScheme;

@interface DKBufferActivity : UIActivity
@property (nonatomic,strong) NSString *text;
@property (nonatomic,strong) NSString *url;
@end
