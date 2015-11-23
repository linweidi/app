//
//  AlertLocalDataUtility.m
//  MyApp
//
//  Created by Linwei Ding on 11/8/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
#import "Alert+Util.h"
#import "AlertLocalDataUtil.h"

#undef LOCAL_DATA_CLASS_TYPE
#define LOCAL_DATA_CLASS_TYPE Alert

@implementation AlertLocalDataUtil

+ (AlertLocalDataUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static AlertLocalDataUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_ALERT_CLASS_NAME;
        
        sharedObject.index = LOCAL_DATA_ALERT_INDEX;
    });
    return sharedObject;
}

#pragma mark - Inheritance methods

- (NSArray *)constructDataFromDict:(NSDictionary *)dict {
    
    NSMutableArray *resultArray = [NSMutableArray array];
    
    for (NSDictionary *obj in [dict allValues]) {
        
        LOCAL_DATA_CLASS_TYPE * object = [LOCAL_DATA_CLASS_TYPE createEntity:self.managedObjectContext];
        //Feedback *loadedData = [[Feedback alloc] init];
        
        [self setRandomValues:object data:obj];
        [resultArray addObject:object];
    }
    
    return [NSArray arrayWithArray:resultArray];
}

- (void) setRandomValues: (id) object data:(NSDictionary *)dict{
    [super setRandomValues:object data:dict];
    
    LOCAL_DATA_CLASS_TYPE * alert = (LOCAL_DATA_CLASS_TYPE *)object;
    
    alert.time = dict[PF_ALERT_TIME];
    alert.type = dict[PF_ALERT_TYPE];
    
}

@end
