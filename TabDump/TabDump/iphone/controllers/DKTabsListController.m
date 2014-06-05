//
//  DKTabsListController.m
//  TabDump
//
//  Created by Daniel on 5/17/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import "DKTabsListController.h"

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
#import "DKTab.h"

// Views
#import "DKAboutView.h"
#import "DKTabCell.h"


@interface DKTabsListController ()
@property (nonatomic,strong) DKAboutView *aboutView;
@property (nonatomic,strong) NSString *currentTitle;
@end

@implementation DKTabsListController

CGRect kNavigationButtonFrame1 = {0,0,30,44};

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        //[self td_addBackButtonPop];
        
        self.aboutView = [[DKAboutView alloc] initWithFrame:CGRectMake(0, 0, self.view.dk_width, kAboutViewHeight)];
        self.aboutView.overlayView.alpha = 0.2;
        self.tableView.tableFooterView = self.aboutView;
        
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
    }
    
    DKTab *tab = self.dataSource[indexPath.row];
    cell.link=tab;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DKTab *tab = self.dataSource[indexPath.row];
    
    CGFloat padding = kCellPadding;
    
    CGFloat shareEyeButtonsOffset = 40;
    
    CGFloat height = [tab sizeForStrippedHTML].height +padding*2 +shareEyeButtonsOffset;

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
