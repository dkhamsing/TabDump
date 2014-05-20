//
//  UIColor+BrandColors.m
//  BrandColors
//
//  Created by Daniel on 5/2/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import "UIColor+BrandColors.h"


@implementation UIColor (BrandColors)

#pragma mark - Public

+ (NSArray*)bc_brands {
    NSArray *list = @[
                      @"Alibaba",
                      @"Amazon",
                      @"AOL",
                      @"AT&T",
                      
                      @"Dropbox",
                      
                      @"eBay",
                      
                      @"Facebook",
                      @"Foursquare",
                      @"Foxconn",
                      
                      @"Google",
                      
                      @"HP",
                      @"HTC",
                      @"Huawei",
                      
                      @"IBM",
                      @"Intel",
                      
                      @"LG",
                      @"LinkedIn",
                      @"LINE",
                      
                      @"Microsoft",
                      @"Motorola",
                      
                      @"Netflix",
                      
                      @"PayPal",
                      
                      @"Qualcomm",
                      
                      @"Samsung",
                      @"Snapchat",
                      @"Spotify",
                      @"Sprint",
                      @"Staples",
                      
                      @"T-Mobile USA",
                      @"Tumblr",
                      @"Twitter",
                      
                      @"Uber",
                      
                      @"Verizon",
                      @"Vimeo",
                      @"Vine",
                      
                      @"Xiaomi",
                      
                      @"Yahoo!",
                      @"Yelp"
                      ];
    
    return list;
}


