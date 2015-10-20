//
//  Group.h
//  MyApp
//
//  Created by Linwei Ding on 10/19/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "EntityObject.h"

@class User;

@interface Group : EntityObject

@property (nonatomic, retain) id members;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) User *user;

@end
