//
//  Friend.h
//  MyApp
//
//  Created by Linwei Ding on 9/24/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "EntityObject.h"

@class User;

@interface Friend : EntityObject

@property (nonatomic, retain) NSString * friend;
@property (nonatomic, retain) User *user;

@end
