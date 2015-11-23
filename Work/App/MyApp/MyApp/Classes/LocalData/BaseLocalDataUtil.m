//
//  BaseLocalUtility.m
//  MyApp
//
//  Created by Linwei Ding on 11/7/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
#import "AppHeader.h"
#import "ConfigurationManager.h"
#import "ObjectEntity+Util.h"
#import "BaseLocalDataUtil.h"

#undef LOCAL_DATA_CLASS_TYPE
#define LOCAL_DATA_CLASS_TYPE ObjectEntity

@interface BaseLocalDataUtil()

@property (nonatomic) int count;
@end

@implementation BaseLocalDataUtil

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        _managedObjectContext = [[ConfigurationManager sharedManager] managedObjectContext];
    }
    return _managedObjectContext;
}

- (void) setRandomValues: (id) object data:(NSDictionary *)dict{
    LOCAL_DATA_CLASS_TYPE * event = (LOCAL_DATA_CLASS_TYPE *)object;
    
    if (!dict[PF_COMMON_OBJECTID]) {
        
        event.globalID = [self getUniqueGlobalID];
    }
    else {
        event.globalID = dict[PF_COMMON_OBJECTID];
    }
    
    if (!dict[PF_COMMON_CREATE_TIME] && !dict[PF_COMMON_UPDATE_TIME]) {
        NSDate * date1 = [self getRandomPastDate];
        NSDate * date2 = [self getRandomPastDate];
        if ([date1 compare:date2] == NSOrderedDescending) {
            event.updateTime = date1;
            event.createTime = date2;
        }
        else {
            event.updateTime = date2;
            event.createTime = date1;
        }
    }
    else if (!dict[PF_COMMON_CREATE_TIME]) {
        NSDate * date = [self getRandomPastDate];
        event.createTime = date;
        event.updateTime = dict[PF_COMMON_UPDATE_TIME];
    }
    else if (!dict[PF_COMMON_UPDATE_TIME]) {
        NSDate * date = [self getRandomPastDate];
        event.createTime = dict[PF_COMMON_CREATE_TIME];
        event.updateTime = date;
    }
    else {
        event.createTime = dict[PF_COMMON_CREATE_TIME];
        event.updateTime = dict[PF_COMMON_UPDATE_TIME];
    }
}

- (void) setCommonValues:(id) object {
    LOCAL_DATA_CLASS_TYPE * event = (LOCAL_DATA_CLASS_TYPE *)object;
    event.globalID = [self getUniqueGlobalID];
    event.createTime = [NSDate date];
    event.updateTime = [NSDate date];
    
}

- (void) setObjectEntity:(NSManagedObject *)object1 byObject:(NSManagedObject *)object2 {
    if (self.keys) {
        for (NSString * key in self.keys) {
            [object1 setValue:[object2 valueForKey:key] forKey:key];
        }
    }
}

#pragma mark -- Base Methods
#define LOCAL_DATA_CREATE_DAY_RANGE 60
- (NSDate *) getRandomPastDate {
    NSDate *randomDate = nil;
    if (self.dayRange) {
        randomDate = [NSDate dateWithTimeIntervalSinceNow:(rand() % (3600 * 24 * self.dayRange))*(-1)];
    }
    else {
        randomDate = [NSDate dateWithTimeIntervalSinceNow:(rand() % (3600 * 24 * LOCAL_DATA_CREATE_DAY_RANGE))*(-1)];
    }
    return randomDate;
}

#define LOCAL_DATA_GLOBALID_BASE_NUM 100

- (NSString *) getUniqueGlobalID {
    
    NSString * ret = [NSString stringWithFormat:@"%d", self.count+ LOCAL_DATA_GLOBALID_BASE_NUM*self.index];
    self.count++;
    return ret;
}

#pragma mark - Inheritance methods

- (NSArray *)loadData {
    NSString* path = [[NSBundle mainBundle] pathForResource:[self.className stringByAppendingString:@"Data"] ofType:@"plist"];
    NSDictionary *dataDictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    return [self constructDataFromDict:dataDictionary];
}

- (NSArray *)loadDataRandom: (NSInteger) count {
    NSString* path = [[NSBundle mainBundle] pathForResource:[self.className stringByAppendingString:@"Data"] ofType:@"plist"];
    NSDictionary *dataDictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    NSMutableArray * arrayOut = nil;
    
    if (count >= [dataDictionary count]) {
        //count = [dataDictionary count];
        arrayOut = [[dataDictionary allValues] mutableCopy];
    }
    else {
        arrayOut = [[NSMutableArray alloc] init];
        NSMutableArray * arrayData = [[dataDictionary allValues] mutableCopy]; //[dataDictionary mutableCopy];
        for (int i = 0; i< count; i++) {
            int index = rand() % ([arrayData count]);
            [arrayOut addObject:arrayData[index]];
            [arrayData removeObjectAtIndex:index];
        }
    }
    
    return arrayOut;
}

- (NSArray *)constructDataFromDict:(NSDictionary *)dict {
    NSAssert(NO, @"virtual function called");
    return nil;
}
@end
