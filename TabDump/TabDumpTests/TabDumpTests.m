//
//  TabDumpTests.m
//  TabDumpTests
//
//  Created by Daniel on 4/22/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DKTabDump.h"

@interface TabDumpTests : XCTestCase
@property (nonatomic,strong) NSArray *dumps;
@property (nonatomic,strong) DKTabDump *dump;
@end

@implementation TabDumpTests

- (void)setUp
{
    [super setUp];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"blog" ofType:@"rss"];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    self.dumps = [DKTabDump newListOfDumpsFromHTML:content];
    self.dump = self.dumps[0];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testTabDump
{
    XCTAssertTrue(self.dumps.count>0, @"");
    XCTAssertTrue(self.dump.numberOfTabs.integerValue>0, @"");
}

@end
