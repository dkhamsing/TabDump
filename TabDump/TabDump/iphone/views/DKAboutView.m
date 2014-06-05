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

// Controllers
#import "DKWebViewController.h"

// Defines
#import "DKTabDumpDefines.h"

// Frameworks
@import Accounts;
@import MessageUI;
@import Social;


@interface DKAboutView () <UIActionSheetDelegate, MFMailComposeViewControllerDelegate>
@property (nonatomic,strong) UIImageView *stefanImageView;
@property (nonatomic,strong) UIImageView *danielImageView;
@property (nonatomic,strong) UILabel *stefanLabel;
@property (nonatomic,strong) UILabel *danielLabel;
@property (nonatomic,strong) UIButton *stefanButton;
@property (nonatomic,strong) UIButton *danielButton;
@property (nonatomic,strong) NSString *twitterUrlString;
@property (nonatomic,strong) NSString *twitterUsername;
@property (nonatomic,strong) NSString *email;
@end

@implementation DKAboutView


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


CGFloat kFontSize1 = 13;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // notification
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(notificationNightMode:)
                                                     name:kNotificationNightMode
                                                   object:nil];
        
        // init
        self.stefanImageView = [[UIImageView alloc] init];
        self.danielImageView = [[UIImageView alloc] init];
        self.stefanLabel = [[UILabel alloc] init];
        self.danielLabel = [[UILabel alloc] init];
        self.stefanButton = [[UIButton alloc] init];
        self.danielButton = [[UIButton alloc] init];
        self.overlayView = [[UIView alloc] initWithFrame:self.bounds];
        
        // subviews
        [UIView dk_addSubviews:@[self.stefanImageView,
                                 self.danielImageView,
                                 self.stefanLabel,
                                 self.danielLabel,
                                 self.overlayView,
                                 self.stefanButton,
                                 self.danielButton,
                                 ] onView:self];
        
        // setup
        NSArray *labels = @[self.stefanLabel,self.danielLabel];
        [labels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UILabel *label = obj;
            label.numberOfLines = 0;
            label.font = [UIFont fontWithName:kFontRegular size:kFontSize1];
        }];
        
        [self.stefanButton addTarget:self action:@selector(actionTwitter:) forControlEvents:UIControlEventTouchUpInside];

        [self.danielButton addTarget:self action:@selector(actionTwitter:) forControlEvents:UIControlEventTouchUpInside];
        
        self.overlayView.alpha = 0.7;
        
        NSNumber *nightmode = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsSettingsNightMode];
        [self updateForNightMode:nightmode];
        
        // frame
        CGRect frame;
        CGFloat inset = 24;
        frame.origin = CGPointMake(32, inset);
        frame.size = CGSizeMake(60, 60);
        self.stefanImageView.frame = frame;
        [self.stefanImageView dk_styleCircle];
        self.stefanImageView.image = [UIImage imageNamed:@"credit-stefan.jpg"];
        
        frame.origin.y = self.stefanImageView.dk_bottom +inset;
        self.danielImageView.frame = frame;
        [self.danielImageView dk_styleCircle];
        self.danielImageView.image = [UIImage imageNamed:@"credit-daniel.jpg"];
        
        frame.origin.y = inset;
        frame.origin.x = self.stefanImageView.dk_right +inset;
        frame.size.width = 360/2;
        self.stefanLabel.frame = frame;
        
        frame.origin.y = self.stefanLabel.dk_bottom +inset;
        self.danielLabel.frame = frame;
        
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

- (void)actionTwitter:(UIButton*)button {
    NSString *name;    
    if (button==self.danielButton) {
        name = kAboutFullNameDaniel;
        self.twitterUsername = kAboutTwitterDaniel;
        self.email = kAboutEmailDaniel;
    }
    else {
        name = kAboutFullNameStefan;
        self.twitterUsername = kAboutTwitterStefan;
        self.email = kAboutEmailStefan;
    }
    
    self.twitterUrlString = [NSString stringWithFormat:@"http://twitter.com/%@", self.twitterUsername];
    NSString *sheetTitle = name;
    NSString *followTitle = [NSString stringWithFormat:@"Follow @%@", self.twitterUsername];
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:sheetTitle delegate:self cancelButtonTitle:@"Dismiss" destructiveButtonTitle:nil otherButtonTitles:followTitle, @"Twitter Timeline", @"Send Tweet", @"Send Email", nil];
    [sheet showInView:self];
}


