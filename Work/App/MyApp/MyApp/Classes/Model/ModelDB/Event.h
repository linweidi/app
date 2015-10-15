//
//  Event.h
//  MyApp
//
//  Created by Linwei Ding on 10/15/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "EntityObject.h"

@class Alert, Place, User;

@interface Event : EntityObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSNumber * allDay;
@property (nonatomic, retain) NSDate * starts;
@property (nonatomic, retain) NSDate * ends;
@property (nonatomic, retain) NSNumber * isAlert;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) id invitees;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) Alert *alert;
@property (nonatomic, retain) Place *place;

@end
