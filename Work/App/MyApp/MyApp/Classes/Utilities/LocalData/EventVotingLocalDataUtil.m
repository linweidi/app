//
//  EventVotingLocalDataUtil.m
//  MyApp
//
//  Created by Linwei Ding on 11/20/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//
#import "EventVoting+Util.h"
#import "EventVotingLocalDataUtil.h"

#undef LOCAL_DATA_CLASS_TYPE
#define LOCAL_DATA_CLASS_TYPE EventVoting

@implementation EventVotingLocalDataUtil

+ (EventVotingLocalDataUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static EventVotingLocalDataUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_EVENT_VOTING_CLASS_NAME;
        
        sharedObject.index = LOCAL_DATA_EVENT_VOTING_INDEX;
    });
    return sharedObject;
}

#pragma mark - Inheritance methods

- (NSArray *)constructDataFromDict:(NSDictionary *)dict {
    
    NSMutableArray *resultArray = [NSMutableArray array];
    
    for (NSDictionary *obj in [dict allValues]) {
        
        LOCAL_DATA_CLASS_TYPE * object = [LOCAL_DATA_CLASS_TYPE createEntity:self.managedObjectContext];
        //Feedback *loadedData = [[Feedback alloc] init];
        
        [self setRandomValues:object data:obj];
        [resultArray addObject:object];
    }
    
    return [NSArray arrayWithArray:resultArray];
}

- (void) setRandomValues: (id) object data:(NSDictionary *)dict{
    [super setRandomValues:object data:dict];
    
    
    LOCAL_DATA_CLASS_TYPE * voting = (LOCAL_DATA_CLASS_TYPE *)object;
    
    voting.initiatorDecision = dict[PF_EVENT_VOTING_INITIATOR_DECISION];
    voting.instruction = dict[PF_EVENT_VOTING_INSTRUCTION];
    voting.isPriority = dict[PF_EVENT_VOTING_IS_PRIORITY];
    voting.timeSpan = dict[PF_EVENT_VOTING_TIME_SPAN];
    voting.votedMemberList = dict[PF_EVENT_VOTING_VOTED_MEMBER_LIST];
    voting.voteMaxNum = dict[PF_EVENT_VOTING_VOTE_MAX_NUM];
    voting.voterList = dict[PF_EVENT_VOTING_VOTER_LIST];
    
    
}


@end
