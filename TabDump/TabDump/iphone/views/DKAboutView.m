//
//  DKAboutView.m
//  TabDump
//
//  Created by Daniel on 4/25/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import "DKAboutView.h"

// Categories
#import "UIColor+TD.h"
#import "UIView+DK.h"

// Defines
#import "DKTabDumpDefines.h"

// Frameworks
@import Accounts;
@import Social;

// Libraries
#import "SVWebViewController.h"


@interface DKAboutView () <UIActionSheetDelegate>
@property (nonatomic,strong) UIImageView *stefanImageView;
@property (nonatomic,strong) UIImageView *danielImageView;
@property (nonatomic,strong) UILabel *stefanLabel;
@property (nonatomic,strong) UILabel *danielLabel;
@property (nonatomic,strong) UIButton *stefanButton;
@property (nonatomic,strong) UIButton *danielButton;

@property (nonatomic,strong) NSString *twitterUrlString;
@property (nonatomic,strong) NSString *twitterUsername;
@end

@implementation DKAboutView

CGFloat kFontSize1 = 13;


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor redColor];
        
        self.stefanImageView = [[UIImageView alloc] init];
        self.danielImageView = [[UIImageView alloc] init];
        
        self.stefanLabel = [[UILabel alloc] init];
        self.danielLabel = [[UILabel alloc] init];
        
        NSArray *labels = @[self.stefanLabel,self.danielLabel];
        [labels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UILabel *label = obj;
            label.numberOfLines = 0;
            label.font = [UIFont fontWithName:kFontRegular size:kFontSize1];
        }];
        
        self.stefanButton = [[UIButton alloc] init];
        [self.stefanButton addTarget:self action:@selector(actionTwitter:) forControlEvents:UIControlEventTouchUpInside];
        self.danielButton = [[UIButton alloc] init];
        [self.danielButton addTarget:self action:@selector(actionTwitter:) forControlEvents:UIControlEventTouchUpInside];
     
        self.overlayView = [[UIView alloc] initWithFrame:self.bounds];
        self.overlayView.backgroundColor = [UIColor whiteColor];
        self.overlayView.alpha = 0.7;
        
        [UIView dk_addSubviews:@[self.stefanImageView,
                                 self.danielImageView,
                                 self.stefanLabel,
                                 self.danielLabel,
                                 self.overlayView,
                                 self.stefanButton,
                                 self.danielButton,

                                 ] onView:self];
        
        CGRect frame;
        CGFloat inset = 24;
        frame.origin = CGPointMake(32, inset);
        frame.size = CGSizeMake(60, 60);
        self.stefanImageView.frame = frame;
        [self styleCircle:self.stefanImageView];
        self.stefanImageView.image = [UIImage imageNamed:@"credit-stefan.jpg"];
        
        frame.origin.y = self.stefanImageView.dk_bottom +inset;
        self.danielImageView.frame = frame;
        [self styleCircle:self.danielImageView];
        self.danielImageView.image = [UIImage imageNamed:@"credit-daniel.jpg"];
        
        frame.origin.y = inset;
        frame.origin.x = self.stefanImageView.dk_right +inset;
        frame.size.width = 360/2;
        self.stefanLabel.frame = frame;
        
        NSString *stefanTwitterUsername = [self stringForTwitterUsername:kAboutTwitterStefan];
        NSString *stefanString = [NSString stringWithFormat:@"Tab Dump is written by %@\n%@",kAboutFullNameStefan, stefanTwitterUsername];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:stefanString];

        NSDictionary *colorAttribute = @{NSForegroundColorAttributeName:[UIColor td_highlightColor]};
        NSDictionary *fontAttribute = @{NSFontAttributeName:[UIFont fontWithName:kFontBold size:kFontSize1]};
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 3;
        NSDictionary *paragraphAttribute = @{NSParagraphStyleAttributeName:paragraphStyle};
        
        [attributedString addAttributes:colorAttribute range:[stefanString rangeOfString:stefanTwitterUsername]];
        [attributedString addAttributes:fontAttribute range:[stefanString rangeOfString:kAboutFullNameStefan]];
        [attributedString addAttributes:paragraphAttribute range:[stefanString rangeOfString:stefanString]];
         
        self.stefanLabel.attributedText = attributedString;
        
        frame.origin.y = self.stefanLabel.dk_bottom +inset;
        self.danielLabel.frame = frame;
        NSString *danielTwitterUsername = [self stringForTwitterUsername:kAboutTwitterDaniel];
        NSString *danielString = [NSString stringWithFormat:@"Tab Dump for iOS is brought to you by %@\n%@",kAboutFullNameDaniel,danielTwitterUsername];
        NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:danielString];
        [attributedString2 addAttributes:colorAttribute range:[danielString rangeOfString:danielTwitterUsername]];
        [attributedString2 addAttributes:fontAttribute range:[danielString rangeOfString:kAboutFullNameDaniel]];
        [attributedString2 addAttributes:paragraphAttribute range:[danielString rangeOfString:danielString]];
        self.danielLabel.attributedText = attributedString2;
        
        frame.origin = self.stefanImageView.frame.origin;
        frame.size.height = self.stefanImageView.dk_height;
        frame.size.width = self.dk_width - 2*inset;
        self.stefanButton.frame = frame;
        
        frame.origin.y = self.stefanLabel.dk_bottom +inset;
        self.danielButton.frame = frame;
    }
    return self;
}

