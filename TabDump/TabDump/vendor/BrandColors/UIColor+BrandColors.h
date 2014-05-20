//
//  UIColor+BrandColors.h
//  BrandColors
//
//  Created by Daniel on 5/2/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BC_DEFAULT_COLOR [UIColor clearColor]

@interface UIColor (BrandColors)

/**
 List of brands that have brand colors.
 */
+ (NSArray*)bc_brands;


/**
 Get color from brand name.
 Hex colors are from http://brandcolors.net
 @param brand Name of the brand.
 */
+ (UIColor*)bc_colorForBrand:(NSString*)brand;


@end
