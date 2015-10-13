//
//  UserRemoteUtil.h
//  MyApp
//
//  Created by Linwei Ding on 9/30/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import "RemoteHeader.h"
#import <Foundation/Foundation.h>


@interface UserRemoteUtil : NSObject

+ (UserRemoteUtil *)sharedUtil;

//- (void) logInUser:(id)target;

- (void) logOut ;


- (void) loadUserFromParse:(NSString *)userId completionHandler:(REMOTE_ARRAY_BLOCK)block;

- (void) loadRemoteUser:(NSString *)userId completionHandler:(REMOTE_ARRAY_BLOCK)block ;

@end
