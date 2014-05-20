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
#import "UIViewController+TD.h"

// Defines
#import "DKTabDumpDefines.h"


@interface DKSettingsController ()
@property (nonatomic,strong) NSArray *dataSource;
@end

@implementation DKSettingsController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Settings";
        [self td_addBackButtonPop];
        
        self.dataSource = @[
                            @"Category Colors",
                            @"Action Buttons",
                            ];
    }
    return self;
}


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
    
    return cell;
}


#pragma mark - Private

- (void)actionSwitch:(UISwitch*)switchControl {
    NSNumber *number = switchControl.isOn ? @1 : @0;

    NSString *key = switchControl.tag==0 ? kUserDefaultsSettingsCategoryColors : kUserDefaultsSettingsActionButtons;
    //NSLog(@"set number to %@ on key=%@",number,key);
    
    [[NSUserDefaults standardUserDefaults] setObject:number forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
