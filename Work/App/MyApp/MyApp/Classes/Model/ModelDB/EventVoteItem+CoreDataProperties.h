//
//  EventVoteItem+CoreDataProperties.h
//  MyApp
//
//  Created by Linwei Ding on 11/7/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "EventVoteItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface EventVoteItem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *score;
@property (nullable, nonatomic, retain) NSNumber *voteNum;
@property (nullable, nonatomic, retain) NSString *voterName;
@property (nullable, nonatomic, retain) NSString *votingID;

@end

NS_ASSUME_NONNULL_END
