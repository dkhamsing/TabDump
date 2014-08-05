//
//  DKUserMessageView.m
//
//  Created by dkhamsing on 4/17/14.
// https://github.com/dkhamsing/DKMessageView
//

#import "DKUserMessageView.h"

#import "UIColor+DK.h"
#import "RTSpinKitView.h"
#import <tgmath.h>

@interface DKUserMessageView ()

@end

@implementation DKUserMessageView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //self.dk_userMessageLabelTop = 10;
        
        self.dk_userMessageLabel = [[UILabel alloc] init];
        [self addSubview:self.dk_userMessageLabel];

        self.dk_spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleBounce color:[UIColor dk_colorWithHexString:@"#eeeeee"]];
        [self addSubview:self.dk_spinner];
    }
    return self;
}


#pragma mark - Public

- (void)dk_displayMessage:(NSString*)message {
    self.hidden = NO;
    
    self.dk_userMessageLabel.text = message;
    
    CGRect frame;
    CGRect textRect = [self.dk_userMessageLabel.text boundingRectWithSize:CGSizeMake(self.frame.size.width, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.dk_userMessageLabel.font} context:nil];
    textRect.size.width = ceilf(textRect.size.width);
    textRect.size.height = ceilf(textRect.size.height);
    frame.size = textRect.size;
    frame.origin.y = self.dk_userMessageLabelTop;

    self.dk_userMessageLabel.frame = frame;
    
    [self centerViewHorizontally:self.dk_userMessageLabel];
}


- (void)dk_loading:(BOOL)loading {
    [self dk_loading:loading spinner:NO];
}


- (void)dk_loading:(BOOL)loading spinner:(BOOL)spinner {    
    self.hidden = !loading;
    if (spinner ) {
        if (loading) {
            self.dk_spinner.center = CGPointMake(CGRectGetMidX(self.frame) , self.dk_userMessageLabelTop);
            
            [self centerViewHorizontally:self.dk_spinner];
            [self centerViewVertically:self.dk_spinner];
            [self.dk_spinner startAnimating];
        }
        else {
            [self.dk_spinner stopAnimating];
        }
    }
    else {
        if (!self.hidden) {
            [self dk_displayMessage:@"Loading"];
        }
    }
}


#pragma mark - Private

- (void)centerViewHorizontally:(UIView*)view {
    CGRect frame = view.frame;
    frame.origin.x = (self.frame.size.width - frame.size.width)/2;
    frame.origin.x = ceilf(frame.origin.x);
    view.frame = frame;
}


- (void)centerViewVertically:(UIView*)view {
    CGRect frame = view.frame;
    frame.origin.y = (self.frame.size.height - frame.size.height)/2;
    frame.origin.y = ceilf(frame.origin.y);
    view.frame = frame;
}


@end
