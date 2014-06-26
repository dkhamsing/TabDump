//
//  DKRoundedLabel.m
//  TabDump
//
//  Created by Daniel on 6/13/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import "DKRoundedLabel.h"

// Categories
#import "UIView+DK.h"

// Defines
#import "DKTabDumpDefines.h"


@implementation DKRoundedLabel

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [DKRoundedLabel roundedLabelFont];
        [self dk_addBorderWithColor:[UIColor lightGrayColor] width:0.5];
    }
    return self;
}


- (void)setDk_text:(NSString *)text {
    if (text.length==0)
        return;
    
    text = text.uppercaseString;
    self.text = text;

    self.layer.cornerRadius = 6;
    self.clipsToBounds = YES;
    
    CGRect frame = self.frame;
    frame.size = [text sizeWithAttributes: @{NSFontAttributeName:self.font} ];
    frame.size.width +=20;
    CGFloat rightMargin = 15;
    CGFloat maxWidth = 320 -self.dk_left -rightMargin;
    if (frame.size.width>maxWidth) {
        frame.size.width = maxWidth;
    }
    frame.size.height +=10;
    self.frame = frame;
}


+ (UIFont*)roundedLabelFont {
    return [UIFont fontWithName:kFontRegular size:12];
}


@end
