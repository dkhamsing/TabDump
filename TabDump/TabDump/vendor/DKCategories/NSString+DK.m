//
//  NSString+DK.m
//
//  Created by dkhamsing on 1/25/14.
//
//

#import "NSString+DK.h"

@implementation NSString (SS)

- (BOOL)dk_containsString:(NSString *)string {
    return !NSEqualRanges([self rangeOfString:string], NSMakeRange(NSNotFound, 0));
}


- (NSString *)dk_pluralize:(NSInteger)number {
    if (number==1)
        return self;
    
    if (number<0)
        return @"error";
    
    return [self stringByAppendingString:@"s"];
}


+ (NSString *)dk_pluralizePerson:(NSInteger)numberOfPeople {
    if (numberOfPeople==1)
        return @"1 person";
    
    if (numberOfPeople==0)
        return @"no one";
    
    if (numberOfPeople<0)
        return @"error";
    
    return [NSString stringWithFormat:@"%ld people", (long)numberOfPeople ];
}


- (NSString*)dk_truncateToWidth:(CGFloat)width withFont:(UIFont*)font {
    NSInteger min = 0, max = self.length, mid;
    while (min < max) {
        mid = (min+max)/2;
        NSString *currentString = [self substringWithRange:NSMakeRange(0, mid)];
        CGSize currentSize =
        [currentString sizeWithAttributes:@{NSFontAttributeName:font}];
        //[currentString sizeWithFont:font];
        
        if (currentSize.width < width){
            min = mid + 1;
        }
        else if (currentSize.width > width) {
            max = mid - 1;
        }
        else {
            min = mid;
            break;
        }
    }
    
    NSString *retVal = [self substringWithRange:NSMakeRange(0, min)];
    if (min<self.length) {
        retVal = [retVal stringByAppendingString:@"…"];
    }
    return  retVal;
}


@end
