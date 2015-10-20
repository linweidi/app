//
//  Event.h
//  MyApp
//
//  Created by Linwei Ding on 10/19/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "UserEntity.h"

@class Alert, EventCategory, Place, User;

@interface Event : UserEntity

@property (nonatomic, retain) id boardIDs;
@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) id groupIDs;
@property (nonatomic, retain) id invitees;
@property (nonatomic, retain) NSNumber * isAlert;
@property (nonatomic, retain) NSNumber * isVoting;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) id members;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * scope;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * votingID;
@property (nonatomic, retain) Alert *alert;
@property (nonatomic, retain) EventCategory *category;
@property (nonatomic, retain) Place *place;
@property (nonatomic, retain) User *user;

@end
