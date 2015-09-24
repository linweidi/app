//
//  Recent.h
//  MyApp
//
//  Created by Linwei Ding on 9/23/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "EntityObject.h"

@class User;

@interface Recent : EntityObject

@property (nonatomic, retain) NSString * chatID;
@property (nonatomic, retain) NSNumber * counter;
@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) NSString * fullname;
@property (nonatomic, retain) NSString * lastMessage;
@property (nonatomic, retain) NSString * member;
@property (nonatomic, retain) NSDate * updateDate;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) User *lastUser;

@end
