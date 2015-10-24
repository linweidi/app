//
//  User.h
//  MyApp
//
//  Created by Linwei Ding on 10/19/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "UserEntity.h"

@class Alert, Event, Group, People, Place, Recent, Thumbnail;

@interface User : UserEntity

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * emailCopy;
@property (nonatomic, retain) NSString * facebookID;
@property (nonatomic, retain) NSString * fullname;
@property (nonatomic, retain) NSString * fullnameLower;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * pictureID;
@property (nonatomic, retain) NSString * pictureName;
@property (nonatomic, retain) NSString * pictureURL;
@property (nonatomic, retain) NSString * twitterID;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSSet *alerts;
@property (nonatomic, retain) NSSet *events;
@property (nonatomic, retain) NSSet *groups;
@property (nonatomic, retain) NSSet *peoples;
@property (nonatomic, retain) NSSet *places;
@property (nonatomic, retain) NSSet *recents;
@property (nonatomic, retain) Thumbnail *thumbnail;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addAlertsObject:(Alert *)value;
- (void)removeAlertsObject:(Alert *)value;
- (void)addAlerts:(NSSet *)values;
- (void)removeAlerts:(NSSet *)values;

- (void)addEventsObject:(Event *)value;
- (void)removeEventsObject:(Event *)value;
- (void)addEvents:(NSSet *)values;
- (void)removeEvents:(NSSet *)values;

- (void)addGroupsObject:(Group *)value;
- (void)removeGroupsObject:(Group *)value;
- (void)addGroups:(NSSet *)values;
- (void)removeGroups:(NSSet *)values;

- (void)addPeoplesObject:(People *)value;
- (void)removePeoplesObject:(People *)value;
- (void)addPeoples:(NSSet *)values;
- (void)removePeoples:(NSSet *)values;

- (void)addPlacesObject:(Place *)value;
- (void)removePlacesObject:(Place *)value;
- (void)addPlaces:(NSSet *)values;
- (void)removePlaces:(NSSet *)values;

- (void)addRecentsObject:(Recent *)value;
- (void)removeRecentsObject:(Recent *)value;
- (void)addRecents:(NSSet *)values;
- (void)removeRecents:(NSSet *)values;

@end
