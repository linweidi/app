//
//  EventTemplate.h
//  MyApp
//
//  Created by Linwei Ding on 10/27/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "UserEntity.h"

@class EventCategory, Place;

@interface EventTemplate : UserEntity

@property (nonatomic, retain) id boardIDs;
@property (nonatomic, retain) id groupIDs;
@property (nonatomic, retain) id invitees;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * scope;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) EventCategory *category;
@property (nonatomic, retain) Place *place;

@end