- (void)notificationNightMode:(NSNotification*)notification {
    //NSLog(@"about view received notification: %@",notification.object);
    [self updateForNightMode:notification.object];
}


- (NSString*)stringForTwitterUsername:(NSString*)username {
    return  [NSString stringWithFormat:@"@%@",username];
}


- (void)updateForNightMode:(NSNumber*)NightMode {
    if ([NightMode isEqual:@1]) {
        self.backgroundColor = [UIColor blackColor];
        self.stefanLabel.textColor = [UIColor whiteColor];
        self.danielLabel.textColor = [UIColor whiteColor];
        self.overlayView.backgroundColor = [UIColor blackColor];
    }
    else {
        self.backgroundColor = [UIColor whiteColor];
        self.stefanLabel.textColor = [UIColor blackColor];
        self.danielLabel.textColor = [UIColor blackColor];
        self.overlayView.backgroundColor = [UIColor whiteColor];
    }
    
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
    
    NSString *danielTwitterUsername = [self stringForTwitterUsername:kAboutTwitterDaniel];
    NSString *danielString = [NSString stringWithFormat:@"Tab Dump for iOS is brought to you by %@\n%@",kAboutFullNameDaniel,danielTwitterUsername];
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:danielString];
    [attributedString2 addAttributes:colorAttribute range:[danielString rangeOfString:danielTwitterUsername]];
    [attributedString2 addAttributes:fontAttribute range:[danielString rangeOfString:kAboutFullNameDaniel]];
    [attributedString2 addAttributes:paragraphAttribute range:[danielString rangeOfString:danielString]];
    self.danielLabel.attributedText = attributedString2;
}


#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [controller dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UIActionSheetDelegate

NS_ENUM(NSInteger, AboutActionSheetSelection) {
    AboutActionSheetSelectionFollow = 0,
    AboutActionSheetSelectionTimeline,
    AboutActionSheetSelectionMessage,
    AboutActionSheetSelectionEmail,
    //AboutActionSheetSelectionCancelled,
};

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    //NSLog(@"user tapped=%d",buttonIndex);
    
    switch (buttonIndex) {
        case AboutActionSheetSelectionFollow: {
            if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
                NSLog(@"oops no twitter");
                return;
            }
                        
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
            DKWebViewController *webViewController = [[DKWebViewController alloc] initWithURLString:self.twitterUrlString];
            [[self dk_viewController].navigationController  pushViewController:webViewController animated:YES];
        }
            break;
            
        case AboutActionSheetSelectionMessage: {
            if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
                NSLog(@"oops no twitter");
                return;
            }
            
            //TODO: show account picker for users with multiple accounts
            
            NSString *textToShare = [NSString stringWithFormat:@"@%@ ",self.twitterUsername];
            SLComposeViewController *mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            [mySLComposerSheet setInitialText:textToShare];
            
            [[self dk_viewController] presentViewController:mySLComposerSheet animated:YES completion:nil];
        }
            break;
            
        case AboutActionSheetSelectionEmail: {
            if (![MFMailComposeViewController canSendMail]) {
                NSLog(@"oops no email set up");
                //TODO: handle this case
                return;
            }
            
            MFMailComposeViewController *mailComposeVC = [[MFMailComposeViewController alloc] init];
            mailComposeVC.mailComposeDelegate = self;
            [mailComposeVC setMessageBody:@"" isHTML:NO ];
            [mailComposeVC setToRecipients:@[self.email]];
            [mailComposeVC setSubject:@"Feedback from Tab Dump for iOS"];
            
            [[self dk_viewController] presentViewController:mailComposeVC animated:YES completion:nil];
        }
            break;
            
        default:
            NSLog(@"action sheet default: selected index=%@", @(buttonIndex));
            break;
    }
}


@end
