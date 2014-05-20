//
//  DKDayController.m
//  TabDump
//
//  Created by Daniel on 4/22/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import "DKDayController.h"

// Activity
#import "DKTabActivityItemProvider.h"
#import "DKBufferActivity.h"
#import "DKDraftsActivity.h"

// Categories
#import "NSString+DK.h"
#import "UIColor+TD.h"
#import "UIView+DK.h"

// Defines
#import "DKTabDumpDefines.h"

// Models
#import "DKTabDump.h"
#import "DKTab.h"

// Libraries
#import "SVWebViewController.h"

// Views
#import "DKDayCell.h"
#import "DKAboutView.h"


@interface DKDayController () <UIGestureRecognizerDelegate>
@property (nonatomic,strong) NSArray *dataSource;
@property (nonatomic) NSUInteger currentRow;
@property (nonatomic,strong) UIRefreshControl *tableRefreshControl;
@property (nonatomic) BOOL didScroll;
@end

@implementation DKDayController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.didScroll = NO;
        
        self.tableRefreshControl = [[UIRefreshControl alloc] init];
        [self.tableRefreshControl addTarget:self action:@selector(actionRefresh) forControlEvents:UIControlEventValueChanged];
        self.refreshControl = self.tableRefreshControl;
        
        UILongPressGestureRecognizer *gestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        gestureRecognizer.minimumPressDuration = 0.9; //seconds
        gestureRecognizer.delegate = self;
        [self.tableView addGestureRecognizer:gestureRecognizer];
        
        UILabel *tabDumpLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.dk_width, kDayHeaderHeight)];
        tabDumpLabel.numberOfLines = 0;
        tabDumpLabel.font = [UIFont fontWithName:kFontBold size:66];
        NSString *tabDumpText = @"TAB\nDUMP";
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 0;
        paragraphStyle.maximumLineHeight = 68;
        paragraphStyle.alignment = NSTextAlignmentCenter;
        NSMutableAttributedString *tabDumpAttributedString = [[NSMutableAttributedString alloc] initWithString:tabDumpText attributes:@{ NSKernAttributeName:@(14), NSParagraphStyleAttributeName:paragraphStyle} ];
        tabDumpLabel.attributedText = tabDumpAttributedString;
        self.tableView.tableHeaderView = tabDumpLabel;
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        DKAboutView *footerView = [[DKAboutView alloc] initWithFrame:CGRectMake(0, 0, self.view.dk_width, kAboutViewHeight)];
        self.tableView.tableFooterView = footerView;
    }
    return self;
}


- (void)setDump:(DKTabDump *)dump {
    _dump = dump;
    
    self.currentRow = 0;
    self.didScroll = NO;
    
    self.dataSource = dump.links;
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [self.tableView reloadData];
}


/*
 #pragma mark - UIVIewController
 
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 self.title = [_dump title];
 }
 
 
 
 - (void)viewWillDisappear:(BOOL)animated {
 self.title = @" ";
 [super viewWillDisappear:animated];
 }*/


#pragma mark - Public

- (void)scrollToNextTab {
    self.currentRow++;
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentRow inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}


#pragma mark - Private

- (void)actionRefresh {
    [self.delegate DKDayControllerRequestRefresh];
    [self.tableRefreshControl endRefreshing];
}


- (void)actionNext {
    self.currentRow++;
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentRow inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}

- (void)actionShare:(UIButton*)button {
    DKDayCell *cell = [button dk_firstSuperviewOfClass:[DKDayCell class]];
    DKTab *link = cell.link;
    
    [self share:link];
}


- (BOOL)canOpenApp:(NSString*)customURL {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:customURL]]) {
        return YES;
    }
    
    return NO;
}


- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint p = [gestureRecognizer locationInView:self.tableView];
        
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:p];
        if (indexPath != nil) {
            DKTab *link = self.dataSource[indexPath.row];
            [self share:link];
        }
    }
}


- (void)share:(DKTab*)link {
    NSString *textToShare = link.tabText;
    DKTabActivityItemProvider *textProvider = [[DKTabActivityItemProvider alloc] initWithText:textToShare];
    NSURL *urlToShare = [NSURL URLWithString:link.urlString];
    NSArray *activityItems = @[textProvider, urlToShare];
    
    NSMutableArray *applicationActivities = [[NSMutableArray alloc] init];
    if ([self canOpenApp:kBufferURLScheme]) {
        DKBufferActivity *bufferActivity = [[DKBufferActivity alloc]init];
        bufferActivity.text = [DKTabActivityItemProvider twitterShareStringFromText:textToShare];
        bufferActivity.url = urlToShare.absoluteString;
        [applicationActivities addObject:bufferActivity];
    }
    
    if ([self canOpenApp:kDraftsURLScheme]) {
        DKDraftsActivity *draftsActivity = [[DKDraftsActivity alloc]init];
        draftsActivity.content = [NSString stringWithFormat:@"%@\n%@",textToShare,urlToShare.absoluteString];
        [applicationActivities addObject:draftsActivity];
    }
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:applicationActivities];
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll, UIActivityTypePostToFlickr, UIActivityTypePostToVimeo];
    [self presentViewController:activityVC animated:YES completion:nil];
}


#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //[cell setBackgroundColor:[UIColor redColor]];
    DKTab *link = self.dataSource[indexPath.row];
    cell.backgroundColor = [link colorForCategory];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *detailCellId = @"detailCellId";
    DKDayCell *cell = [tableView dequeueReusableCellWithIdentifier:detailCellId];
    if (cell==nil) {
        cell = [[DKDayCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:detailCellId];
    }
    
    DKTab *link = self.dataSource[indexPath.row];
    cell.link = link;
    [cell.shareButton addTarget:self action:@selector(actionShare:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DKTab *link = self.dataSource[indexPath.row];
    
    CGFloat padding = kCellPadding;
    CGFloat shareEyeButtonsOffset = 40;
    CGFloat height = [link sizeForStrippedHTML].height +padding*2 +shareEyeButtonsOffset;
    
    return height;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DKTab *link = self.dataSource[indexPath.row];
    
    if ([link.urlString dk_containsString:kDetailiTunesLink]) {
        NSURL *url = [NSURL URLWithString:link.urlString];
        [[UIApplication sharedApplication] openURL:url];
        return;
    }
    
    SVWebViewController *webController = [[SVWebViewController alloc] initWithAddress:link.urlString];
    webController.title = @"Loading";
    [self.navigationController pushViewController:webController animated:YES];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (!self.didScroll) {
        [self.delegate DKDayControllerDidScroll];
        self.didScroll = YES;
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    //NSLog(@"day scrolled to top");
    self.didScroll = NO;
    [self.delegate DKDayControllerScrolledToTop];
}

@end
