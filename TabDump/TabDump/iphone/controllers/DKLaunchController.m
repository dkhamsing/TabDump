//
//  DKLaunchController.m
//  TabDump
//
//  Created by Daniel on 4/22/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import "DKLaunchController.h"

// Categories
#import "NSString+DK.h"
#import "UIColor+TD.h"
#import "UIImage+DK.h"
#import "UIView+DK.h"
#import "UIViewController+DK.h"

// Controllers
#import "DKAboutController.h"
#import "DKDayController.h"
#import "DKTabDumpsController.h"

// Defines
#import "DKTabDumpDefines.h"

// Models
#import "DKTabDump.h"

// Libraries
#import "AFNetworking.h"
//#import "CWStatusBarNotification.h"
#import "DKUserMessageView.h"


@interface DKLaunchController () <DKTabDumpsControllerDelegate, DKDayControllerDelegate>
@property (nonatomic,strong) NSString *currentTitle;

@property (nonatomic,strong) DKTabDumpsController *tabDumpsController;
@property (nonatomic,strong) DKDayController *dayController;

@property (nonatomic,strong) UIView *loadingView;
@property (nonatomic,strong) DKUserMessageView *loadingSpinner;
@property (nonatomic,strong) DKUserMessageView *loadingText;
@property (nonatomic,strong) UIButton *reloadButton;

@property (nonatomic,strong) UIButton *scrollButton;
@end

@implementation DKLaunchController

CGFloat kNavigationButtonInset = -7;
CGRect kNavigationButtonFrame = {0,0,30,44};
CGFloat kNavigationBarHeight = 64;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // style
        [[UINavigationBar appearance] setTintColor:[UIColor td_highlightColor]];
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:kFontBold size:15]}];
        [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:kFontRegular size:11]} forState:UIControlStateNormal];
        
        // init
        self.tabDumpsController = [[DKTabDumpsController alloc] init];
        self.tabDumpsController.delegate = self;
        
        self.dayController = [[DKDayController alloc] initWithStyle:UITableViewStyleGrouped];
        self.dayController.delegate = self;
        [self dk_addChildController:self.dayController];
        
        // navigaton bar
        UIBarButtonItem *spacerBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spacerBarButton.width = kNavigationButtonInset;
        UIImage *infoImage = [UIImage dk_maskedImageNamed:@"top-question" color:[UIColor td_highlightColor]];
        UIButton *infoButton = [[UIButton alloc] initWithFrame:kNavigationButtonFrame];
        [infoButton setImage:infoImage forState:UIControlStateNormal];
        [infoButton addTarget:self action:@selector(actionAbout) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *aboutBarButton = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
        UIImage *listImage = [UIImage dk_maskedImageNamed:@"top-list" color:[UIColor td_highlightColor]];
        
        UIButton *listButton = [[UIButton alloc] initWithFrame:kNavigationButtonFrame];
        [listButton setImage:listImage forState:UIControlStateNormal];
        [listButton addTarget:self action:@selector(actionList) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *listBarButton = [[UIBarButtonItem alloc]initWithCustomView:listButton];
        self.navigationItem.leftBarButtonItems = @[spacerBarButton, listBarButton, aboutBarButton];
        
        self.scrollButton = [[UIButton alloc] init];
        [self setupRightButtons];
        
        // loading
        CGFloat inset = 10;
        self.loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, kDayHeaderHeight +kNavigationBarHeight, self.view.dk_width, self.view.dk_height)];
        self.loadingView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.loadingView];
        
        CGRect frame = CGRectMake(0, inset, self.view.dk_width, 40);
        self.loadingSpinner = [[DKUserMessageView alloc] initWithFrame:frame];
        self.loadingText = [[DKUserMessageView alloc] initWithFrame:CGRectMake(0, self.loadingSpinner.dk_bottom +inset, self.view.dk_width, 20)];
        self.loadingText.dk_userMessageLabel.textColor = [UIColor grayColor];
        self.loadingText.dk_userMessageLabel.font = [UIFont fontWithName:kFontRegular size:11];
        
        frame = self.loadingText.frame;
        frame.origin.y = self.loadingText.dk_bottom +inset;
        self.reloadButton = [[UIButton alloc] initWithFrame:frame];
        self.reloadButton.titleLabel.font = self.loadingText.dk_userMessageLabel.font;
        [self.reloadButton setTitle:@"Reload" forState:UIControlStateNormal];
        [self.reloadButton setTitleColor:[UIColor td_highlightColor] forState:UIControlStateNormal];
        [self.reloadButton addTarget:self action:@selector(loadTabDumpRSS) forControlEvents:UIControlEventTouchUpInside];
        [UIView dk_addSubviews:@[self.loadingSpinner, self.loadingText, self.reloadButton] onView:self.loadingView];
        
        [self loadTabDumpInitial];
    }
    return self;
}


