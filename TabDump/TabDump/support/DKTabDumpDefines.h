//
//  DKTabDumpDefines.h
//  TabDump
//
//  Created by Daniel on 4/24/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//


#pragma mark - Cells

static CGFloat const kCellWidth = 320;
static CGFloat const kCellPadding = 13;
static CGFloat const kCellBottomOffset = 50;
static NSString* const kCellReadTimePrefix = @"Length: ";


#pragma mark - Detail (Day)

static NSString* const kDetailiTunesLink = @"itunes.apple.com";
static CGFloat const kDayHeaderHeight = 190;


#pragma mark - Font

static NSString* const kFontRegular = @"Sintony";
static NSString* const kFontBold = @"Sintony-Bold";
#define kCellFont [UIFont fontWithName:kFontRegular size:14]


#pragma mark - Launch

static NSString* const kLaunchTitle = @"T A B  D U M P";
static NSString* const kLaunchBlogRSSLink = @"http://tabdump.com/blog?format=rss";
static NSString* const kLaunchDownloadFilename = @"blog.rss";
static NSUInteger const kLaunchDownloadHourThreshold = 1;

#pragma mark - User Defaults

static NSString* const kUserDefaultsDateLastDownload = @"kUserDefaultsDateLastDownload";
static NSString* const kUserDefaultsTabDumpsRead = @"kUserDefaultsTabDumpsRead";
static NSString* const kUserDefaultsSettingsCategoryColors = @"kUserDefaultsSettingsCategoryColors";
//static NSString* const kUserDefaultsSettingsActionButtons = @"kUserDefaultsSettingsActionButtons";

#pragma mark - Views

static CGFloat const kAboutViewHeight = 200;
static NSString* const kAboutTwitterDaniel = @"dkhamsing";
static NSString* const kAboutTwitterStefan = @"WhatTheBit";
static NSString* const kAboutFullNameDaniel = @"Daniel Khamsing";
static NSString* const kAboutFullNameStefan = @"Stefan Constantinescu";
