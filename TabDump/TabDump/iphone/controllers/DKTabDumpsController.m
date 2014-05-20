//
//  DKTabDumpsController.m
//  TabDump
//
//  Created by Daniel on 4/22/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import "DKTabDumpsController.h"

// Categories
#import "UIColor+TD.h"
#import "UIImage+DK.h"

// Defines
#import "DKTabDumpDefines.h"

// Models
#import "DKTabDump.h"
#import "DKTab.h"

// Views
#import "DKAboutView.h"
#import "DKTabDumpCell.h"

@interface DKTabDumpsController ()
@property (nonatomic,strong) DKAboutView *aboutView;
@end

@implementation DKTabDumpsController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.tableView.separatorInset = UIEdgeInsetsZero;
        
        self.aboutView = [[DKAboutView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, kAboutViewHeight)];
        self.tableView.tableFooterView = self.aboutView;

        // navigation buttons
        UIImage *xImage = [UIImage dk_maskedImageNamed:@"top-x" color:[UIColor td_highlightColor]];
        UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [closeButton setImage:xImage forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(actionClose) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *closeBarButton = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
        
        UIBarButtonItem *spacerBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spacerBarButton.width = -14;
        
        self.navigationItem.leftBarButtonItems = @[spacerBarButton, closeBarButton];
    }
    return self;
}


- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    [self.tableView reloadData];
}


#pragma mark - Private

- (void)actionClose {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (NSUInteger)dumpIndexForIndexPathRow:(NSInteger)row max:(NSInteger)max {
    NSUInteger dumpIndex = row+1; // skip first entry
    
    if (dumpIndex==0) {
        dumpIndex=1;
    }
    
    if (dumpIndex>max-1) {
        dumpIndex=2;
    }
    
    return dumpIndex;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *listCellId = @"listCellId";
    DKTabDumpCell  *cell = [tableView dequeueReusableCellWithIdentifier:listCellId];
    if (cell == nil) {
        cell = [[DKTabDumpCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:listCellId];
    }
    
    DKTabDump *dump = self.dataSource[indexPath.row];
    
    //NSLog(@"dump.tabstech.count=%@",@(dump.tabsTech.count));
    DKTab *link = dump.tabsTech[[self dumpIndexForIndexPathRow:indexPath.row max:dump.tabsTech.count]];
    [cell setupWithDump:dump link:link];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DKTabDump *dump = self.dataSource[indexPath.row];
    [_delegate DKTabDumpsControllerSelectedDump:dump];
    [self dismissViewControllerAnimated:YES completion:nil ];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DKTabDump *dump = self.dataSource[indexPath.row];
    DKTab *link = dump.tabsTech[[self dumpIndexForIndexPathRow:indexPath.row max:dump.tabsTech.count]];
    CGFloat height = [link sizeForStrippedHTML].height +50;
    return height;
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat kOffsetMystery = 178;
    CGFloat difference = scrollView.contentSize.height-kAboutViewHeight-kDayHeaderHeight-kOffsetMystery - scrollView.contentOffset.y;
    CGFloat alpha = difference*0.75/kOffsetMystery;
    self.aboutView.overlayView.alpha = alpha;
}


@end
