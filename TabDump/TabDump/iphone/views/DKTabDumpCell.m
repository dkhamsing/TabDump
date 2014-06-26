//
//  DKTabDumpCell.m
//  TabDump
//
//  Created by Daniel on 4/23/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import "DKTabDumpCell.h"

// Categories
#import "UIColor+DK.h"
#import "UIFont+TD.h"
#import "UIView+DK.h"

// Defines
#import "DKTabDumpDefines.h"

// Models
#import "DKDevice.h"
#import "DKTab.h"
#import "DKTabDump.h"


@interface DKTabDumpCell ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *readTimeLabel;
@property (nonatomic,strong) UILabel *excerptLabel;
@end

@implementation DKTabDumpCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];        
        self.titleLabel.font = [UIFont fontWithName:kFontRegular size:15];
        self.titleLabel.textColor = [UIColor grayColor];
        
        self.readTimeLabel = [[UILabel alloc] init];
        self.readTimeLabel.textColor = [UIColor lightGrayColor];
        self.readTimeLabel.font = [UIFont fontWithName:kFontRegular size:9];
        
        self.excerptLabel = [[UILabel alloc] init];
        self.excerptLabel.numberOfLines = 0;
        
        NSArray *allViews = @[
                              self.titleLabel,
                              self.readTimeLabel,
                              self.excerptLabel,
                              ];
        [UIView dk_addSubviews:allViews onView:self.contentView];        
    }
    return self;
}


- (void)setupWithDump:(DKTabDump*)dump link:(DKTab*)link nightmode:(NSNumber *)nightmode {
    self.excerptLabel.font = [UIFont td_fontFromSettings];
    
    CGRect frame;
    CGFloat padding=[DKDevice padding];
    frame = CGRectMake(padding, 12, 100, 20);
    self.titleLabel.frame = frame;
    
    NSString *title = [dump title];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:title];
    [attributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:[title rangeOfString:dump.date]];
    self.titleLabel.attributedText = attributedString;
    [self.titleLabel sizeToFit];
    
    CGFloat inset = 5;
    frame.origin.y = self.titleLabel.dk_bottom +inset;
    NSString *excerpt = link.strippedHTML;
    excerpt = [excerpt stringByReplacingOccurrencesOfString:link.tabNumber withString:@""];
    excerpt = [excerpt stringByReplacingOccurrencesOfString:link.category withString:@"Excerpt:"];
    excerpt = [excerpt stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    excerpt = [excerpt stringByAppendingString:@".."];
    self.excerptLabel.text = excerpt;
    frame.size = [link sizeForTabText];    
    self.excerptLabel.frame = frame;
    
    frame.origin.y = self.titleLabel.dk_top;
    self.readTimeLabel.text = [NSString stringWithFormat:@"%@%@", kCellReadTimePrefix, dump.readingTime];
    self.readTimeLabel.frame = frame;
    [self.readTimeLabel sizeToFit];
    frame = self.readTimeLabel.frame;
    frame.origin.x = [DKDevice cellWidth] -padding -frame.size.width;
    self.readTimeLabel.frame = frame;
    
    if ([nightmode isEqual:@1]) {
        self.excerptLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textColor = [UIColor whiteColor];
    }
    else {
        self.excerptLabel.textColor = [UIColor blackColor];
        self.titleLabel.textColor = [UIColor blackColor];
    }
    
    NSArray *tabDumpsRead = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsTabDumpsRead];
    if (tabDumpsRead) {
        if ([tabDumpsRead containsObject:dump.date]) {
            //TODO: put color in defines
            self.excerptLabel.textColor = [UIColor dk_colorWithHexString:@"#bbbccc"];
        }
    }
}


@end
