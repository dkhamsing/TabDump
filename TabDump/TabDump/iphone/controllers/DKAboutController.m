//
//  DKAboutController.m
//  TabDump
//
//  Created by Daniel on 4/24/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import "DKAboutController.h"

// Categories
#import "UIColor+TD.h"
#import "UIView+DK.h"
#import "UIViewController+DK.h"

// Controllers
#import "SVWebViewController.h"

// Defines
#import "DKTabDumpDefines.h"

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
        self.title = @" ";
        self.view.backgroundColor = [UIColor whiteColor];
        
        self.aboutScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:self.aboutScrollView];
        
        self.aboutView = [[DKAboutView alloc] initWithFrame:CGRectMake(0, 0, self.view.dk_width, kAboutViewHeight)];
        
        self.webView = [[UIWebView alloc] init];
        self.webView.delegate = self;
        self.webView.backgroundColor = [UIColor whiteColor];
        //        self.webView.scrollView.showsVerticalScrollIndicator = NO;
        self.webView.scrollView.scrollsToTop = NO;
        
        [UIView dk_addSubviews:@[
                                 self.aboutView,
                                 self.webView,
                                 ] onView:self.aboutScrollView];
    }
    return self;
}


#pragma mark - UIViewController

- (void)viewWillAppear:(BOOL)animated {
    CGRect frame;

    frame.origin.x = 10;
    frame.origin.y = self.aboutView.dk_bottom;
    frame.size.width = 300;
    frame.size.height = 316;    
    [self dk_adjustHeightForSmallScreen:frame.size.height];
    self.webView.frame = frame;
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"about" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlString baseURL:nil];
}


#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //NSLog(@"%@",request.URL.absoluteString);
    if ([request.URL.absoluteString isEqualToString:@"about:blank"]) {
         return YES;
    }

    SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:request.URL];
    webViewController.title = @"Loading";
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
