//
//  DKTabCell.m
//  TabDump
//
//  Created by Daniel on 4/22/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import "DKTabCell.h"

// Categories
#import "NSString+DK.h"
#import "UIColor+DK.h"
#import "UIColor+TD.h"
#import "UIImage+DK.h"
#import "UIView+DK.h"

// Defines
#import "DKTabDumpDefines.h"

// Models
#import "DKDevice.h"
#import "DKTab.h"

// Views
#import "DKRoundedLabel.h"


@interface DKTabCell ()
@property (nonatomic, strong) DKRoundedLabel *numberLabel;
@property (nonatomic, strong) DKRoundedLabel *categoryLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UILabel *domainLabel;
@end


@implementation DKTabCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.numberLabel = [[DKRoundedLabel alloc] init];
        self.categoryLabel = [[DKRoundedLabel alloc] init];
        self.contentLabel = [[UILabel alloc] init];
        self.shareButton = [[UIButton alloc] init];
        self.domainLabel = [[UILabel alloc] init];
        
        [UIView dk_addSubviews:@[
                                 self.numberLabel,
                                 self.categoryLabel,
                                 self.contentLabel,
                                 self.domainLabel,
                                 self.shareButton,
                                 ] onView:self.contentView];
        
        self.contentLabel.numberOfLines = 0;
        self.domainLabel.font = [UIFont fontWithName:kFontRegular size:11];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


- (void)setLink:(DKTab *)link {
    _link = link;
    
    // setup
    self.domainLabel.text = [link.urlString dk_domainForStringURL];
    
    // colors
    self.domainLabel.textColor = [UIColor dk_colorWithRed:210 green:210 blue:210];
    UIImage *shareImage = [UIImage dk_maskedImageNamed:@"tab-action" color:self.domainLabel.textColor];
    NSNumber *nightMode = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsSettingsNightMode];
    if ([nightMode isEqual:@1]) {
        self.backgroundColor = [UIColor blackColor];
        self.contentLabel.textColor = [UIColor whiteColor];
        self.numberLabel.textColor = [UIColor whiteColor];
    }
    else {
        self.backgroundColor = [UIColor whiteColor];
        self.contentLabel.textColor = [UIColor blackColor];
        self.numberLabel.textColor = [UIColor blackColor];
    }
    
    //NSLog(@"color %@", link.colorForCategory);
    if (link.colorForCategory==[UIColor whiteColor])
        self.categoryLabel.layer.borderWidth=0.5;
    else
        self.categoryLabel.layer.borderWidth=0;
    self.categoryLabel.backgroundColor = link.colorForCategory;
    
    self.categoryLabel.textColor = link.colorForCategoryText;
    
    self.contentLabel.attributedText = [[NSAttributedString alloc] initWithString:link.tabText attributes:link.contentAttributes];
    
    // frame
    CGRect frame = self.contentLabel.frame;
    frame.origin = CGPointMake([DKDevice padding],[DKDevice topOffset] +kCellHeightCategory);
    frame.size = [link sizeForTabText];
    self.contentLabel.frame = frame;
    
    UIFont *labelFont = [DKRoundedLabel roundedLabelFont];
    if (self.isCategory) {
        frame.origin.y = self.contentLabel.dk_top -35;
        frame.size = [link.tabNumber sizeWithAttributes:@{NSFontAttributeName:labelFont}];
        self.numberLabel.frame = frame;
        self.numberLabel.dk_text = link.tabDay;        
    }
    else {
        frame.origin.y = self.contentLabel.dk_top -35;
        frame.size = [link.tabNumber sizeWithAttributes:@{NSFontAttributeName:labelFont}];
        self.numberLabel.frame = frame;
        self.numberLabel.dk_text = link.tabNumber;
        
        frame.origin.x = self.numberLabel.dk_right +8;
        frame.size = [link.categoryOnly sizeWithAttributes:@{NSFontAttributeName:labelFont}];
        self.categoryLabel.frame=frame;
        self.categoryLabel.dk_text = link.categoryOnly;
    }
    
    frame.origin.y = self.contentLabel.dk_bottom -8;
    frame.size = CGSizeMake(50, 50);
    frame.origin.x = self.contentLabel.dk_left -15;
    self.shareButton.frame = frame;

    [self.shareButton setImage:shareImage forState:UIControlStateNormal];
    
    frame.size = CGSizeMake(200, 26);
    frame.origin.x = self.shareButton.dk_right -9;
    frame.origin.y = self.contentLabel.dk_bottom +3;
    self.domainLabel.frame = frame;
}


@end
