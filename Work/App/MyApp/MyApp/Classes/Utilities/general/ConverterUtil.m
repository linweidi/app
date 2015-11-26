//
//  ConverterUtil.m
//  MyApp
//
//  Created by Linwei Ding on 11/20/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "ConverterUtil.h"

@implementation ConverterUtil

+ (ConverterUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static ConverterUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        //sharedObject.className = PF_RECENT_CLASS_NAME;
    });
    return sharedObject;
}

- (NSString *)stringFromDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'zzz'"];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    return [formatter stringFromDate:date];
}

- (NSDate *) dateFromString:(NSString *)dateStr {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'zzz'"];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    return [formatter dateFromString:dateStr];
}

- (NSString *)stringFromDateShort:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //[formatter setDateFormat:@"yyyy'.'MM'.'dd' 'HH':'mm':'ss'.'zzz'"];
    

    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    return [formatter stringFromDate:date];
}

- (NSDate *) dateFromStringShort:(NSString *)dateStr {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //[formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'zzz'"];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    return [formatter dateFromString:dateStr];
}

- (NSDate *) dateFromStringTimeShort:(NSString *)dateStr  {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //[formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'zzz'"];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    return [formatter dateFromString:dateStr];
}

- (NSString *)stringFromDateTimeShort:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //[formatter setDateFormat:@"yyyy'.'MM'.'dd' 'HH':'mm':'ss'.'zzz'"];
    
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    return [formatter stringFromDate:date];
}

//- (NSString *) timeStringFromDate: (NSDate *)date {
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"HH':'mm"];
//    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
//    return [formatter stringFromDate:date];
//}
static NSString * zeroStart = @"☆☆☆☆☆";
static NSString * oneStart = @"★☆☆☆☆";
static NSString * twoStart = @"★★☆☆☆";
static NSString * threeStart = @"★★★☆☆";
static NSString * fourStart = @"★★★★☆";
static NSString * fiveStart = @"★★★★★";
- (NSString *) starString:(int) count {
    NSString * ret = nil;
    switch (count) {
        case 1:
            ret = oneStart;
            break;
        case 2:
            ret = twoStart;
            break;
        case 3:
            ret = threeStart;
            break;
        case 4:
            ret = fourStart;
            break;
        case 5:
            ret = fiveStart;
            break;
            
        default:
            ret = zeroStart;
            break;
    }
    
    return ret;
}
@end
