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
#import "CurrentUser+Util.h"
#import "Thumbnail+Util.h"
#import "UserLocalDataUtil.h"

#undef LOCAL_DATA_CLASS_TYPE
#define LOCAL_DATA_CLASS_TYPE User

@interface UserLocalDataUtil()
@property (strong, nonatomic) NSArray * keyNames;
@end

@implementation UserLocalDataUtil


+ (UserLocalDataUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static UserLocalDataUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_USER_CLASS_NAME;
        
        sharedObject.index = LOCAL_DATA_USER_INDEX;
        
        sharedObject.keyNames = @[@"email", @"emailCopy", @"facebookID", @"fullname", @"fullnameLower", @"password", @"twitterID", @"username", @"picture", @"thumbnail"];
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

- (void) signUp:(CurrentUser *)user completionHandler:(REMOTE_BOOL_BLOCK)block {
    ConfigurationManager * config = [ConfigurationManager sharedManager];
    NSFetchRequest * fetch = [NSFetchRequest fetchRequestWithEntityName:PF_USER_CLASS_NAME];
    fetch.predicate = [NSPredicate predicateWithFormat:@"username = %@", user.username];
    NSError * error;
    NSArray * match = [self.managedObjectContext executeFetchRequest:fetch error:&error];
    // here, it will check if the username and email has already existed
    if (!error) {
        // update the isLogggedIn
        
        if ([match count]== 0) {
            // remote create the local current user
            CurrentUser * currentUser = [CurrentUser createEntity:self.managedObjectContext];
            
            [[UserLocalDataUtil sharedUtil] setObjectEntity:currentUser byObject:user];
            [super setCommonValues:currentUser];
            
            if (currentUser) {
                // populate the current user to configuration manager
                config.currentUserID = currentUser.globalID;
                [config setCurrentUser:currentUser];
                
                //ParsePushUserAssign();
                [ProgressHUD showSuccess:[NSString stringWithFormat:@"Welcome back %@!", user.fullname]];
                
                block(YES, error);
                
                config.isLoggedIn = YES;
            }
        }

    }
    else {
        [ProgressHUD showError:@"sign up failes"];

    }
}

- (void)logInWithUsername: (NSString *)username password:(NSString *)password completionHandler:(REMOTE_BOOL_BLOCK)block {
    
    ConfigurationManager * config = [ConfigurationManager sharedManager];

    CurrentUser * currentUser = nil;
    
    // remote create the local current user
    currentUser  = [CurrentUser entityWithUsername:username inManagedObjectContext:config.managedObjectContext];
    if (!currentUser) {
        [ProgressHUD showError:@"no this user or password incorrect"];
    }
    else {
        // populate the current user to configuration manager
        config.currentUserID = currentUser.globalID;
        [config setCurrentUser:currentUser];
        
        //ParsePushUserAssign();
        [ProgressHUD showSuccess:[NSString stringWithFormat:@"Welcome back %@!", currentUser.fullname]];
        
        block(YES, nil);
        
        // update the isLogggedIn
        config.isLoggedIn = YES;
    }

}

- (void) logOut {
    ConfigurationManager * config = [ConfigurationManager sharedManager];
    [config clearCurrentUserContext];
    //[PFUser logOut];
}

@end
