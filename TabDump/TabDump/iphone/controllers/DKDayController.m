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
#import "UIViewController+TD.h"

// Controllers
#import "DKWebViewController.h"

// Defines
#import "DKTabDumpDefines.h"

// Models
#import "DKDevice.h"
#import "DKTabDump.h"
#import "DKTab.h"

// Views
#import "DKTabCell.h"
#import "DKAboutView.h"


@interface DKDayController () <UIGestureRecognizerDelegate>
@property (nonatomic,strong) NSArray *dataSource;
@property (nonatomic) NSUInteger currentRow;
@property (nonatomic) NSUInteger currentSection;
@property (nonatomic,strong) UIRefreshControl *tableRefreshControl;
@property (nonatomic) BOOL didScroll;

@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong) UILabel *tabDumpLabel;

@property (nonatomic,strong) DKAboutView *aboutView;

@property (nonatomic,strong) NSString *currentTitle;
@end

@implementation DKDayController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.didScroll = NO;
        self.currentSection = 0;
        self.view.backgroundColor = [UIColor whiteColor];
        
        self.tableRefreshControl = [[UIRefreshControl alloc] init];
        [self.tableRefreshControl addTarget:self action:@selector(actionRefresh) forControlEvents:UIControlEventValueChanged];
        self.refreshControl = self.tableRefreshControl;
        
        UILongPressGestureRecognizer *gestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        gestureRecognizer.minimumPressDuration = 0.9; //seconds
        gestureRecognizer.delegate = self;
        [self.tableView addGestureRecognizer:gestureRecognizer];
        
        self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.dk_width, [DKDevice headerHeight])];
        CGRect frame = self.headView.frame;
        frame.origin.x = 4;
        self.tabDumpLabel = [[UILabel alloc] initWithFrame:frame];
        self.tabDumpLabel.numberOfLines = 0;
        self.tabDumpLabel.font = [UIFont fontWithName:kFontBold size:70];
        NSString *tabDumpText = @"TAB\nDUMP";
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 0;
        paragraphStyle.maximumLineHeight = 68;
        paragraphStyle.alignment = NSTextAlignmentCenter;
        NSMutableAttributedString *tabDumpAttributedString = [[NSMutableAttributedString alloc] initWithString:tabDumpText attributes:@{ NSKernAttributeName:@(13), NSParagraphStyleAttributeName:paragraphStyle} ];
        self.tabDumpLabel.attributedText = tabDumpAttributedString;
        [self.headView addSubview:self.tabDumpLabel];
        self.tableView.tableHeaderView = self.headView;
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        if (![DKDevice isIpad]) {
            self.aboutView = [[DKAboutView alloc] initWithFrame:CGRectMake(0, 0, self.view.dk_width, kAboutViewHeight)];
            self.tableView.tableFooterView = self.aboutView;
        }
    }
    return self;
}


- (void)setDump:(DKTabDump *)dump {
    _dump = dump;
    
    [self scrollToTop];
    
    self.dataSource = @[
                        dump.tabsTech,
                        dump.tabsWorld,
                        ];
    
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [self.tableView reloadData];
}


#pragma mark - UIVIewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
    NSNumber *nightMode = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsSettingsNightMode];
    if ([nightMode isEqual:@1]) {
        self.headView.backgroundColor = [UIColor blackColor];
        self.tabDumpLabel.textColor = [UIColor whiteColor];
    }
    else {
        self.headView.backgroundColor = [UIColor whiteColor];
        self.tabDumpLabel.textColor = [UIColor blackColor];
    }
    
    [self td_updateBackgroundColorForNightMode];
    
    if (self.currentTitle)
        self.title = self.currentTitle;
}


- (void)viewWillDisappear:(BOOL)animated {
    self.title = self.currentTitle;
    self.title = @" ";
    
    [super viewWillDisappear:animated];
}


#pragma mark - Public

