//
//  EventVoting.h
//  MyApp
//
//  Created by Linwei Ding on 10/27/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "UserEntity.h"

@class EventVoteItem, User;

@interface EventVoting : UserEntity

@property (nonatomic, retain) NSString * instruction;
@property (nonatomic, retain) NSNumber * isPriority;
@property (nonatomic, retain) NSNumber * selectNum;
@property (nonatomic, retain) NSNumber * timeSpan;
@property (nonatomic, retain) NSSet *voteItems;
@property (nonatomic, retain) NSSet *voterList;
@end

@interface EventVoting (CoreDataGeneratedAccessors)

- (void)addVoteItemsObject:(EventVoteItem *)value;
- (void)removeVoteItemsObject:(EventVoteItem *)value;
- (void)addVoteItems:(NSSet *)values;
- (void)removeVoteItems:(NSSet *)values;

- (void)addVoterListObject:(User *)value;
- (void)removeVoterListObject:(User *)value;
- (void)addVoterList:(NSSet *)values;
- (void)removeVoterList:(NSSet *)values;

@end
