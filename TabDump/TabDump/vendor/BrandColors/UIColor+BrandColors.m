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
                      @"Acer",
                      @"Alibaba",
                      @"Adobe",
                      @"Airbnb",
                      @"Amazon",
                      @"AOL",
                      @"Apple",
                      @"ARM",
                      @"AT&T",
                      
                      @"BBC",
                      @"Beats",
                      @"Blizzard",
                      @"Box",
                      @"Broadcom",
                      @"BT",
                      @"BuzzFeed",
                      
                      @"China Mobile",
                      @"Cisco",
                      @"Corning",
                      
                      @"Dell",
                      @"DirecTV",
                      @"Dish Network",
                      @"Dropbox",
                      
                      @"eBay",
                      @"Ericsson",
                      @"Evernote",
                      @"Expedia",
                      
                      @"Facebook",
                      @"FedEx",
                      @"Fitbit",
                      @"Flipkart",
                      @"Foursquare",
                      @"Foxconn",
                      
                      @"General Electric",
                      @"Google",
                      @"GoPro",
                      
                      @"HP",
                      @"HTC",
                      @"Huawei",
                      
                      @"IBM",
                      @"iHeartRadio",
                      @"Instagram",
                      @"Intel",
                      
                      @"LG",
                      @"LinkedIn",
                      @"LINE",
                      @"Lyft",
                      
                      @"Microsoft",
                      @"Motorola",
                      @"Mozilla",
                      
                      @"Netflix",
                      @"Nest",
                      @"Nintendo",
                      @"Nokia",
                      @"NTT DoCoMo",
                      @"NVIDIA",
                      
                      @"Opera",
                      
                      @"Panasonic",
                      @"PayPal",
                      @"Pinterest",
                      
                      @"Qualcomm",
                      
                      @"Rovio",
                      @"Rdio",
                      
                      @"Samsung",
                      @"Shazam",
                      @"Skype",
                      @"Snapchat",
                      @"Spotify",
                      @"Sprint",
                      @"SoftBank",
                      @"SoundCloud",
                      @"Starbucks",
                      @"Staples",
                      
                      @"T-Mobile",
                      @"Tesla",
                      @"Tumblr",
                      @"Twitch",
                      @"Twitter",
                      
                      @"Uber",
                      
                      @"Verizon",
                      @"Vimeo",
                      @"Vine",
                      @"Vodafone",
                      @"VSCO",
                      
                      @"Walmart",
                      @"WeChat",
                      @"WhatsApp",
                      @"WordPress",
                      
                      @"Xiaomi",
                      
                      @"Yahoo!",
                      @"Yelp",
                      @"YouTube",
                      
                      @"Zillow",
                      @"ZTE",
                      ];
    
    return list;
}


+ (NSArray*)bc_brandsWithLightColor {
    NSArray *brandsWithLightColor = @[
                                      @"Snapchat",
                                      ];
    return brandsWithLightColor;
}


