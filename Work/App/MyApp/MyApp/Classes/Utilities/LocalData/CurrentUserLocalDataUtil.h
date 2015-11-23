//
//  CurrentUserLocalDataUtil.h
//  MyApp
//
//  Created by Linwei Ding on 11/15/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "UserLocalDataUtil.h"

@interface CurrentUserLocalDataUtil : UserLocalDataUtil

+ (CurrentUserLocalDataUtil *)sharedUtil;

- (void) setRandomValues: (id) object data:(NSDictionary *)dict;

- (NSArray *)constructDataFromDict:(NSDictionary *)dict;

@end