#pragma mark - Private

- (void)styleCircle:(UIView*)view {
    view.layer.cornerRadius = view.bounds.size.height/2;
    view.clipsToBounds = YES;
}


- (void)actionTwitter:(UIButton*)button {
    //NSLog(@"twitter action hit");
    
    NSString *name;
 
    if (button==self.danielButton) {
        name = @"Daniel";
        self.twitterUsername = kAboutTwitterDaniel;
    }
    else {
        name = @"Stefan";
        self.twitterUsername = kAboutTwitterStefan;
    }
    
    self.twitterUrlString = [NSString stringWithFormat:@"http://twitter.com/%@", self.twitterUsername];
    NSString *sheetTitle = [NSString stringWithFormat:@"%@ on Twitter", name];
    NSString *followTitle = [NSString stringWithFormat:@"Follow @%@", self.twitterUsername];
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:sheetTitle delegate:self cancelButtonTitle:@"Dismiss" destructiveButtonTitle:nil otherButtonTitles:followTitle, @"View Timeline", nil];
    [sheet showInView:self];
}


- (NSString*)stringForTwitterUsername:(NSString*)username {
    return  [NSString stringWithFormat:@"@%@",username];
}


- (UIViewController *)viewController {
    UIResponder *responder = self;
    while (![responder isKindOfClass:[UIViewController class]]) {
        responder = [responder nextResponder];
        if (nil == responder) {
            break;
        }
    }
    return (UIViewController *)responder;
}


#pragma mark - UIActionSheetDelegate

NS_ENUM(NSInteger, AboutActionSheetSelection) {
    AboutActionSheetSelectionFollow = 0,
    AboutActionSheetSelectionTimeline,
    AboutActionSheetSelectionCancelled,
};

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    //NSLog(@"user tapped=%d",buttonIndex);
    
    switch (buttonIndex) {
        case AboutActionSheetSelectionFollow: {
            ACAccountStore *accountStore = [[ACAccountStore alloc] init];
            ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
            
            [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
                if(granted) {
                    NSArray *accountsArray = [accountStore accountsWithAccountType:accountType];
                    
                    //TODO: show user which account to follow from
                    if ([accountsArray count] > 0) {
                        // Grab the initial Twitter account to tweet from.
                        ACAccount *twitterAccount = [accountsArray objectAtIndex:0];
                        
                        NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
                        [tempDict setValue:self.twitterUsername forKey:@"screen_name"];
                        [tempDict setValue:@"true" forKey:@"follow"];
                        //NSLog(@"*******tempDict %@*******",tempDict);
                        
                        SLRequest *postRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodPOST URL:[NSURL URLWithString:@"https://api.twitter.com/1/friendships/create.json"] parameters:tempDict];
                        [postRequest setAccount:twitterAccount];
                        [postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                            if (!error) {
                                NSLog(@"follow success");
                                //TODO: show message to user
                            }
                            else {
                                /*
                                 NSString *output = [NSString stringWithFormat:@"HTTP response status: %i Error %d", [urlResponse statusCode],error.code];
                                 NSLog(@"%@error %@", output,error.description);
                                 */
                                //TODO: show error message to user
                                NSLog(@"error following %@",error.localizedDescription);
                            }
                        }];
                    }
                }
            }];
        }
            break;
            
        case AboutActionSheetSelectionTimeline: {
            //NSLog(@"opening %@",self.twitterUrlString);
            SVWebViewController *webViewController = [[SVWebViewController alloc] initWithAddress:self.twitterUrlString];
            webViewController.title = @"Loading";
            [[self viewController].navigationController  pushViewController:webViewController animated:YES];
        }
            break;
            
        default:
            NSLog(@"action sheet default: selected index=%@", @(buttonIndex));
            break;
    }
}


@end
