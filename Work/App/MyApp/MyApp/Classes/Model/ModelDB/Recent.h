//
//  Recent.h
//  MyApp
//
//  Created by Linwei Ding on 11/20/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "UserEntity.h"

@class User;

@interface Recent : UserEntity

@property (nonatomic, retain) NSString * chatID;
@property (nonatomic, retain) NSNumber * counter;
@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) NSString * fullname;
@property (nonatomic, retain) NSString * lastMessage;
@property (nonatomic, retain) id members;
@property (nonatomic, retain) User *lastUser;
@property (nonatomic, retain) User *userVolatile;

@end
