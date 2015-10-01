//
//  UserRemoteUtil.h
//  MyApp
//
//  Created by Linwei Ding on 9/30/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserRemoteUtil : NSObject

+ (UserRemoteUtil *)sharedUtil;

- (void) loadUserFromParse:(NSString *)userId completionHandler:(PARSE_ARRAY_BLOCK)block ;

@end