- (void)scrollToNextTab {
    self.currentRow++;
    //NSLog(@"self.dump.tabsTech.count=%d",self.dump.tabsTech.count);
    
    if (self.currentSection==0) {
        if (self.currentRow>(self.dump.tabsTech.count-1)) {
            self.currentRow = 0;
            self.currentSection = 1;
        }
    }
    else if (self.currentRow> (self.dump.tabsWorld.count-1)) {
        NSLog(@"reached the end!");
        [self.delegate DKDayControllerDidScroll];
        return;
    }
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentRow inSection:self.currentSection] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}


- (void)scrollToTop {
    [self.tableView scrollRectToVisible:CGRectMake(0, -1, 1, 1) animated:YES];
    
    self.currentSection = 0;
    self.currentRow = -1;
    self.didScroll = NO;
    
    [self.delegate DKDayControllerScrolledToTop];
}


#pragma mark - Private

- (void)actionRefresh {
    [self.delegate DKDayControllerRequestRefresh];
    [self.tableRefreshControl endRefreshing];
}


- (void)actionShare:(UIButton*)button {
    DKTabCell *cell = [button dk_firstSuperviewOfClass:[DKTabCell class]];
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
            DKTab *link = self.dataSource[indexPath.section][indexPath.row];
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

CGFloat headerHeight = 30;

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return headerHeight;
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.dk_width, headerHeight)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:headerView.frame];
    label.textAlignment = NSTextAlignmentCenter;

    label.font = [UIFont fontWithName:kFontBold size:15];
    
    NSString *labelText = @"Bits and Bytes";
    if (section==1) {
        labelText = @"The Real World";
    }
    label.text = labelText;
    
    //color
    NSNumber *nightMode = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsSettingsNightMode];
    if ([nightMode isEqual:@1]) {
       // headerView.backgroundColor = [UIColor redColor];
        
        label.backgroundColor = [UIColor blackColor];
        label.textColor = [UIColor whiteColor];
    }
    else {
       // headerView.backgroundColor = [UIColor orangeColor];
        
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = [UIColor td_dayTabCategoryColor];
    }
    
    [headerView addSubview:label];
    return headerView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSArray *datasource = self.dataSource[section];
    return datasource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *detailCellId = @"detailCellId";
    DKTabCell *cell = [tableView dequeueReusableCellWithIdentifier:detailCellId];
    if (cell==nil) {
        cell = [[DKTabCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:detailCellId];
    }
    
    NSArray *datasource = self.dataSource[indexPath.section];
    DKTab *link = datasource[indexPath.row];
    cell.link = link;
    [cell.shareButton addTarget:self action:@selector(actionShare:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *datasource = self.dataSource[indexPath.section];
    DKTab *link = datasource[indexPath.row];    
    CGFloat height = [link heightForRow];
    
    return height;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *datasource = self.dataSource[indexPath.section];
    DKTab *link = datasource[indexPath.row];
    
    if ([link.urlString dk_containsString:kDetailiTunesLink]) {
        NSURL *url = [NSURL URLWithString:link.urlString];
        [[UIApplication sharedApplication] openURL:url];
        return;
    }
    
    DKWebViewController *webController = [[DKWebViewController alloc] initWithURLString:link.urlString];
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
    
    /*
     self.currentSection = 0;
     self.currentRow = 0;
     self.didScroll = NO;
     [self.delegate DKDayControllerScrolledToTop];*/
    [self scrollToTop];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat kOffsetMystery = 178;
    //    NSLog(@"scrollview size=%@, offset=%@",@(scrollView.contentSize.height-kAboutViewHeight-kDayHeaderHeight-kOffsetMystery), @(scrollView.contentOffset.y));
    CGFloat difference = scrollView.contentSize.height-kAboutViewHeight-[DKDevice headerHeight]-kOffsetMystery - scrollView.contentOffset.y;
    CGFloat alpha = difference*0.75/kOffsetMystery;
    //NSLog(@"scroll difference=%@",@(alpha));
    self.aboutView.overlayView.alpha = alpha;
}


@end
