//
//  NSString+ConvertToNumber.m
//  MyApp
//
//  Created by Linwei Ding on 11/16/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "NSString+ConvertToNumber.h"

@implementation NSString (ConvertToNumber)

- (NSNumber *) toNumber {
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    format.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *myNumber = [format numberFromString:self];
    return myNumber;
}
@end
