//
//  GroupLocalDataUtility.m
//  MyApp
//
//  Created by Linwei Ding on 11/8/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
#import "Group+Util.h"
#import "ConfigurationManager.h"
#import "CurrentUser+Util.h"
#import "ConverterUtil.h"
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
    group.chatID = [[ConverterUtil sharedUtil] createChatIdByUserIds:dict[PF_GROUP_MEMBERS]];
    
}

- (void) createLocalGroup:(NSString *)name members:(NSArray *)members completionHandler:(REMOTE_OBJECT_BLOCK)block {
    Group * group  = [Group createEntity:self.managedObjectContext];
    group.userVolatile = [[ConfigurationManager sharedManager] getCurrentUser];
    group.name = name;
    group.members = members;
    if (block) {
        block(group, nil);
    }
   
    
    [super setCommonValues:group];
}

// delete the user in the group
- (void) removeLocalGroupMember:(Group *)group user:(User *)user completionHandler:(REMOTE_BOOL_BLOCK)block {
    //PFObject * groupPF = [PFObject objectWithoutDataWithClassName:PF_GROUP_CLASS_NAME objectId:group.globalID];
    //[groupPF getO]
    
    if ([group.members containsObject:user.globalID])
    {
        if ([group.members count] == 1) {
            // only the user is left, delete the remote object
            [self.managedObjectContext deleteObject:group];
            //[object deleteInBackgroundWithBlock:block];
        }
        else {
            // other users are left, just remove the member of the user
            NSMutableArray * members = [group.members mutableCopy];
            [members removeObject:user.globalID];
            group.members = members;
        }
    }
}


// delete the user in the group
- (void) removeLocalGroupMemberAll:(User *)createdUser user:(User *)user completionHandler:(REMOTE_BOOL_BLOCK)block {
    //PFObject * groupPF = [PFObject objectWithoutDataWithClassName:PF_GROUP_CLASS_NAME objectId:group.globalID];
    //[groupPF getO]
    
    NSFetchRequest * fetch = [NSFetchRequest fetchRequestWithEntityName:PF_GROUP_CLASS_NAME];
    fetch.predicate = [NSPredicate predicateWithFormat:@"%@ IN members", user.globalID];
    NSError * error;
    NSArray * match = [self.managedObjectContext executeFetchRequest:fetch error:&error];
    //[query setLimit:1000];
    
    if ([match count]) {
        if (!error) {
            for (Group * group in match) {

                if ([group.members containsObject:user.globalID]) {
                    if ([group.members count] == 1) {
                        // only the user is left, delete the remote object
                        [self.managedObjectContext deleteObject:group];
                        //[object deleteInBackgroundWithBlock:block];
                    }
                    else {
                        // other users are left, just remove the member of the user
                        NSMutableArray * members = [group.members mutableCopy];
                        [members removeObject:user.globalID];
                        group.members = members;
                        
                        block(!error, error);
                    }
                }
                
            }
        }
        else {
            [ProgressHUD showError:@"Network Error."];
        }

        
    }
}

// delete the group
- (void) removeLocalGroupItem:(Group *) group completionHandler:(REMOTE_BOOL_BLOCK)block {
    [self.managedObjectContext deleteObject:group];
}


@end
