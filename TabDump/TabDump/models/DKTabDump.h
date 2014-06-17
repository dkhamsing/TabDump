//
//  DKTabDump.h
//  TabDump
//
//  Created by Daniel on 4/22/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKTabDump : NSObject <NSCoding>

/**
 Date of the tab dump.
 */
@property (nonatomic,strong) NSString *date;


/**
 Number of tabs in the tab dump.
 */
@property (nonatomic,strong) NSNumber *numberOfTabs;


/**
 List of bits & bytes (tech) tabs in the tab dump.
 */
@property (nonatomic,strong) NSArray *tabsTech;


/**
 List of real world tabs in the tab dump.
 */
@property (nonatomic,strong) NSArray *tabsWorld;


/**
 Reading time of the tab dump (based on the number of words).
 */
@property (nonatomic,strong) NSString *readingTime;


/**
 List of bits & bytes (tech) categories.
 */
@property (nonatomic,strong) NSArray *categoriesTech;


/**
 List of real world categories.
 */
@property (nonatomic,strong) NSArray *categoriesWorld;


#pragma mark Methods

/**
 Process RSS into tab dumps.
 @return List of tab dumps.
 */
+ (NSArray*)newListOfDumpsFromResponseData:(NSData*)data;


/**
 Get the title of the tab dump (date and number of tabs).
 */
- (NSString*)title;


@end
