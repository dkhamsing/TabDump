//
//  DKCategoryCell.m
//  TabDump
//
//  Created by Daniel on 5/17/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import "DKCategoryCell.h"

// Categories
#import "UIView+DK.h"
#import "UIColor+BrandColors.h"

// Defines
#import "DKTabDumpDefines.h"

// Models
#import "DKDevice.h"

@interface DKCategoryCell ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *subTitleLabel;
@end

@implementation DKCategoryCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor purpleColor];
        
        self.titleLabel = [[UILabel alloc]init];
        self.subTitleLabel = [[UILabel alloc]init];
        
        [UIView dk_addSubviews:@[self.titleLabel,self.subTitleLabel] onView:self.contentView];
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont fontWithName:kFontRegular size:18];        

        self.subTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.subTitleLabel.font = [UIFont fontWithName:kFontRegular size:12];
    
    }
    return self;
}


- (void)setTitle:(NSString *)title {
    // layout
    CGRect frame;
    CGFloat inset = 5;    
    frame.origin = CGPointMake(inset,[DKDevice categoriesCellInset]);
    frame.size.width = self.bounds.size.width -2*inset;
    frame.size.height = 22;
    self.titleLabel.frame = frame;
    
    frame.origin.y = self.titleLabel.dk_bottom;
    self.subTitleLabel.frame = frame;
    
    // set values
    self.titleLabel.text = title;
    
    NSString *subtitle = [NSString stringWithFormat:@"%@ %@", @(self.numberOfStories),
                          (self.numberOfStories==1)?@"story":@"stories"];
    self.subTitleLabel.text = subtitle;
    
    self.backgroundColor = [UIColor bc_colorForBrand:title];
    
    if ([[UIColor bc_brandsWithDarkColor] containsObject:title]) {
        self.titleLabel.textColor = [UIColor whiteColor];
        self.subTitleLabel.textColor = [UIColor whiteColor];
    }
    else {
        self.titleLabel.textColor = [UIColor blackColor];
        self.subTitleLabel.textColor = [UIColor blackColor];
    }
}


@end
