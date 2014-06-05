//
//  DKSettingsController.m
//  TabDump
//
//  Created by Daniel on 5/14/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import "DKSettingsController.h"

// Categories
#import "UIColor+DK.h"
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
#import "DKTabCell.h"


@interface DKSettingsController ()
@property (nonatomic,strong) NSArray *dataSource;
@property (nonatomic,strong) NSArray *sectionHeaders;
@property (nonatomic,strong) DKTab *previewTab;
@end

@implementation DKSettingsController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //[self td_addBackButtonPop];
        self.title = @" ";
        
        self.sectionHeaders = @[
                                @"Display Preview",
                                @"Display Settings",
                                @"About",
                                ];
        
        NSArray *settings = @[
                              @"Category Colors",
                              @"Night Mode",
                              @"Larger Text Size",
                              ];
        

        NSArray *about = @[@"Tab Dump",
                           //@"Tab Dump for iOS",
                           ];
        
        self.dataSource = @[@"preview", settings, about];
        
        self.tableView.tableFooterView = [[UIView alloc] init];
        
        self.previewTab = [[DKTab alloc] init];
        self.previewTab.tabNumber = @"01";
        self.previewTab.categoryOnly = @"Google";
        self.previewTab.category = [NSString stringWithFormat:@"%@  %@:",self.previewTab.tabNumber, self.previewTab.categoryOnly];
        self.previewTab.tabText = @"Example story here... Ahh tote bag chillwave meh. Mixing small batches wolf Blue Bottle, pork belly disrupt lo-fi...";
        self.previewTab.strippedHTML = [NSString stringWithFormat:@"%@ %@",self.previewTab.category,self.previewTab.tabText ];
        self.previewTab.urlString = @"http://bbc.com/";        
    }
    return self;
}


#pragma mark - UIViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
    [self td_updateBackgroundColorForNightMode];
}


#pragma mark - UITableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0)
        return [self.previewTab heightForRow];
    
    return 44;
}


CGFloat sectionHeight = 60;

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return sectionHeight;
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, sectionHeight)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 28, 300, sectionHeight)];
    [view addSubview:label];
    
    NSString *text = self.sectionHeaders[section];
    text = text.uppercaseString;
    label.text = text.uppercaseString;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:kFontRegular size:12];
    [label dk_addBorderWithColor:[UIColor lightGrayColor] width:0.5];
    label.layer.cornerRadius = 6;
    
    CGRect frame = label.frame;
    frame.size = [text sizeWithAttributes: @{NSFontAttributeName:label.font} ];
    frame.size.width +=20;
    frame.size.height +=10;
    label.frame = frame;
    
    NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsSettingsNightMode];
    if ([number isEqual:@1]) {
        label.textColor = [UIColor whiteColor];
        view.backgroundColor = [UIColor blackColor];
    }
    else {
        label.textColor = [UIColor blackColor];
        view.backgroundColor = [UIColor whiteColor];
    }
    
    return view;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0)
        return 1;
    
    NSArray *datasource = self.dataSource[section];
    return datasource.count;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId=@"tabcell";
    if (indexPath.section == 0) {
        DKTabCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[DKTabCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.link = self.previewTab;
        
        return cell;
    }
    
    if (indexPath.section==1)
        cellId=@"switchcell";
    else
        cellId=@"regualarcell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.font = [UIFont fontWithName:kFontRegular size:12];
        
        UISwitch *optionSwitch = [[UISwitch alloc] init];
        optionSwitch.onTintColor = [UIColor td_highlightColor];
        [optionSwitch addTarget:self action:@selector(actionSwitch:) forControlEvents:UIControlEventValueChanged];
        optionSwitch.tag = indexPath.row;
        if (indexPath.section==1)
            cell.accessoryView = optionSwitch;
        
        NSString *key;
        switch (indexPath.row) {
            case 0:
                key = kUserDefaultsSettingsCategoryColors;
                break;
                
            case 1:
                key = kUserDefaultsSettingsNightMode;
                break;
                
                
            default:
                key = kUserDefaultsSettingsLargeTextSize;
                break;
        }

        NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        optionSwitch.on = [number isEqualToNumber:@1] ? YES:NO;

    }
    
    NSArray *datasource = self.dataSource[indexPath.section];
    NSString *text = datasource[indexPath.row];
    
    cell.textLabel.text = text;
    
    //color
    NSNumber *nightMode = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsSettingsNightMode];
    if ([nightMode isEqual:@1]) {
        cell.backgroundColor = [UIColor blackColor];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    else {
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==2) {
        [self.navigationController pushViewController:[[DKAboutController alloc]init] animated:YES];
    }
}


#pragma mark - Private

- (void)actionSwitch:(UISwitch*)switchControl {
    NSNumber *number = switchControl.isOn ? @1 : @0;
    
    NSString *key;
    switch (switchControl.tag) {
        case 0:
            key = kUserDefaultsSettingsCategoryColors;
            break;
            
        case 1:
            key = kUserDefaultsSettingsNightMode;
            break;
            
            
        default:
            key = kUserDefaultsSettingsLargeTextSize;
            break;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:number forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        //[self.tableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 3)] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    });
    
    if ([key isEqualToString:kUserDefaultsSettingsNightMode]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNightMode object:number];

        [self td_updateBackgroundColorForNightMode];
    }
}


@end
