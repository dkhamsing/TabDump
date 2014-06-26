//
//  DKTabsListController.m
//  TabDump
//
//  Created by Daniel on 5/17/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import "DKTabsListController.h"

// Activity
#import "DKTabActivityItemProvider.h"
#import "DKBufferActivity.h"
#import "DKDraftsActivity.h"

// Categories
#import "NSString+DK.h"
#import "UIColor+TD.h"
#import "UIImage+DK.h"
#import "UIView+DK.h"
#import "UIViewController+TD.h"

// Controllers
#import "DKSettingsController.h"
#import "DKWebViewController.h"

// Defines
#import "DKTabDumpDefines.h"

// Models
#import "DKDevice.h"
#import "DKTab.h"

// Views
#import "DKTabCell.h"


@interface DKTabsListController ()
@property (nonatomic,strong) NSString *currentTitle;
@end

@implementation DKTabsListController

CGRect kNavigationButtonFrame1 = {0,0,30,44};

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {       
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIImage *infoImage = [UIImage dk_maskedImageNamed:@"top-gears" color:[UIColor td_highlightColor]];
        UIButton *infoButton = [[UIButton alloc] initWithFrame:kNavigationButtonFrame1];
        [infoButton setImage:infoImage forState:UIControlStateNormal];
        [infoButton addTarget:self action:@selector(actionSettings) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *aboutBarButton = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
        self.navigationItem.rightBarButtonItem = aboutBarButton;        
    }
    return self;
}


- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    [self.tableView reloadData];
}


#pragma mark - UIView Controller

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.tableView reloadData];
    
    [self td_updateBackgroundColorForNightMode];
    
    if (self.currentTitle)
        self.title = self.currentTitle;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.currentTitle = self.title;
    self.title = @" ";
    [super viewWillDisappear:animated];
}


#pragma mark - Private

- (void)actionSettings {
    DKSettingsController *settingsController = [[DKSettingsController alloc] init];    
    [self.navigationController pushViewController:settingsController animated:YES];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = @"tabsListCell";
    DKTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[DKTabCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.isCategory = YES;
        [cell.shareButton addTarget:self action:@selector(actionShare:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    DKTab *tab = self.dataSource[indexPath.row];
    cell.link=tab;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DKTab *tab = self.dataSource[indexPath.row];
    
    CGFloat height = [tab heightForRow];

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
    
    DKWebViewController *webController = [[DKWebViewController alloc] initWithURLString:link.urlString];
    [webController td_setup];
    [self.navigationController pushViewController:webController animated:YES];
}


@end
