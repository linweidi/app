//
//  EventVoting.h
//  MyApp
//
//  Created by Linwei Ding on 10/19/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "EntityObject.h"

@class User;

@interface EventVoting : EntityObject

@property (nonatomic, retain) NSString * instruction;
@property (nonatomic, retain) NSNumber * isPriority;
@property (nonatomic, retain) UNKNOWN_TYPE selectNum;
@property (nonatomic, retain) NSNumber * timeSpan;
@property (nonatomic, retain) NSSet *voteItems;
@property (nonatomic, retain) NSSet *voterList;
@end

@interface EventVoting (CoreDataGeneratedAccessors)

- (void)addVoteItemsObject:(NSManagedObject *)value;
- (void)removeVoteItemsObject:(NSManagedObject *)value;
- (void)addVoteItems:(NSSet *)values;
- (void)removeVoteItems:(NSSet *)values;

- (void)addVoterListObject:(User *)value;
- (void)removeVoterListObject:(User *)value;
- (void)addVoterList:(NSSet *)values;
- (void)removeVoterList:(NSSet *)values;

@end
