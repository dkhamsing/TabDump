//
//  DKTabDump.h
//  TabDump
//
//  Created by Daniel on 4/22/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKTabDump : NSObject

/**
 Date of the tab dump.
 */
@property (nonatomic,strong) NSString *date;


/**
 Number of tabs in the tab dump.
 */
@property (nonatomic,strong) NSNumber *numberOfTabs;


/**
 List of links in the tab dump.
 */
@property (nonatomic,strong) NSArray *links;


/**
 Reading time of the tab dump (based on the number of words).
 */
@property (nonatomic,strong) NSString *readingTime;


#pragma mark Methods

/**
 Process HTML into tab dumps.
 @return List of tab dumps.
 */
+ (NSArray*)newListOfDumpsFromHTML:(NSString*)html;


/**
 Get the title of the tab dump (date and number of tabs).
 */
- (NSString*)title;


@end
