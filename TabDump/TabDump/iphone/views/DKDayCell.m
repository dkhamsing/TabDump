//
//  DKDayCell.m
//  TabDump
//
//  Created by Daniel on 4/22/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import "DKDayCell.h"

// Categories
#import "NSString+DK.h"
#import "UIColor+DK.h"
#import "UIColor+TD.h"
#import "UIView+DK.h"

// Defines
#import "DKTabDumpDefines.h"

// Models
#import "DKTab.h"


@interface DKDayCell ()
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIButton *viewButton;
@end

@implementation DKDayCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.numberOfLines = 0;
        
        self.shareButton = [[UIButton alloc] init];
        
        self.viewButton = [[UIButton alloc] init];
        self.viewButton.userInteractionEnabled = NO;
      
        [UIView dk_addSubviews:@[
                                 self.contentLabel,
                                 self.shareButton,
                                 self.viewButton,
                                 ] onView:self.contentView];
    }
    return self;
}


- (void)prepareForReuse {
    [super prepareForReuse];
    self.backgroundColor = [UIColor whiteColor];
}


- (void)setLink:(DKTab *)link {
    _link = link;
    
    NSString *tabText = link.strippedHTML;
    
    NSString *dateBlock = [NSString stringWithFormat:@"%@: ",link.tabDay];
    if (self.isCategory) {
        tabText = [tabText stringByReplacingOccurrencesOfString:link.tabNumber withString:@""];
        tabText = [tabText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        tabText = [tabText stringByReplacingOccurrencesOfString:link.category withString:dateBlock];
    }
    
    self.contentLabel.text = tabText;
    CGRect frame = self.contentLabel.frame;
    frame.origin = CGPointMake(kCellPadding,kCellPadding);
    frame.size = [link sizeForStrippedHTML];
    self.contentLabel.frame = frame;
    
    self.contentLabel.textColor = [UIColor blackColor];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.contentLabel.text];
    UIColor *dumpColor = [UIColor whiteColor];
    UIColor *categoryColor = dumpColor;
    if (link.colorForCategory == [UIColor whiteColor]) {
        dumpColor = [UIColor td_highlightColor];
        categoryColor = [UIColor grayColor];
    }
    if ([link brandColorIsDark]) {
        dumpColor = [UIColor td_highlightColor];
        categoryColor = [UIColor td_highlightColor];
    }
    
    NSNumber *categoryColors = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsSettingsCategoryColors];
    if ([categoryColors isEqual:@1]) {
        if ([link brandColorIsDark]) {
            self.contentLabel.textColor = [UIColor whiteColor];
        }
    }
    else {
        dumpColor = [UIColor td_highlightColor];
        categoryColor = [UIColor blackColor];
        self.contentLabel.textColor = [UIColor blackColor];
    
    }
    
    [attributedString addAttributes:@{NSForegroundColorAttributeName:dumpColor} range:[self.contentLabel.text rangeOfString:dateBlock]];
    
    [attributedString addAttributes:@{NSForegroundColorAttributeName:dumpColor} range:[self.contentLabel.text rangeOfString:link.tabNumber]];
    
    [attributedString addAttributes:@{NSForegroundColorAttributeName:dumpColor} range:[self.contentLabel.text rangeOfString:link.tabNumber]];

    [attributedString addAttributes:@{NSForegroundColorAttributeName:categoryColor} range:[self.contentLabel.text rangeOfString:link.category]];
    [attributedString addAttributes:[link contentAttributes] range:[self.contentLabel.text rangeOfString:self.contentLabel.text]];
    
    self.contentLabel.text = @"";
    self.contentLabel.attributedText = attributedString;
    
    frame.origin.y = self.contentLabel.dk_bottom -5;
    frame.size = CGSizeMake(50, 50);
    frame.origin.x = ((self.dk_width/2) - frame.size.width)/2 ;
    self.shareButton.frame = frame;

    UIImage *shareImage = [UIImage imageNamed:@"tab-action"];
    [self.shareButton setImage:shareImage forState:UIControlStateNormal];
    
    frame.origin.x = self.shareButton.dk_left +(self.dk_width/2) ;
    self.viewButton.frame = frame;
    UIImage *eyeImage = [UIImage imageNamed:@"tab-eye"];
    [self.viewButton setImage:eyeImage forState:UIControlStateNormal];

    
    NSNumber *actionButtons = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsSettingsActionButtons];
    if ([actionButtons isEqual:@1]) {
        self.shareButton.alpha = 0.2;
        self.viewButton.alpha = self.shareButton.alpha -0.08;
    }
    else {
        //NSLog(@"actionbuttons integar value=%d",actionButtons.integerValue);
        self.shareButton.alpha = 0;
        self.viewButton.alpha = 0;
    }
}


@end
