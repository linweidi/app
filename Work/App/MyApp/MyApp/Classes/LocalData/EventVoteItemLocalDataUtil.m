//
//  EventVoteItemLocalDataUtil.m
//  MyApp
//
//  Created by Linwei Ding on 11/20/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import "EventVoteItem+Util.h"
#import "EventVoteItemLocalDataUtil.h"

#undef LOCAL_DATA_CLASS_TYPE
#define LOCAL_DATA_CLASS_TYPE EventVoteItem

@implementation EventVoteItemLocalDataUtil

+ (EventVoteItemLocalDataUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static EventVoteItemLocalDataUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_EVENT_VOTE_ITEM_CLASS_NAME;
        
        sharedObject.index = LOCAL_DATA_EVENT_VOTE_ITEM_INDEX;
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
    
    
    LOCAL_DATA_CLASS_TYPE * voteItem = (LOCAL_DATA_CLASS_TYPE *)object;
    
    voteItem.endTime = dict[PF_EVENT_VOTE_ITEM_END_TIME];
    voteItem.score = dict[PF_EVENT_VOTE_ITEM_SCORE];
    voteItem.startTime = dict[PF_EVENT_VOTE_ITEM_START_TIME];
    voteItem.voteCount = dict[PF_EVENT_VOTE_ITEM_VOTE_COUNT];
    voteItem.voters = dict[PF_EVENT_VOTE_ITEM_VOTERS];
    voteItem.votingID = dict[PF_EVENT_VOTE_ITEM_VOTING_ID];
    
    
}


@end
