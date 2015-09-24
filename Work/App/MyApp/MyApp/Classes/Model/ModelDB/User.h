//
//  User.h
//  MyApp
//
//  Created by Linwei Ding on 9/23/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "EntityObject.h"

@class Alert, Event, Friend, Group, Place, Recent;

@interface User : EntityObject

@property (nonatomic, retain) NSString * fullname;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * picture;
@property (nonatomic, retain) NSString * thumbnail;
@property (nonatomic, retain) NSString * fullnameLower;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * emailCopy;
@property (nonatomic, retain) NSString * facebookID;
@property (nonatomic, retain) NSString * twitterID;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSSet *recents;
@property (nonatomic, retain) NSSet *places;
@property (nonatomic, retain) NSSet *groups;
@property (nonatomic, retain) NSSet *alerts;
@property (nonatomic, retain) NSSet *friends;
@property (nonatomic, retain) NSSet *events;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addRecentsObject:(Recent *)value;
- (void)removeRecentsObject:(Recent *)value;
- (void)addRecents:(NSSet *)values;
- (void)removeRecents:(NSSet *)values;

- (void)addPlacesObject:(Place *)value;
- (void)removePlacesObject:(Place *)value;
- (void)addPlaces:(NSSet *)values;
- (void)removePlaces:(NSSet *)values;

- (void)addGroupsObject:(Group *)value;
- (void)removeGroupsObject:(Group *)value;
- (void)addGroups:(NSSet *)values;
- (void)removeGroups:(NSSet *)values;

- (void)addAlertsObject:(Alert *)value;
- (void)removeAlertsObject:(Alert *)value;
- (void)addAlerts:(NSSet *)values;
- (void)removeAlerts:(NSSet *)values;

- (void)addFriendsObject:(Friend *)value;
- (void)removeFriendsObject:(Friend *)value;
- (void)addFriends:(NSSet *)values;
- (void)removeFriends:(NSSet *)values;

- (void)addEventsObject:(Event *)value;
- (void)removeEventsObject:(Event *)value;
- (void)addEvents:(NSSet *)values;
- (void)removeEvents:(NSSet *)values;

@end
