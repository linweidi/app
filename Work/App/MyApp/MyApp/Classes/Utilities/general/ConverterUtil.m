//
//  ConverterUtil.m
//  MyApp
//
//  Created by Linwei Ding on 11/20/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
#import "ConfigurationManager.h"
#import "User+Util.h"
#import "CurrentUser+Util.h"
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

- (NSDate *) timeOfDate: (NSDate *)date {
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents * compTime = [calendar components:NSCalendarUnitHour|NSCalendarUnitMinute fromDate:date];
    [compTime setCalendar:calendar];
    return [compTime date];
}

- (NSString *) createChatIdByUserIds:(NSArray *)userIDs {
    NSString *groupId = @"";
    

    //sort user id
    NSArray *sorted = [userIDs sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    // Create group id
    for (NSString *userId in sorted) {
        groupId = [groupId stringByAppendingString:userId];
    }
    
    return groupId;
    
}

- (NSString *) createChatIdByUsers:(NSArray *)users  {
    
    NSParameterAssert(users != nil);
    NSParameterAssert([users count]>0 && [[users firstObject] isKindOfClass:[User class]]);
    NSString *groupId = @"";
    
    // add current user
    NSMutableArray * users2 = [users mutableCopy];
    if (![users containsObject:[[ConfigurationManager sharedManager] getCurrentUser]]) {
        [users2 addObject:[[ConfigurationManager sharedManager] getCurrentUser]];
    }
    
    
    //user Ids
    NSMutableArray *userIds = [[NSMutableArray alloc] init];
    for (User *user in users2) {
        [userIds addObject: user.globalID];
    }
    //sort user id
    NSArray *sorted = [userIds sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    // Create group id
    for (NSString *userId in sorted) {
        groupId = [groupId stringByAppendingString:userId];
    }
    
    return groupId;
}

- (NSString *) createDescriptionByNames:(NSArray *)names {
    NSString *description = @"";
    
    //create description
    for (NSString *name in names) {
        if ([description length] != 0) description = [description stringByAppendingString:@" & "];
        description = [description stringByAppendingString:name];
    }
    
    return description;
}

- (NSString *) createDescriptionByUsers:(NSArray *)users {
    NSParameterAssert(users != nil);
    NSParameterAssert([users count]>0 && [[users firstObject] isKindOfClass:[User class]]);

    NSString *description = @"";
    
    // add current user
    NSMutableArray * users2 = [users mutableCopy];
    if (![users containsObject:[[ConfigurationManager sharedManager] getCurrentUser]]) {
        [users2 addObject:[[ConfigurationManager sharedManager] getCurrentUser]];
    }
    
    //create description
    for (User *user in users2) {
        if ([description length] != 0) description = [description stringByAppendingString:@" & "];
        description = [description stringByAppendingString:user.fullname];
    }
    
    return description;
}


@end
