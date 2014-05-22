//
//  DKSettingsController.m
//  TabDump
//
//  Created by Daniel on 5/14/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import "DKSettingsController.h"

// Categories
#import "UIColor+TD.h"
#import "UIView+DK.h"
#import "UIViewController+DK.h"
#import "UIViewController+TD.h"

// Controllers
#import "DKAboutController.h"

// Defines
#import "DKTabDumpDefines.h"

// Models
#import "DKTab.h"

// Views
#import "DKDayCell.h"


@interface DKSettingsController ()
@property (nonatomic,strong) NSArray *dataSource;
@property (nonatomic,strong) NSArray *dataSourceSub;
@property (nonatomic,strong) DKDayCell *preview;
@property (nonatomic,strong) DKAboutController *aboutCOntroller;
@end

@implementation DKSettingsController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self td_addBackButtonPop];
        
        self.dataSource = @[
                            @"Category Colors",
                            @"Action Buttons",
                            ];
        
        self.dataSourceSub = @[
                               @"Color based on category",
                               @"You can also share with a long press",
                               ];
        
        
        self.preview = [[DKDayCell alloc] initWithFrame:CGRectZero];
        
        self.aboutCOntroller = [[DKAboutController alloc] init];
        [self dk_addChildController:self.aboutCOntroller];
        
        self.tableView.rowHeight = 55;
    }
    return self;
}


- (void)setPreviewTab:(DKTab *)previewTab {
    _previewTab = previewTab;
    
    self.preview.link = previewTab;
    NSNumber *categoryColors = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsSettingsCategoryColors];
    if ([categoryColors isEqual:@1]) {
        self.preview.backgroundColor = [self.previewTab colorForCategory];
    }
    else {
        self.preview.backgroundColor = [UIColor whiteColor];
    }
    
    CGRect frame = self.preview.frame;
    CGFloat padding = kCellPadding;
    CGFloat shareEyeButtonsOffset = 40;
    CGFloat height = [previewTab sizeForStrippedHTML].height +padding*2 +shareEyeButtonsOffset;
    frame.size.height = height;
    self.preview.frame = frame;
    [self.preview dk_addBottomBorderWithColor:[UIColor lightGrayColor] width:0.5];
    self.tableView.tableHeaderView = self.preview;
    
    frame.size.height = 550;
    if (self.view.dk_height<500) {
        frame.size.height -= 88;
    }
    self.aboutCOntroller.view.frame = frame;
    [self.aboutCOntroller.view dk_addTopBorderWithColor:[UIColor lightGrayColor] width:0.5];
    self.tableView.tableFooterView = self.aboutCOntroller.view;
    
    CGFloat inset = 10;
    frame.size = CGSizeMake(114, 24);
    frame.origin.x = inset;
    frame.origin.y = self.preview.dk_height -frame.size.height -inset;
    UILabel *previewLabel = [[UILabel alloc] initWithFrame:frame];
    previewLabel.text = @"settings preview";
    previewLabel.textAlignment = NSTextAlignmentCenter;
    previewLabel.font = [UIFont systemFontOfSize:12];
    previewLabel.textColor = [UIColor lightGrayColor];
    previewLabel.layer.cornerRadius = 12;
    [previewLabel dk_addBorderWithColor:[UIColor lightGrayColor] width:0.5];
    [self.preview addSubview:previewLabel];
    
}


#pragma mark - UIViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    
    NSString *text = self.dataSource[indexPath.row];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
        
        cell.textLabel.font = [UIFont fontWithName:kFontRegular size:12];
        
        cell.detailTextLabel.font = [UIFont fontWithName:kFontRegular size:10];
        cell.detailTextLabel.textColor = [UIColor grayColor];
        
        UISwitch *optionSwitch = [[UISwitch alloc] init];
        optionSwitch.onTintColor = [UIColor td_highlightColor];
        [optionSwitch addTarget:self action:@selector(actionSwitch:) forControlEvents:UIControlEventValueChanged];
        optionSwitch.tag = indexPath.row;
        cell.accessoryView = optionSwitch;
        
        // read from nsuser defaults
        if ([text isEqualToString:self.dataSource[0]]) {
            NSNumber *categoryColors = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsSettingsCategoryColors];
            optionSwitch.on = [categoryColors isEqualToNumber:@1] ? YES:NO;
        }
        
        if ([text isEqualToString:self.dataSource[1]]) {
            NSNumber *actionButtons = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsSettingsActionButtons];
            optionSwitch.on = [actionButtons isEqualToNumber:@1] ? YES:NO;
        }
    }
    
    cell.textLabel.text = text;
    cell.detailTextLabel.text = self.dataSourceSub[indexPath.row];
    
    
    return cell;
}


#pragma mark - Private

- (void)actionSwitch:(UISwitch*)switchControl {
    NSNumber *number = switchControl.isOn ? @1 : @0;

    NSString *key = switchControl.tag==0 ? kUserDefaultsSettingsCategoryColors : kUserDefaultsSettingsActionButtons;
    //NSLog(@"set number to %@ on key=%@",number,key);
    
    [[NSUserDefaults standardUserDefaults] setObject:number forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.preview.link = self.previewTab;
    
    NSNumber *categoryColors = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsSettingsCategoryColors];
    if ([categoryColors isEqual:@1]) {
        self.preview.backgroundColor = [self.previewTab colorForCategory];
    }
    else {
        self.preview.backgroundColor = [UIColor whiteColor];
    }
    
}


@end
