//
//  Event.h
//  MyApp
//
//  Created by Linwei Ding on 9/23/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "EntityObject.h"

@class User;

@interface Event : EntityObject

@property (nonatomic, retain) User *user;

@end
