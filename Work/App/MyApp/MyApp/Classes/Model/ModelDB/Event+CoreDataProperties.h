//
//  Event+CoreDataProperties.h
//  MyApp
//
//  Created by Linwei Ding on 11/7/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Event.h"

NS_ASSUME_NONNULL_BEGIN

@interface Event (CoreDataProperties)

@property (nullable, nonatomic, retain) id boardIDs;
@property (nullable, nonatomic, retain) NSDate *endTime;
@property (nullable, nonatomic, retain) id groupIDs;
@property (nullable, nonatomic, retain) id invitees;
@property (nullable, nonatomic, retain) NSNumber *isAlert;
@property (nullable, nonatomic, retain) NSNumber *isVoting;
@property (nullable, nonatomic, retain) NSString *location;
@property (nullable, nonatomic, retain) id members;
@property (nullable, nonatomic, retain) NSString *notes;
@property (nullable, nonatomic, retain) NSString *scope;
@property (nullable, nonatomic, retain) NSDate *startTime;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *votingID;
@property (nullable, nonatomic, retain) Alert *alert;
@property (nullable, nonatomic, retain) EventCategory *category;
@property (nullable, nonatomic, retain) Place *place;
@property (nullable, nonatomic, retain) User *userVolatile;

@end

NS_ASSUME_NONNULL_END
