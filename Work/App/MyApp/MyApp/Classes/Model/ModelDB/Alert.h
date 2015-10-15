//
//  Alert.h
//  MyApp
//
//  Created by Linwei Ding on 10/15/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "EntityObject.h"

@class Event, User;

@interface Alert : EntityObject

@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) Event *event;

@end
