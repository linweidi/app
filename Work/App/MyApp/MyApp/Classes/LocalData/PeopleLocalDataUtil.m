//
//  PeopleLocalDataUtility.m
//  MyApp
//
//  Created by Linwei Ding on 11/8/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
#import "People+Util.h"
#import "UserRemoteUtil.h"
#import "PeopleLocalDataUtil.h"

#undef LOCAL_DATA_CLASS_TYPE
#define LOCAL_DATA_CLASS_TYPE People

@implementation PeopleLocalDataUtil

+ (PeopleLocalDataUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static PeopleLocalDataUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_PEOPLE_CLASS_NAME;
        
        sharedObject.index = LOCAL_DATA_PEOPLE_INDEX;
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
    
    
    LOCAL_DATA_CLASS_TYPE * people = (LOCAL_DATA_CLASS_TYPE *)object;
    
    people.contact  = [[UserRemoteUtil sharedUtil] convertToUser:dict[PF_PEOPLE_USER2]];
    people.name = dict[PF_PEOPLE_NAME];
    
}

@end
