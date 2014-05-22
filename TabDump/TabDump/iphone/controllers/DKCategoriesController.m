//
//  DKCategoriesController.m
//  TabDump
//
//  Created by Daniel on 5/17/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import "DKCategoriesController.h"

// Controllers
#import "DKTabsListController.h"

// Categories
#import "UIColor+BrandColors.h"
#import "UIViewController+TD.h"

// Models
#import "DKTab.h"
#import "DKTabDump.h"

// Views
#import "DKCategoryCell.h"


@interface DKCategoriesController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property (nonatomic,strong) NSArray *dataSource;
@property (nonatomic,strong) UICollectionView *categoriesCollectionView;
@end

@implementation DKCategoriesController

NSString *cellId = @"cellId";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {        
        [self td_addCloseButtomDismiss];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        self.categoriesCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        self.categoriesCollectionView.backgroundColor = [UIColor whiteColor];
        self.categoriesCollectionView.delegate = self;
        self.categoriesCollectionView.dataSource = self;
        [self.categoriesCollectionView registerClass:[DKCategoryCell class] forCellWithReuseIdentifier:cellId];
        
        [self.view addSubview:self.categoriesCollectionView];
    }
    return self;
}


- (void)setCategoriesTabDumps:(NSArray *)tabDumps {
    _categoriesTabDumps = tabDumps;
    
    // create data source: list of categories
    NSMutableArray *categoriesTech = [[NSMutableArray alloc] init];
    NSMutableArray *categoriesWorld = [[NSMutableArray alloc] init];
    
    for (DKTabDump *dump in tabDumps) {
        for (NSString* category in dump.categoriesTech) {
            if ([[UIColor bc_brands] containsObject:category]) {
                if (![categoriesTech containsObject:category]) {
                    [categoriesTech addObject:category];
                }
            }
        }
        
        for (NSString* category in dump.categoriesWorld) {
            if (![categoriesWorld containsObject:category]) {
                [categoriesWorld addObject:category];
            }
        }
        
    }
    
    NSArray *sortedTech = [categoriesTech sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    //NSArray *sortedWord = [categoriesWorld sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    //NSLog(@"categories=%@", sortedWord);
    
    //    NSLog(@"categories=%@", sortedTech);
    
    
    self.dataSource = sortedTech;
    [self.categoriesCollectionView reloadData];
}


#pragma mark - UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DKCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    NSString *text = self.dataSource[indexPath.row];
    cell.numberOfStories = [self tabsForCategory:text].count;
    cell.title = text;
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(320/2, 80);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *category = self.dataSource[indexPath.row];
    
    DKTabsListController *listController = [[DKTabsListController alloc]init];
    listController.title = [category uppercaseString];
    listController.dataSource = [self tabsForCategory:category];
    [self.navigationController pushViewController:listController animated:YES];    
}


#pragma mark - Private

- (NSArray*)tabsForCategory:(NSString*)category {    
    NSMutableArray *tabs = [[NSMutableArray alloc] init];
    for (DKTabDump *dump in self.categoriesTabDumps ) {
        for (DKTab *tab in dump.tabsTech) {
            if ([tab.categoryOnly isEqualToString:category]) {
                [tabs addObject:tab];
            }
        }
    }

    return [tabs copy];
}


@end
