//
//  UIColor+DK.h
//  DealSpotr
//
//  Created by Daniel on 4/24/14.
//  Copyright (c) 2014 ZipfWorks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (DK)

/**
 Get the Facebook color.
 */
+ (UIColor*)dk_facebookColor;


#pragma mark - Helpers

/**
 Get a color with RGB.
 @param red Red.
 @param blue Blue.
 @param green Green.
 */
+ (UIColor*)dk_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;


/**
 Get a color with a hex code.
 @param hexString String value of the hex code.
 */
+ (UIColor *)dk_colorWithHexString:(NSString *)hexString;


@end