#pragma mark - UIViewController

- (void)viewWillDisappear:(BOOL)animated {
    self.title = @" ";
    [super viewWillDisappear:animated];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = self.currentTitle;
    
    if (self.title) {
        // flash title if it is today or yesterday
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
        //NSLog(@"components=%@",components);
        
        NSString *titleDate = [self.title substringToIndex:[self.title rangeOfString:@":"].location];
        titleDate = [titleDate stringByAppendingFormat:@" %@", @(components.year)];
        // NSLog(@"title date=%@",titleDate);
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MM dd yyyy"];
        
        NSDate *date = [dateFormat dateFromString:titleDate];
        //NSLog(@"date=%@",date);
        NSDateComponents *titleComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth fromDate:date];
        //NSLog(@"components=%@",titleComponents);
        
        if (titleComponents.month == components.month) {
            if (titleComponents.day==components.day
                ) {
                self.title = @"Today";
            }
            else if (titleComponents.day-components.day == -1) {
                self.title = @"Yesterday";
            }
            
            //NSLog(@"compute %d",titleComponents.day-components.day);
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.title = self.currentTitle;
            });
        }
    }
}


#pragma mark - Private

- (void)actionAbout {
    DKAboutController *aboutController = [[DKAboutController alloc] init];
    [self.navigationController pushViewController:aboutController animated:YES];
}


- (void)actionList {
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.tabDumpsController];
    self.tabDumpsController.title = kLaunchTitle;
    [self presentViewController:navigationController animated:YES completion:nil];
}


- (void)actionNext {
    [self.dayController scrollToNextTab];
}


- (void)actionTop {
    [self.dayController scrollToTop];
}


- (UIImage *)ipMaskedImageNamed:(NSString *)name color:(UIColor *)color {
    UIImage *image = [UIImage imageNamed:name];
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, image.scale);
    CGContextRef c = UIGraphicsGetCurrentContext();
    [image drawInRect:rect];
    CGContextSetFillColorWithColor(c, [color CGColor]);
    CGContextSetBlendMode(c, kCGBlendModeSourceAtop);
    CGContextFillRect(c, rect);
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}


- (void)loadDump:(DKTabDump*)dump {
    self.title = [dump title];
    self.currentTitle = self.title;
    self.dayController.dump = dump;
    
    // update tab dumps read
    NSArray *tabDumpsRead = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsTabDumpsRead];
    NSMutableArray *temp;
    if (tabDumpsRead) {
        temp = [tabDumpsRead mutableCopy];
    }
    else {
        temp = [[NSMutableArray alloc] init];
    }
    if (![temp containsObject:dump.date]) {
        [temp addObject:dump.date];
    }
    [[NSUserDefaults standardUserDefaults] setObject:[temp copy] forKey:kUserDefaultsTabDumpsRead];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"tab dumps read=%@",temp);
}


- (void)loadContentAtPath:(NSString*)path {
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    if ([content dk_containsString:@"<?xml"]) {
        NSArray *dumps = [DKTabDump newListOfDumpsFromHTML:content];
        self.tabDumpsController.dataSource = dumps;
        DKTabDump *dump = dumps[0];
        
        [self loadDump:dump];
    }
    else {
        NSLog(@"launch - load content - error loading rss");
    }
}


- (void)loadBeginAnimate {
    [self.loadingSpinner dk_loading:YES spinner:YES];
    [self.loadingText dk_displayMessage:@"Loading Tab Dump"];
}


