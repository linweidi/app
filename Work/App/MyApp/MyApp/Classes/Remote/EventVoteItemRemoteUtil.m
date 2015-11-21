//
//  EventVoteItemRemoteUtil.m
//  MyApp
//
//  Created by Linwei Ding on 11/20/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import "EventVoteItem+Util.h"
#import "EventVoteItemRemoteUtil.h"

@implementation EventVoteItemRemoteUtil

+ (EventVoteItemRemoteUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static EventVoteItemRemoteUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_EVENT_VOTE_ITEM_CLASS_NAME;
    });
    return sharedObject;
}

- (void)setCommonObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context {
    NSAssert([object isKindOfClass:[EventVoteItem class]], @"Type casting is wrong");
    EventVoteItem * voteItem = (EventVoteItem *)object;
    
    voteItem.endTime = remoteObj[PF_EVENT_VOTE_ITEM_END_TIME];
    voteItem.score = remoteObj[PF_EVENT_VOTE_ITEM_SCORE];
    voteItem.startTime = remoteObj[PF_EVENT_VOTE_ITEM_START_TIME];
    voteItem.voteCount = remoteObj[PF_EVENT_VOTE_ITEM_VOTE_COUNT];
    voteItem.voters = remoteObj[PF_EVENT_VOTE_ITEM_VOTERS];
    voteItem.votingID = remoteObj[PF_EVENT_VOTE_ITEM_VOTING_ID];
    
}

- (void)setCommonRemoteObject:(RemoteObject *)remoteObj withObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object {
    NSAssert([object isKindOfClass:[EventVoteItem class]], @"Type casting is wrong");
    EventVoteItem * voteItem = (EventVoteItem *)object;
    
    remoteObj[PF_EVENT_VOTE_ITEM_END_TIME] = voteItem.endTime;
    remoteObj[PF_EVENT_VOTE_ITEM_SCORE] = voteItem.score ;
    remoteObj[PF_EVENT_VOTE_ITEM_START_TIME] = voteItem.startTime ;
    remoteObj[PF_EVENT_VOTE_ITEM_VOTE_COUNT] = voteItem.voteCount ;
    remoteObj[PF_EVENT_VOTE_ITEM_VOTERS] = voteItem.voters ;
    remoteObj[PF_EVENT_VOTE_ITEM_VOTING_ID] = voteItem.votingID ;
    
}


@end
