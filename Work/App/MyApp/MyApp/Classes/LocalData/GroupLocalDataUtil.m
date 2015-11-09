//
//  GroupLocalDataUtility.m
//  MyApp
//
//  Created by Linwei Ding on 11/8/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
#import "Group+Util.h"
#import "GroupLocalDataUtil.h"

#undef LOCAL_DATA_CLASS_TYPE
#define LOCAL_DATA_CLASS_TYPE Group

@implementation GroupLocalDataUtil

+ (GroupLocalDataUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static GroupLocalDataUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_GROUP_CLASS_NAME;
        
        sharedObject.index = LOCAL_DATA_GROUP_INDEX;
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
    
    
    LOCAL_DATA_CLASS_TYPE * group = (LOCAL_DATA_CLASS_TYPE *)object;
    
    group.name = dict[PF_GROUP_NAME] ;
    group.members = dict[PF_GROUP_MEMBERS];
    
}

@end
