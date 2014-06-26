//
//  DKDevice.m
//  TabDump
//
//  Created by Daniel on 6/14/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import "DKDevice.h"
#import "DKTabDumpDefines.h"

@implementation DKDevice

+ (BOOL)isIpad {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return YES;
    
    return NO;
}


+ (CGFloat)cellWidth {
    if ([self isIpad])
        return kPadCellWidth;
    
    return kCellWidth;
}


+ (CGFloat)padding {
    if ([self isIpad])
        return kPadCellPadding;

    return kCellPadding;
}


+ (CGFloat)topOffset {
    if ([self isIpad])
        return kPadCellTopOffset;
    
    return kCellTopOffset;
}


+ (CGFloat)categoriesNumberOfColumns {
    if ([self isIpad])
        return 3.0;
    
    return 2.0;    
}


+ (CGFloat)categoriesCellHeight {
    if ([self isIpad])
        return 120.0;
    
    return 80.0;
}


+ (CGFloat)categoriesCellInset {
    if ([self isIpad])
        return 40.0;
    
    return 20.0;
}


+ (CGFloat)headerHeight {
    if ([self isIpad])
        return 300.0;

    return 190;
}


@end