+ (UIColor*)bc_colorForBrand:(NSString*)brand {
    UIColor *brandColor = BC_DEFAULT_COLOR;
    
    if ([brand isEqualToString:@"Alibaba"]) {
        return [UIColor dk_colorWithRed:255 green:115 blue:0];
    }
    
    if ([brand isEqualToString:@"Amazon"]) {
        //NSLog(@"set amazon background");
        return [UIColor dk_colorWithHexString:@"#ff9900"];
    }
    
    if ([brand isEqualToString:@"AOL"]) {
        return [UIColor dk_colorWithHexString:@"#00c4ff"];
    }
    
    if ([brand isEqualToString:@"AT&T"]) {
        return [UIColor dk_colorWithRed:255 green:151 blue:0];
    }
    
    
    if ([brand isEqualToString:@"Dropbox"]) {
        return [UIColor dk_colorWithHexString:@"#007ee5"];
    }
    
    if ([brand isEqualToString:@"eBay"]) {
        /* idea: random colors.. maybe not so fun in practice
         NSArray *ebayColors = @[
         @"#e53238",
         @"#0064d2",
         @"#f5af02",
         @"#86b817",
         ];
         
         return [UIColor dk_colorWithHexString: ebayColors[arc4random()%ebayColors.count] ];
         */
        return [UIColor dk_colorWithHexString:@"#e53238"];
    }
    
    if ([brand isEqualToString:@"Facebook"]) {
        return [UIColor dk_colorWithHexString:@"#3b5998"];
    }
    
    if ([brand isEqualToString:@"Foxconn"]) {
        return [UIColor dk_colorWithRed:30 green:90 blue:160];
    }
    
    if ([brand isEqualToString:@"Foursquare"]) {
        return [UIColor dk_colorWithHexString:@"#0cbadf"];
    }
    
    if ([brand isEqualToString:@"Google"]) {
        return [UIColor dk_colorWithHexString:@"#4285f4"];
    }
    
    if ([brand isEqualToString:@"HP"]) {
        return [UIColor dk_colorWithHexString:@"#0096d6"];
    }
    
    if ([brand isEqualToString:@"HTC"]) {
        return [UIColor dk_colorWithRed:105 green:180 blue:15];
    }

    if ([brand isEqualToString:@"Huawei"]) {
        return [UIColor dk_colorWithRed:214 green:45 blue:36];
    }
    
    if ([brand isEqualToString:@"Foxconn"]) {
        return [UIColor dk_colorWithRed:30 green:90 blue:160];
    }
    
    if ([brand isEqualToString:@"IBM"]) {
        return [UIColor dk_colorWithHexString:@"#003e6a"];
    }
    
    if ([brand isEqualToString:@"Intel"]) {
        return [UIColor dk_colorWithHexString:@"#0071c5"];
    }
    
    if ([brand isEqualToString:@"LG"]) {
        return [UIColor dk_colorWithRed:178 green:14 blue:80];
    }
    
    if ([brand isEqualToString:@"LinkedIn"]) {
        return [UIColor dk_colorWithHexString:@"#0e76a8"];
    }
    
    if ([brand isEqualToString:@"LINE"]) {
        return [UIColor dk_colorWithRed:29 green:205 blue:0];
    }
    
    if ([brand isEqualToString:@"Microsoft"]) {
        return [UIColor dk_colorWithHexString:@"#00a1f1"];
    }
    
    if ([brand isEqualToString:@"Motorola"]) {
        return [UIColor dk_colorWithRed:92 green:146 blue:250];
    }
    
    if ([brand isEqualToString:@"Netflix"]) {
        return [UIColor dk_colorWithHexString:@"#b9070a"];
    }
    
    if ([brand isEqualToString:@"PayPal"]) {
        return [UIColor dk_colorWithHexString:@"#3b7bbf"];
    }
    
    if ([brand isEqualToString:@"Qualcomm"]) {
        return [UIColor dk_colorWithRed:27 green:32 blue:33];
    }
    
    if ([brand isEqualToString:@"Samsung"]) {
        return [UIColor dk_colorWithHexString:@"#0c4da2"];
    }
    
    if ([brand isEqualToString:@"Snapchat"]) {
        return [UIColor dk_colorWithRed:255 green:252 blue:0];
    }
    
    if ([brand isEqualToString:@"Spotify"]) {
        return [UIColor dk_colorWithHexString:@"#81b71a"];
    }
    
    if ([brand isEqualToString:@"Sprint"]) {
        return [UIColor dk_colorWithHexString:@"#fee100"];
    }
    
    if ([brand isEqualToString:@"Staples"]) {
        return [UIColor dk_colorWithHexString:@"#cc0000"];
    }
    
    if ([brand isEqualToString:@"T-Mobile USA"]) {
        return [UIColor dk_colorWithHexString:@"#ea0a8e"];
    }
    
    if ([brand isEqualToString:@"Twitter"]) {
        return [UIColor dk_colorWithHexString:@"#55acee"];
    }
    
    if ([brand isEqualToString:@"Tumblr"]) {
        return [UIColor dk_colorWithHexString:@"#34526f"];
    }
    
    if ([brand isEqualToString:@"Uber"]) {
        return [UIColor dk_colorWithRed:28 green:168 blue:195];
    }
    
    if ([brand isEqualToString:@"Verizon"]) {
        return [UIColor dk_colorWithHexString:@"#ef1d1d"];
    }
    
    if ([brand isEqualToString:@"Vimeo"]) {
        return [UIColor dk_colorWithHexString:@"#44bbff"];
    }
    
    if ([brand isEqualToString:@"Vine"]) {
        return [UIColor dk_colorWithHexString:@"#00a478"];
    }
    
    if ([brand isEqualToString:@"Xiaomi"]) {
        return [UIColor dk_colorWithRed:255 green:74 blue:3];
    }
    
    if ([brand isEqualToString:@"Yahoo!"]) {
        return [UIColor dk_colorWithHexString:@"#720e9e"];
    }
    
    if ([brand isEqualToString:@"Yelp"]) {
        return [UIColor dk_colorWithHexString:@"#c41200"];
    }
    
    return brandColor;
}


#pragma mark - Private

+ (UIColor*)dk_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    return [UIColor colorWithRed:red/255 green:green/255 blue:blue/255 alpha:1];
}


+ (UIColor *)dk_colorWithHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // skip '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}


@end
