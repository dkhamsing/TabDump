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
                      @"Adobe",
                      @"Airbnb",
                      @"Amazon",
                      @"AOL",
                      @"Apple",
                      @"ARM",
                      @"AT&T",
                      
                      @"Dish Network",
                      @"Dropbox",
                      
                      @"eBay",
                      @"Evernote",
                      
                      @"Facebook",
                      @"Flipkart",
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
                      @"Nintendo",
                      @"Nokia",
                      @"NVIDIA",
                      
                      @"PayPal",
                      
                      @"Qualcomm",
                      
                      @"Rovio",
                      
                      @"Samsung",
                      @"Snapchat",
                      @"Spotify",
                      @"Sprint",
                      @"SoftBank",
                      @"Staples",
                      
                      @"T-Mobile",
                      @"Tumblr",
                      @"Twitter",
                      
                      @"Uber",
                      
                      @"Verizon",
                      @"Vimeo",
                      @"Vine",
                      @"VSCO",
                      
                      @"WhatsApp",
                      
                      @"Xiaomi",
                      
                      @"Yahoo!",
                      @"Yelp",
                      
                      @"ZTE",
                      ];
    
    return list;
}


+ (UIColor*)bc_colorForBrand:(NSString*)brand {
    UIColor *brandColor = BC_DEFAULT_COLOR;
    
    if ([self brand:brand matches:@"Alibaba"]) {
        return [UIColor dk_colorWithRed:255 green:115 blue:0];
    }
    
    if ([self brand:brand matches:@"Adobe"]) {
        return [UIColor dk_colorWithHexString:@"#ff0000"];
    }
    
    if ([self brand:brand matches:@"Airbnb"]) {
        return [UIColor dk_colorWithRed:0 green:196 blue:255];
    }
    
    if ([self brand:brand matches:@"Apple"]) {
        return [UIColor dk_colorWithRed:119 green:119 blue:119];
    }

    if ([self brand:brand matches:@"Amazon"]) {
        return [UIColor dk_colorWithHexString:@"#ff9900"];
    }
    
    if ([self brand:brand matches:@"AOL"]) {
        return [UIColor dk_colorWithHexString:@"#00c4ff"];
    }

    if ([self brand:brand matches:@"ARM"]) {
        return [UIColor dk_colorWithRed:0 green:132 blue:171];
    }
    
    if ([self brand:brand matches:@"AT&T"]) {
        return [UIColor dk_colorWithRed:255 green:151 blue:0];
    }
    
    if ([self brand:brand matches:@"Dish Network"]) {
        return [UIColor dk_colorWithRed:218 green:18 blue:29];
    }
    
    if ([self brand:brand matches:@"Dropbox"]) {
        return [UIColor dk_colorWithHexString:@"#007ee5"];
    }
    
    if ([self brand:brand matches:@"eBay"]) {
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
    
    if ([self brand:brand matches:@"Evernote"]) {
        return [UIColor dk_colorWithHexString:@"#7ac142"];
    }
    
    if ([self brand:brand matches:@"Facebook"]) {
        return [UIColor dk_colorWithHexString:@"#3b5998"];
    }
    
    if ([self brand:brand matches:@"Flipkart"]) {
        return [UIColor dk_colorWithRed:0 green:83 blue:135];
    }
    
    if ([self brand:brand matches:@"Foxconn"]) {
        return [UIColor dk_colorWithRed:30 green:90 blue:160];
    }
    
    if ([self brand:brand matches:@"Foursquare"]) {
        return [UIColor dk_colorWithHexString:@"#0cbadf"];
    }
    
    if ([self brand:brand matches:@"Google"]) {
        return [UIColor dk_colorWithHexString:@"#4285f4"];
    }
    
    if ([self brand:brand matches:@"HP"]) {
        return [UIColor dk_colorWithHexString:@"#0096d6"];
    }
    
    if ([self brand:brand matches:@"HTC"]) {
        return [UIColor dk_colorWithRed:105 green:180 blue:15];
    }

    if ([self brand:brand matches:@"Huawei"]) {
        return [UIColor dk_colorWithRed:214 green:45 blue:36];
    }
    
    if ([self brand:brand matches:@"Foxconn"]) {
        return [UIColor dk_colorWithRed:30 green:90 blue:160];
    }
    
    if ([self brand:brand matches:@"IBM"]) {
        return [UIColor dk_colorWithHexString:@"#003e6a"];
    }
    
    if ([self brand:brand matches:@"Intel"]) {
        return [UIColor dk_colorWithHexString:@"#0071c5"];
    }
    
    if ([self brand:brand matches:@"LG"]) {
        return [UIColor dk_colorWithRed:178 green:14 blue:80];
    }
    
    if ([self brand:brand matches:@"LinkedIn"]) {
        return [UIColor dk_colorWithHexString:@"#0e76a8"];
    }
    
    if ([self brand:brand matches:@"LINE"]) {
        return [UIColor dk_colorWithRed:29 green:205 blue:0];
    }
    
    if ([self brand:brand matches:@"Microsoft"]) {
        return [UIColor dk_colorWithHexString:@"#00a1f1"];
    }
    
    if ([self brand:brand matches:@"Motorola"]) {
        return [UIColor dk_colorWithRed:92 green:146 blue:250];
    }
    
    if ([self brand:brand matches:@"Netflix"]) {
        return [UIColor dk_colorWithHexString:@"#b9070a"];
    }
    
    if ([self brand:brand matches:@"Nintendo"]) {
        return [UIColor dk_colorWithRed:140 green:140 blue:140];
    }

    if ([self brand:brand matches:@"Nokia"]) {
        return [UIColor dk_colorWithHexString:@"#183693"];
    }
    
    if ([self brand:brand matches:@"NVIDIA"]) {
        return [UIColor dk_colorWithRed:119 green:185 blue:0];
    }
    
    if ([self brand:brand matches:@"PayPal"]) {
        return [UIColor dk_colorWithHexString:@"#3b7bbf"];
    }
    
    if ([self brand:brand matches:@"Qualcomm"]) {
        return [UIColor dk_colorWithRed:27 green:32 blue:33];
    }
    
    if ([self brand:brand matches:@"Rovio"]) {
        return [UIColor dk_colorWithRed:192 green:34 blue:39];
    }
    
    if ([self brand:brand matches:@"Samsung"]) {
        return [UIColor dk_colorWithHexString:@"#0c4da2"];
    }
    
    if ([self brand:brand matches:@"Snapchat"]) {
        return [UIColor dk_colorWithRed:255 green:252 blue:0];
    }
    
    if ([self brand:brand matches:@"Spotify"]) {
        return [UIColor dk_colorWithHexString:@"#81b71a"];
    }
    
    if ([self brand:brand matches:@"Sprint"]) {
        return [UIColor dk_colorWithHexString:@"#fee100"];
    }
    
    if ([self brand:brand matches:@"SoftBank"]) {
        return [UIColor dk_colorWithRed:186 green:188 blue:190];
    }
    
    if ([self brand:brand matches:@"Staples"]) {
        return [UIColor dk_colorWithHexString:@"#cc0000"];
    }
    
    if (
        ([self brand:brand matches:@"T-Mobile"]) ||
        ([self brand:brand matches:@"TMobile"])
        ) {
        return [UIColor dk_colorWithHexString:@"#ea0a8e"];
    }
    
    if ([self brand:brand matches:@"Twitter"]) {
        return [UIColor dk_colorWithHexString:@"#55acee"];
    }
    
    if ([self brand:brand matches:@"Tumblr"]) {
        return [UIColor dk_colorWithHexString:@"#34526f"];
    }
    
    if ([self brand:brand matches:@"Uber"]) {
        return [UIColor dk_colorWithRed:28 green:168 blue:195];
    }
    
    if ([self brand:brand matches:@"Verizon"]) {
        return [UIColor dk_colorWithHexString:@"#ef1d1d"];
    }
    
    if ([self brand:brand matches:@"Vimeo"]) {
        return [UIColor dk_colorWithHexString:@"#44bbff"];
    }
    
    if ([self brand:brand matches:@"Vine"]) {
        return [UIColor dk_colorWithHexString:@"#00a478"];
    }
    
    if ([self brand:brand matches:@"VSCO"]) {
        return [UIColor dk_colorWithRed:170 green:169 blue:76];
    }

    if ([self brand:brand matches:@"WhatsApp"]) {
        return [UIColor dk_colorWithRed:52 green:175 blue:35];
    }
    
    if ([self brand:brand matches:@"Xiaomi"]) {
        return [UIColor dk_colorWithRed:255 green:74 blue:3];
    }
    
    if ([self brand:brand matches:@"Yahoo"]) {
        return [UIColor dk_colorWithHexString:@"#720e9e"];
    }
    
    if ([self brand:brand matches:@"Yelp"]) {
        return [UIColor dk_colorWithHexString:@"#c41200"];
    }
    
    if ([self brand:brand matches:@"ZTE"]) {
        return [UIColor dk_colorWithRed:10 green:80 blue:160];
    }
    
    return brandColor;
}


#pragma mark - Private

+ (BOOL)brand:(NSString*)brand matches:(NSString *)string {
    brand = brand.lowercaseString;
    string = string.lowercaseString;
    return !NSEqualRanges([brand rangeOfString:string], NSMakeRange(NSNotFound, 0));
}


+ (UIColor*)dk_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1.0f];
}


+ (UIColor *)dk_colorWithHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // skip '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}


@end
