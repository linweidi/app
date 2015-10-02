//
//  UserManager.m
//  MyApp
//
//  Created by Linwei Ding on 9/30/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//
#import "Thumbnail+Util.h"
#import "User+Util.h"
#import "UserManager.h"

@implementation UserContext

+ (UserContext *)userContext:(User *)user thumbName:(NSString *)thumbName thumb:(Thumbnail *)thumb {
    UserContext * context = [[UserContext alloc] init    ];
    
    context.user = user;
    context.thumbName = thumbName;
    context.thumb = thumb;
    
    return context;
}

@end

@interface UserManager()
@property (strong, nonatomic) NSMutableDictionary * allUsers;

//@property (strong, nonatomic) NSMutableDictionary * usersByGroup;

@end

@implementation UserManager

+ (UserManager *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static UserManager *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.allUsers = [[NSMutableDictionary alloc] init];
        
    });
    return sharedObject;
}

- (BOOL) addUser:(User *)user  {
    BOOL ret = NO;
    NSString * userID = user.globalID  ;
    if ([self exists:userID]) {
        self.allUsers[userID] = [UserContext userContext:user thumbName:user.thumbnail.name thumb:user.thumbnail];
        ret = YES;
    }
    
    return ret;
}

- (BOOL) removeUser: (NSString *) userID {
    BOOL ret = NO;
    if ([self exists:userID]) {
        [self.allUsers removeObjectForKey:userID];
        ret = YES;
    }
    
    return ret;
    
}

- (BOOL) exists: (NSString *) userID {
    return [self.allUsers objectForKey:userID]!=nil;
}

- (User *) getUser: (NSString *) userID {
    UserContext *context = [self getContext:userID];
    
    return context.user;
}

- (UserContext *) getContext: (NSString *) userID {
    return [self.allUsers objectForKey:userID];
}

- (Thumbnail *) getThumbnail: (NSString *) userID {
    UserContext *context = [self getContext:userID];
    
    return context.thumb;
}

- (User *) extractUser:(NSString *)userID {
    User * user = nil;
    if ([self exists:userID]) {
        user = [self getUser:userID];
        [self removeUser:userID];
    }
    
    return user;
}

- (void) loadUsers: (NSArray *) users {
    for (User * user in users) {
        [self addUser:user];
    }
}
@end
