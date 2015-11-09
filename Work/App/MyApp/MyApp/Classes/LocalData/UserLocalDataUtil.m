//
//  UserLocalDataUtility.m
//  MyApp
//
//  Created by Linwei Ding on 11/8/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
#import "User+Util.h"
#import "Picture+Util.h"
#import "Video+Util.h"
#import "Thumbnail+Util.h"
#import "UserLocalDataUtil.h"

#undef LOCAL_DATA_CLASS_TYPE
#define LOCAL_DATA_CLASS_TYPE User

@implementation UserLocalDataUtil

+ (UserLocalDataUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static UserLocalDataUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_USER_CLASS_NAME;
        
        sharedObject.index = LOCAL_DATA_USER_INDEX;
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
    
    
    LOCAL_DATA_CLASS_TYPE * user = (LOCAL_DATA_CLASS_TYPE *)object;
    
    user.username = dict[PF_USER_USERNAME];
    user.password = dict[PF_USER_PASSWORD];
    
    user.email = dict[PF_USER_EMAIL];
    user.emailCopy = dict[PF_USER_EMAILCOPY];
    
    user.fullname = dict[PF_USER_FULLNAME];
    user.fullnameLower = dict[PF_USER_FULLNAME_LOWER];
    
    user.facebookID = dict[PF_USER_FACEBOOKID];
    user.twitterID = dict[PF_USER_TWITTERID];
    
    if (dict[PF_USER_PICTURE]) {
        user.picture = [Picture entityWithID:dict[PF_USER_PICTURE] inManagedObjectContext:self.managedObjectContext];
    }
    if (dict[PF_USER_THUMBNAIL]) {
        user.thumbnail = [Thumbnail entityWithID:dict[PF_USER_THUMBNAIL] inManagedObjectContext:self.managedObjectContext];
    }
}

@end
