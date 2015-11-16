//
//  EventVoteItem+CoreDataProperties.h
//  MyApp
//
//  Created by Linwei Ding on 11/14/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "EventVoteItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface EventVoteItem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *endTime;
@property (nullable, nonatomic, retain) NSNumber *score;
@property (nullable, nonatomic, retain) NSDate *startTime;
@property (nullable, nonatomic, retain) NSNumber *voteCount;
@property (nullable, nonatomic, retain) NSString *votingID;
@property (nullable, nonatomic, retain) User *voters;

@end

NS_ASSUME_NONNULL_END