- (void)loadTabDumpInitial {
    self.loadingView.hidden = YES;
    NSString *path = [self tabDumpPath];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSLog(@"Loading previous file");
        [self loadContentAtPath:path];
    }
    else {
        self.loadingView.hidden = NO;
        [self loadBeginAnimate];
    }
    
    [self loadTabDumpRSS];
}


- (void)loadTabDumpRSS {
    self.reloadButton.hidden = YES;
    [self loadBeginAnimate];
    
    NSDate *nowDate = [NSDate date];
    //NSLog(@"now date=%@",nowDate);
    NSDate *lastDownloadDate = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsDateLastDownload];
    if (lastDownloadDate) {
        //NSLog(@"last download date = %@",lastDownloadDate);
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
        NSDateComponents *components = [calendar components:NSHourCalendarUnit|NSMinuteCalendarUnit
                                                   fromDate:lastDownloadDate
                                                     toDate:nowDate
                                                    options:0];
        
        NSLog(@"Difference in date components: %zd hours %zd mins", components.hour, components.minute);
        if (components.hour < kLaunchDownloadHourThreshold) {
            NSLog(@"less than %zd hours - stop loading rss", kLaunchDownloadHourThreshold);
            return;
        }
    }
    
    NSString *path = [self tabDumpPath];
    
    // load rss
    NSLog(@"Loading rss");
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kLaunchBlogRSSLink]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.loadingView.hidden = YES;
        
        NSLog(@"Successfully downloaded file to %@", path);
        
        // check downloaded file format (rss)
        NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        if ([content dk_containsString:@"<?xml"]) {
            [self loadContentAtPath:path];
            
            // save download date
            NSLog(@"Save download date=%@",nowDate);
            [[NSUserDefaults standardUserDefaults] setObject:nowDate forKey:kUserDefaultsDateLastDownload];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else {
            NSLog(@"launch - load tab dump rss - error loading rss");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.loadingSpinner dk_loading:NO];
        [self.loadingText dk_loading:NO];
        
        NSLog(@"Error: %@", error);
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [self.loadingText dk_displayMessage:@"There was a problem loading Tab Dump."];
            self.reloadButton.hidden = NO;
        }
    }];
    
    [operation start];
}


- (void)setupRightButtons {
    UIImage *downImage = [UIImage dk_maskedImageNamed:@"top-down" color:[UIColor td_highlightColor]];
    self.scrollButton.frame = kNavigationButtonFrame;
    
    [self.scrollButton setImage:downImage forState:UIControlStateNormal];
    [self.scrollButton addTarget:self action:@selector(actionNext) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *nextBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.scrollButton];
    UIBarButtonItem *spacerBarButton2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spacerBarButton2.width = kNavigationButtonInset -2;
    [self.navigationItem setRightBarButtonItems:@[spacerBarButton2,nextBarButton] animated:YES];
}


- (NSString *)tabDumpPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:kLaunchDownloadFilename];
    
    return path;
}


#pragma mark - Delegate

#pragma mark DKListControllerDelegate

- (void)DKTabDumpsControllerSelectedDump:(DKTabDump *)dump {
    [self loadDump:dump];
    [self setupRightButtons];
}


#pragma mark DKDayControllerDelegate

- (void)DKDayControllerDidScroll {
    //rotate
    [UIView beginAnimations:@"rotate" context:nil];
    [UIView setAnimationDuration:0.5];
    self.scrollButton.transform = CGAffineTransformMakeRotation(M_PI);
    [UIView commitAnimations];
    
    // remove target
    [self.scrollButton removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    
    // add target
    [self.scrollButton addTarget:self action:@selector(actionTop) forControlEvents:UIControlEventTouchUpInside];
}


- (void)DKDayControllerScrolledToTop {
    // rotate
    [UIView beginAnimations:@"rotate" context:nil];
    [UIView setAnimationDuration:0.5];
    self.scrollButton.transform = CGAffineTransformMakeRotation(180*M_PI);
    [UIView commitAnimations];
    
    // remove target
    [self.scrollButton removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    
    // add target
    [self.scrollButton addTarget:self action:@selector(actionNext) forControlEvents:UIControlEventTouchUpInside];
}


- (void)DKDayControllerRequestRefresh {
    [self loadTabDumpRSS];
}


@end
