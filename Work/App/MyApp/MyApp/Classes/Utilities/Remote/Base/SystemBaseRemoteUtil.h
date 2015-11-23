//
//  BaseRemoteUtil.h
//  MyApp
//
//  Created by Linwei Ding on 10/21/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "AppHeader.h"
#import "BaseRemoteUtil.h"
#import <Foundation/Foundation.h>


@class SystemEntity;
#undef BASE_REMOTE_UTIL_OBJ_TYPE
#define BASE_REMOTE_UTIL_OBJ_TYPE SystemEntity*


@interface SystemBaseRemoteUtil : BaseRemoteUtil



@end
