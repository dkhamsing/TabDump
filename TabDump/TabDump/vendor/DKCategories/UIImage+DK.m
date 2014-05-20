//
//  UIImage+DK.m
//  Demo
//
//  Created by Daniel on 5/3/14.
//
//

#import "UIImage+DK.h"

@implementation UIImage (DK)

+ (UIImage *)dk_maskedImageNamed:(NSString *)name color:(UIColor *)color {
	UIImage *image = [UIImage imageNamed:name];
	CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
	UIGraphicsBeginImageContextWithOptions(rect.size, NO, image.scale);
	CGContextRef c = UIGraphicsGetCurrentContext();
	[image drawInRect:rect];
	CGContextSetFillColorWithColor(c, [color CGColor]);
	CGContextSetBlendMode(c, kCGBlendModeSourceAtop);
	CGContextFillRect(c, rect);
	UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
	return result;
}


@end
