//
//  NSString+DK.h
//
//  Created by dkhamsing on 1/25/14.
//
//

#import <Foundation/Foundation.h>

@interface NSString (SS)

/**
 Returns a Boolean if the receiver contains the given `string`.
 Credit: https://github.com/soffes
 @param string A string to test the the receiver for
 @return A Boolean if the receiver contains the given `string`
 */
- (BOOL)dk_containsString:(NSString *)string;


/**
 Add "s" to the receiver for the given `number`.
 @param number Number to pluralize string with
 @return The string with or without "s" added
 */
- (NSString *)dk_pluralize:(NSInteger)number;


/**
 Returns the person pluralization for the given `numberOfPeople`.
 @param numberOfPeople Number of people to pluralize
 @return A string with the correct person pluralization
 */
+ (NSString *)dk_pluralizePerson:(NSInteger)numberOfPeople;


/**
 Truncates receiver to given width.
 Credit: http://stackoverflow.com/questions/10693383/truncate-an-nsstring-to-width
 @param width Width to truncate string to
 @param font Font to use in computing width
 */
- (NSString*)dk_truncateToWidth:(CGFloat)width withFont:(UIFont*)font;


@end
