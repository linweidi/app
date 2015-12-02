//
//  ConfigurationManager.h
//  TestTemplate
//
//  Created by AppsFoundation on 1/19/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreData/CoreData.h"

@class CurrentUser;
@interface ConfigurationManager : NSObject

@property (nonatomic,readonly,copy) NSString *appId;
@property (nonatomic,readonly,copy) NSString *contactMail;
@property (nonatomic,readonly,copy) NSNumber *rateAppDelay;
@property (nonatomic,readonly,copy) NSString *flurrySessionID;

+ (ConfigurationManager *)sharedManager;


@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;

@property (nonatomic) BOOL isLoggedIn;

@property (strong, nonatomic) NSString * currentUserID;

- (CurrentUser *)getCurrentUser;

- (void)setCurrentUser: (CurrentUser *) user;

- (void)clearCurrentUserContext;



@end
