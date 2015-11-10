//
//  MessageLocalDataUtility.h
//  MyApp
//
//  Created by Linwei Ding on 11/8/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "BaseLocalDataUtil.h"

@interface MessageLocalDataUtil : BaseLocalDataUtil

+ (MessageLocalDataUtil *)sharedUtil;

- (void) setRandomValues: (id) object data:(NSDictionary *)dict;

- (NSArray *)constructDataFromDict:(NSDictionary *)dict;

- (void) createLocalMessage:(NSString *)chatId text:(NSString *)text Video:(Video *)video Picture:(Picture *)picture completionHandler:(REMOTE_OBJECT_BLOCK)block;
@end
