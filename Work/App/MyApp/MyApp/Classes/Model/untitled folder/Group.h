//
//  Group.h
//  MyApp
//
//  Created by Linwei Ding on 10/19/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "UserEntity.h"

@class User;

@interface Group : UserEntity

@property (nonatomic, retain) id members;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) User *user;

@end