+ (UIColor*)bc_colorForBrand:(NSString*)brand {
    UIColor *brandColor = BC_DEFAULT_COLOR;
    
    if ([self brand:brand matches:@"Acer"]) {
        return [UIColor dk_colorWithHexString:@"#83B941"];
    }
    
    if ([self brand:brand matches:@"Alibaba"]) {
        return [UIColor dk_colorWithHexString:@"#FF7300"];
    }
    
    if ([self brand:brand matches:@"Adobe"]) {
        return [UIColor dk_colorWithHexString:@"#ff0000"];
    }
    
    if ([self brand:brand matches:@"Airbnb"]) {
        return [UIColor dk_colorWithHexString:@"#FF5A60"];
    }
    
    if ([self brand:brand matches:@"Apple"]) {
        return [UIColor dk_colorWithHexString:@"#777777"];
    }

    if ([self brand:brand matches:@"Amazon"]) {
        return [UIColor dk_colorWithHexString:@"#ff9900"];
    }
    
    if ([self brand:brand matches:@"AOL"]) {
        return [UIColor dk_colorWithHexString:@"#00c4ff"];
    }

    if ([self brand:brand matches:@"ARM"]) {
        return [UIColor dk_colorWithHexString:@"#0084AB"];
    }
    
    if ([self brand:brand matches:@"AT&T"]) {
        return [UIColor dk_colorWithHexString:@"#2D96C8"];
    }
    
    if ([self brand:brand matches:@"BBC"]) {
        return [UIColor dk_colorWithHexString:@"#333333"];
    }

    if ([self brand:brand matches:@"Beats"]) {
        return [UIColor dk_colorWithHexString:@"#FF0000"];
    }
    
    if ([self brand:brand matches:@"Blizzard"]) {
        return [UIColor dk_colorWithHexString:@"#01B2F1"];
    }    
    
    if ([brand.lowercaseString isEqualToString:@"box"]) {
        return [UIColor dk_colorWithHexString:@"#197BC6"];
    }
    
    if ([self brand:brand matches:@"Broadcom"]) {
        return [UIColor dk_colorWithHexString:@"#E81231"];
    }

    if ([brand.lowercaseString isEqualToString:@"bt"]) {
        return [UIColor dk_colorWithHexString:@"#084897"];
    }
    
    if ([self brand:brand matches:@"BuzzFeed"]) {
        return [UIColor dk_colorWithHexString:@"#EE3322"];
    }

    if ([self brand:brand matches:@"China Mobile"]) {
        return [UIColor dk_colorWithHexString:@"#0086D0"];
    }

    if ([self brand:brand matches:@"Cisco"]) {
        return [UIColor dk_colorWithHexString:@"#11495E"];
    }

    if ([self brand:brand matches:@"Corning"]) {
        return [UIColor dk_colorWithHexString:@"#00559B"];
    }
    
    if ([self brand:brand matches:@"Dell"]) {
        return [UIColor dk_colorWithHexString:@"#0085c3"];
    }

    if ([self brand:brand matches:@"DirecTV"]) {
        return [UIColor dk_colorWithHexString:@"#0097CD"];
    }
    
    if ([self brand:brand matches:@"Dish Network"]) {
        return [UIColor dk_colorWithHexString:@"#DA121D"];
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

    if ([self brand:brand matches:@"Ericsson"]) {
        return [UIColor dk_colorWithHexString:@"#002561"];
    }

    if ([self brand:brand matches:@"Evernote"]) {
        return [UIColor dk_colorWithHexString:@"#7ac142"];
    }

    if ([self brand:brand matches:@"Expedia"]) {
        return [UIColor dk_colorWithHexString:@"#00355F"];
    }
    
    if ([self brand:brand matches:@"Facebook"]) {
        return [UIColor dk_colorWithHexString:@"#3b5998"];
    }

    if ([self brand:brand matches:@"FedEx"]) {
        return [UIColor dk_colorWithHexString:@"#4D148C"];
    }
    
    if ([self brand:brand matches:@"Fitbit"]) {
        return [UIColor dk_colorWithHexString:@"#45C2C5"];
    }
    
    if ([self brand:brand matches:@"Flipkart"]) {
        return [UIColor dk_colorWithHexString:@"#005387"];
    }
    
    if ([self brand:brand matches:@"Foxconn"]) {
        return [UIColor dk_colorWithHexString:@"#1E5AA0"];
    }
    
    if ([self brand:brand matches:@"Foursquare"]) {
        return [UIColor dk_colorWithHexString:@"#0cbadf"];
    }

    if ([self brand:brand matches:@"General Electric"]) {
        return [UIColor dk_colorWithHexString:@"#019DDD"];
    }

    if ([self brand:brand matches:@"Google"]) {
        return [UIColor dk_colorWithHexString:@"#4285f4"];
    }

    if ([self brand:brand matches:@"GoPro"]) {
        return [UIColor dk_colorWithHexString:@"#009EE2"];
    }
    
    if ([self brand:brand matches:@"HP"]) {
        return [UIColor dk_colorWithHexString:@"#0096d6"];
    }
    
    if ([self brand:brand matches:@"HTC"]) {
        return [UIColor dk_colorWithHexString:@"#69B40F"];
    }

    if ([self brand:brand matches:@"Huawei"]) {
        return [UIColor dk_colorWithHexString:@"#D62D24"];
    }
    
    if ([self brand:brand matches:@"IBM"]) {
        return [UIColor dk_colorWithHexString:@"#003e6a"];
    }
    
    if ([self brand:brand matches:@"iHeartRadio"]) {
        return [UIColor dk_colorWithHexString:@"#BC1C10"];
    }

    if ([self brand:brand matches:@"Instagram"]) {
        return [UIColor dk_colorWithHexString:@"#3f729b"];
    }
    
    if ([self brand:brand matches:@"Intel"]) {
        return [UIColor dk_colorWithHexString:@"#0071c5"];
    }
    
    if ([brand.lowercaseString isEqualToString:@"lg"]) {        
        return [UIColor dk_colorWithHexString:@"#B20E50"];
    }
    
    if ([self brand:brand matches:@"LinkedIn"]) {
        return [UIColor dk_colorWithHexString:@"#0e76a8"];
    }
    
    if ([brand.lowercaseString isEqualToString:@"line"]) {
        return [UIColor dk_colorWithHexString:@"#1DCD00"];
    }

    if ([self brand:brand matches:@"Lyft"]) {
        return [UIColor dk_colorWithHexString:@"#00B4AE"];
    }
    
    if ([self brand:brand matches:@"Microsoft"]) {
        return [UIColor dk_colorWithHexString:@"#00a1f1"];
    }
    
    if ([self brand:brand matches:@"Motorola"]) {
        return [UIColor dk_colorWithHexString:@"#5C92FA"];
    }

    if ([self brand:brand matches:@"Mozilla"]) {
        return [UIColor dk_colorWithHexString:@"#C34139"];
    }
    
    if ([brand.lowercaseString isEqualToString:@"nest"]) {
        return [UIColor dk_colorWithHexString:@"#1EB6DC"];
    }
    
    if ([self brand:brand matches:@"Netflix"]) {
        return [UIColor dk_colorWithHexString:@"#b9070a"];
    }
    
    if ([self brand:brand matches:@"Nintendo"]) {
        return [UIColor dk_colorWithHexString:@"#8C8C8C"];
    }

    if ([self brand:brand matches:@"Nokia"]) {
        return [UIColor dk_colorWithHexString:@"#183693"];
    }

    if ([self brand:brand matches:@"NTT DoCoMo"]) {
        return [UIColor dk_colorWithHexString:@"#CC0033"];
    }

    if ([self brand:brand matches:@"NVIDIA"]) {
        return [UIColor dk_colorWithHexString:@"#77B900"];
    }
    
    if ([brand.lowercaseString isEqualToString:@"opera"]) {
        return [UIColor dk_colorWithHexString:@"#cc0f16"];
    }
    
    if ([self brand:brand matches:@"Panasonic"]) {
        return [UIColor dk_colorWithHexString:@"#0438C2"];
    }

    if ([self brand:brand matches:@"PayPal"]) {
        return [UIColor dk_colorWithHexString:@"#3b7bbf"];
    }

    if ([self brand:brand matches:@"Pinterest"]) {
        return [UIColor dk_colorWithHexString:@"#cc2127"];
    }

    if ([self brand:brand matches:@"Qualcomm"]) {
        return [UIColor dk_colorWithHexString:@"#1B2021"];
    }
    
    if ([self brand:brand matches:@"Rovio"]) {
        return [UIColor dk_colorWithHexString:@"#C02227"];
    }
    
    if ([self brand:brand matches:@"Rdio"]) {
        return [UIColor dk_colorWithHexString:@"#007dc3"];
    }

    if ([self brand:brand matches:@"Samsung"]) {
        return [UIColor dk_colorWithHexString:@"#0c4da2"];
    }
    
    if ([self brand:brand matches:@"Shazam"]) {
        return [UIColor dk_colorWithHexString:@"#1B87E3"];
    }

    if ([self brand:brand matches:@"Skype"]) {
        return [UIColor dk_colorWithHexString:@"#00aff0"];
    }

    if ([self brand:brand matches:@"Snapchat"]) {
        return [UIColor dk_colorWithHexString:@"#FFFC00"];
    }
    
    if ([self brand:brand matches:@"Spotify"]) {
        return [UIColor dk_colorWithHexString:@"#81b71a"];
    }
    
    if ([self brand:brand matches:@"Sprint"]) {
        return [UIColor dk_colorWithHexString:@"#fee100"];
    }
    
    if ([self brand:brand matches:@"SoftBank"]) {
        return [UIColor dk_colorWithHexString:@"#BABCBE"];
    }
    
    if ([self brand:brand matches:@"SoundCloud"]) {
        return [UIColor dk_colorWithHexString:@"#FF8800"];
    }
    
    if ([self brand:brand matches:@"Staples"]) {
        return [UIColor dk_colorWithHexString:@"#cc0000"];
    }

    if ([self brand:brand matches:@"Starbucks"]) {
        return [UIColor dk_colorWithHexString:@"#00704A"];
    }
    
    if (
        ([self brand:brand matches:@"T-Mobile"]) ||
        ([self brand:brand matches:@"TMobile"])
        ) {
        return [UIColor dk_colorWithHexString:@"#ea0a8e"];
    }

    if ([self brand:brand matches:@"Twitch"]) {
        return [UIColor dk_colorWithHexString:@"#6441a5"];
    }
    
    if ([self brand:brand matches:@"Twitter"]) {
        return [UIColor dk_colorWithHexString:@"#55acee"];
    }

    if ([self brand:brand matches:@"Tesla"]) {
        return [UIColor dk_colorWithHexString:@"#CC0000"];
    }
    
    if ([self brand:brand matches:@"Tumblr"]) {
        return [UIColor dk_colorWithHexString:@"#34526f"];
    }
    
    if ([self brand:brand matches:@"Uber"]) {
        return [UIColor dk_colorWithHexString:@"#1CA8C3"];
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

    if ([self brand:brand matches:@"Vodafone"]) {
        return [UIColor dk_colorWithHexString:@"#E90000"];
    }
    
    if ([self brand:brand matches:@"VSCO"]) {
        return [UIColor dk_colorWithHexString:@"#AAA94C"];
    }

    if ([self brand:brand matches:@"Walmart"]) {
        return [UIColor dk_colorWithHexString:@"#005CB0"];
    }
    
    if ([self brand:brand matches:@"WeChat"]) {
        return [UIColor dk_colorWithHexString:@"#93D034"];
    }
    
    if ([self brand:brand matches:@"WhatsApp"]) {
        return [UIColor dk_colorWithHexString:@"#34AF23"];
    }

    if ([self brand:brand matches:@"WordPress"]) {
        return [UIColor dk_colorWithHexString:@"#464646"];
    }
    
    if ([self brand:brand matches:@"Xiaomi"]) {
        return [UIColor dk_colorWithHexString:@"#FF4A03"];
    }
    
    if ([self brand:brand matches:@"Yahoo"]) {
        return [UIColor dk_colorWithHexString:@"#720e9e"];
    }
    
    if ([self brand:brand matches:@"Yelp"]) {
        return [UIColor dk_colorWithHexString:@"#c41200"];
    }

    if ([self brand:brand matches:@"YouTube"]) {
        return [UIColor dk_colorWithHexString:@"#e52d27"];
    }
    
    if ([self brand:brand matches:@"Zillow"]) {
        return [UIColor dk_colorWithHexString:@"#0079E4"];
    }

    if ([self brand:brand matches:@"ZTE"]) {
        return [UIColor dk_colorWithHexString:@"#0A50A0"];
    }
    
    return brandColor;
}


#pragma mark - Private

+ (BOOL)brand:(NSString*)brand matches:(NSString *)string {
    brand = brand.lowercaseString;
    string = string.lowercaseString;
    return !NSEqualRanges([brand rangeOfString:string], NSMakeRange(NSNotFound, 0));
}


+ (UIColor *)dk_colorWithHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // skip '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}


@end
