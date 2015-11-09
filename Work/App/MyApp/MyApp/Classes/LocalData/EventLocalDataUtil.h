//
//  EventLocalUtility.h
//  MyApp
//
//  Created by Linwei Ding on 11/7/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "BaseLocalDataUtility.h"

@interface EventLocalDataUtil : BaseLocalDataUtility

+ (EventLocalDataUtil *)sharedUtil;

- (void) setRandomValues: (id) object data:(NSDictionary *)dict;

- (NSArray *)constructDataFromDict:(NSDictionary *)dict;

@end
