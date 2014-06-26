//
//  DKAboutController.m
//  TabDump
//
//  Created by Daniel on 4/24/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import "DKAboutController.h"

// Categories
#import "UIView+DK.h"
#import "UIViewController+DK.h"
#import "UIViewController+TD.h"

// Controllers
#import "DKSettingsController.h"
#import "DKWebViewController.h"

// Defines
#import "DKTabDumpDefines.h"

// Models
#import "DKDevice.h"

// Views
#import "DKAboutView.h"


@interface DKAboutController () <UIWebViewDelegate>
@property (nonatomic,strong) UIScrollView *aboutScrollView;
@property (nonatomic,strong) DKAboutView *aboutView;
@property (nonatomic,strong) UIWebView *webView;
@end

@implementation DKAboutController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //[self td_addBackButtonPop];
        self.title = @" ";
        
        self.aboutScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:self.aboutScrollView];
        
        self.aboutView = [[DKAboutView alloc] init];
        self.aboutView.overlayView.alpha = 0;
        
        self.webView = [[UIWebView alloc] init];
        self.webView.delegate = self;
        self.webView.backgroundColor = [UIColor whiteColor];
        self.webView.scrollView.scrollEnabled = NO;
        self.webView.scrollView.scrollsToTop = NO;
        
        [UIView dk_addSubviews:@[
                                 self.aboutView,
                                 self.webView,
                                 ] onView:self.aboutScrollView];        
    }
    return self;
}


#pragma mark - UIViewController

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.aboutScrollView.frame = self.view.bounds;
}


- (void)viewWillAppear:(BOOL)animated {
    CGRect frame;
    
    CGFloat inset = 0;
    if ([DKDevice isIpad])
        inset = 80;    
    frame = CGRectMake(0, inset, 320, kAboutViewHeight);
    frame.origin.x = (self.view.dk_width - frame.size.width)/2;
    self.aboutView.frame = frame;
    
    frame.origin.y = self.aboutView.dk_bottom +inset;
    frame.size.width = 300;
    frame.size.height = 316;
    frame.origin.x = (self.view.dk_width - frame.size.width)/2;
    [self dk_adjustHeightForSmallScreen:frame.size.height];
    self.webView.frame = frame;
    
    NSNumber *nightMode = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsSettingsNightMode];
    [self setColorForNightMode:nightMode];
}


#pragma mark - Public

- (void)setColorForNightMode:(NSNumber*)nightMode {
    
    [self td_updateBackgroundColorForNightMode];
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"about" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    if ([nightMode isEqual:@1]) {
        htmlString = [htmlString stringByReplacingOccurrencesOfString:@"color: black; background-color: white;" withString:@"color: white; background-color: black;"];
    }
    
    [self.webView loadHTMLString:htmlString baseURL:nil];
}


#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //NSLog(@"%@",request.URL.absoluteString);
    if ([request.URL.absoluteString isEqualToString:@"about:blank"]) {
        return YES;
    }
    
    DKWebViewController *webViewController = [[DKWebViewController alloc] initWithURL:request.URL];
    [webViewController td_setup];    
    [self.navigationController pushViewController:webViewController animated:YES];
    
    return NO;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    CGRect frame = webView.frame;
    frame.size.height = webView.scrollView.contentSize.height;
    webView.frame = frame;
    
    CGSize size = self.aboutScrollView.contentSize;
    size.height = frame.size.height +kAboutViewHeight;
    self.aboutScrollView.contentSize = size;
}


@end
