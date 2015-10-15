//
//  People.h
//  MyApp
//
//  Created by Linwei Ding on 10/15/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "EntityObject.h"

@class User;

@interface People : EntityObject

@property (nonatomic, retain) NSDate * createTime;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * updateTime;
@property (nonatomic, retain) NSString * userID;
@property (nonatomic, retain) User *contact;
@property (nonatomic, retain) User *user;

@end
