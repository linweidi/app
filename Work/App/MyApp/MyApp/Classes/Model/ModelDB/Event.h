//
//  Event.h
//  MyApp
//
//  Created by Linwei Ding on 10/19/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "EntityObject.h"

@class Alert, Place, User;

@interface Event : EntityObject

@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) id invitees;
@property (nonatomic, retain) NSNumber * isAlert;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * scope;
@property (nonatomic, retain) id boardIDs;
@property (nonatomic, retain) NSString * votingID;
@property (nonatomic, retain) id members;
@property (nonatomic, retain) id groupIDs;
@property (nonatomic, retain) NSNumber * isVoting;
@property (nonatomic, retain) Alert *alert;
@property (nonatomic, retain) Place *place;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) NSManagedObject *category;

@end
