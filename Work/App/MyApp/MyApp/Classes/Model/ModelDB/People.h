//
//  People.h
//  MyApp
//
//  Created by Linwei Ding on 11/20/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "UserEntity.h"

@class User;

@interface People : UserEntity

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) User *contact;
@property (nonatomic, retain) User *userVolatile;

@end
