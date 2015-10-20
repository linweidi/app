//
//  UserRemoteUtil.h
//  MyApp
//
//  Created by Linwei Ding on 9/30/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import "RemoteHeader.h"
#import "TypeHeader.h"
#import <Foundation/Foundation.h>


@interface UserRemoteUtil : NSObject

+ (UserRemoteUtil *)sharedUtil;

//- (void) logInUser:(id)target;




- (void) loadUserFromParse:(NSString *)userId completionHandler:(REMOTE_ARRAY_BLOCK)block;

- (void) loadRemoteUser:(NSString *)userId completionHandler:(REMOTE_ARRAY_BLOCK)block ;

- (void) signUp:(CurrentUser *)user completionHandler:(LOCAL_BOOL_BLOCK)block ;

- (void)logInWithUsername: (NSString *)username password:(NSString *)password completionHandler:(LOCAL_BOOL_BLOCK)block;

- (void) logOut ;

//- (RemoteUser *) convertToRemoteUser;

@end
