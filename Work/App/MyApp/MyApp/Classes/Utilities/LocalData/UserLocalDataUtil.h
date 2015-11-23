//
//  UserLocalDataUtility.h
//  MyApp
//
//  Created by Linwei Ding on 11/8/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "BaseLocalDataUtil.h"

@interface UserLocalDataUtil : BaseLocalDataUtil

+ (UserLocalDataUtil *)sharedUtil;

- (void) setRandomValues: (id) object data:(NSDictionary *)dict;

- (NSArray *)constructDataFromDict:(NSDictionary *)dict;

- (void) signUp:(CurrentUser *)user completionHandler:(LOCAL_BOOL_BLOCK)block ;

- (void)logInWithUsername: (NSString *)username password:(NSString *)password completionHandler:(LOCAL_BOOL_BLOCK)block;

- (void) logOut ;



@end
