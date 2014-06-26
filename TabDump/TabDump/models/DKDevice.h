//
//  DKDevice.h
//  TabDump
//
//  Created by Daniel on 6/14/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKDevice : NSObject
+ (BOOL)isIpad;
+ (CGFloat)cellWidth;
+ (CGFloat)padding;
+ (CGFloat)topOffset;

+ (CGFloat)categoriesNumberOfColumns;
+ (CGFloat)categoriesCellHeight;
+ (CGFloat)categoriesCellInset;

+ (CGFloat)headerHeight;
@end
