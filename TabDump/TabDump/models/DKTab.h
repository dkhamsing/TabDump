//
//  DKTab.h
//  TabDump
//
//  Created by Daniel on 4/22/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ONOXMLElement;
@interface DKTab : NSObject <NSCoding>

/**
 Date of the tab (for category cell / view).
 */
@property (nonatomic,strong) NSString *tabDay;


/**
 Number of the tab.
 */
@property (nonatomic,strong) NSString *tabNumber;


/**
 Category of the tab including colon.
 */
@property (nonatomic,strong) NSString *category;


/**
 Category of the tab.
 */
@property (nonatomic,strong) NSString *categoryOnly;


/**
 Tab text, stripped from HTML.
 */
@property (nonatomic,strong) NSString *strippedHTML;


/**
 Tab text, stripped from HTML, tab number and category; trimmed from white space.
 */
@property (nonatomic,strong) NSString *tabText;


/**
 Tab URL.
 */
@property (nonatomic,strong) NSString *urlString;


#pragma mark Methods

/**
 Create a tab from an XML element.
 */
+ (DKTab*)newTabFromXMLElement:(ONOXMLElement*)element;


/**
 Return a Boolean specifying whether the brand color is dark.
 */
- (BOOL)brandColorIsDark;


/**
 Get the color from the category name.
 */
- (UIColor*)colorForCategory;


/**
 Get content text attributes.
 */
- (NSDictionary*)contentAttributes;


/**
 Get the size for the tab text.
 */
- (CGSize)sizeForTabText;


/**
 Height for row (based on stripped html size, top and bottom padding..)
 */
- (CGFloat)heightForRow;


@end
