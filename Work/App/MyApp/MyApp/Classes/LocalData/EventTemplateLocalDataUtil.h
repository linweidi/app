//
//  EventTemplateLocalDataUtil.h
//  MyApp
//
//  Created by Linwei Ding on 11/20/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import "BaseLocalDataUtil.h"

@interface EventTemplateLocalDataUtil : BaseLocalDataUtil
+ (EventTemplateLocalDataUtil *)sharedUtil;

- (void) setRandomValues: (id) object data:(NSDictionary *)dict;

- (NSArray *)constructDataFromDict:(NSDictionary *)dict;


@end
