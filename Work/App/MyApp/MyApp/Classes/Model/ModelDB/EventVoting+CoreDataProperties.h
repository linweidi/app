//
//  EventVoting+CoreDataProperties.h
//  MyApp
//
//  Created by Linwei Ding on 11/16/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "EventVoting.h"

NS_ASSUME_NONNULL_BEGIN

@interface EventVoting (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *initiatorDecision;
@property (nullable, nonatomic, retain) NSString *instruction;
@property (nullable, nonatomic, retain) NSNumber *isPriority;
@property (nullable, nonatomic, retain) NSNumber *timeSpan;
@property (nullable, nonatomic, retain) NSNumber *voteMaxNum;
@property (nullable, nonatomic, retain) User *votedMemberList;
@property (nullable, nonatomic, retain) NSSet<EventVoteItem *> *voteItems;
@property (nullable, nonatomic, retain) NSSet<User *> *voterList;

@end

@interface EventVoting (CoreDataGeneratedAccessors)

- (void)addVoteItemsObject:(EventVoteItem *)value;
- (void)removeVoteItemsObject:(EventVoteItem *)value;
- (void)addVoteItems:(NSSet<EventVoteItem *> *)values;
- (void)removeVoteItems:(NSSet<EventVoteItem *> *)values;

- (void)addVoterListObject:(User *)value;
- (void)removeVoterListObject:(User *)value;
- (void)addVoterList:(NSSet<User *> *)values;
- (void)removeVoterList:(NSSet<User *> *)values;

@end

NS_ASSUME_NONNULL_END
