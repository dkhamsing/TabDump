//
//  DKTabActivityItemProvider.h
//  TabDump
//
//  Created by Daniel on 4/28/14.
//  Copyright (c) 2014 dkhamsing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKTabActivityItemProvider : UIActivityItemProvider
+ (NSString*)twitterShareStringFromText:(NSString*)text;
- (id)initWithText:(NSString*)text;
@end
