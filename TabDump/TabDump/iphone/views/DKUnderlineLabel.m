//
//  DKUnderlineLabel.m
//  TabDump
//
//  Created by Daniel on 6/14/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import "DKUnderlineLabel.h"
#import "UIView+DK.h"
#import "DKRoundedLabel.h"

@implementation DKUnderlineLabel

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [DKRoundedLabel roundedLabelFont];        
    }
    return self;
}


- (void)setDk_text:(NSString *)dk_text {
    NSString *text = dk_text.uppercaseString;

    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:text
                                                                    attributes:@{NSFontAttributeName:self.font,                                                                                                 
                                                                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                                                                 NSKernAttributeName: @1.5}];

    CGRect frame = self.frame;
    frame.size = [attString size];
    self.frame = frame;    
    [self dk_addBottomBorderWithColor:[UIColor lightGrayColor] width:0.5];
    
    self.attributedText = attString;
}


@end
