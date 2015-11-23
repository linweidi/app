//
//  EventVotingRemoteUtil.m
//  MyApp
//
//  Created by Linwei Ding on 11/20/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import "EventVoting+Util.h"
#import "EventVotingRemoteUtil.h"

@implementation EventVotingRemoteUtil

+ (EventVotingRemoteUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static EventVotingRemoteUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_EVENT_VOTING_CLASS_NAME;
    });
    return sharedObject;
}

- (void)setCommonObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context {
    NSAssert([object isKindOfClass:[EventVoting class]], @"Type casting is wrong");
    EventVoting * voting = (EventVoting *)object;
    
    voting.initiatorDecision = remoteObj[PF_EVENT_VOTING_INITIATOR_DECISION];
    voting.instruction = remoteObj[PF_EVENT_VOTING_INSTRUCTION];
    voting.isPriority = remoteObj[PF_EVENT_VOTING_IS_PRIORITY];
    voting.timeSpan = remoteObj[PF_EVENT_VOTING_TIME_SPAN];
    voting.votedMemberList = remoteObj[PF_EVENT_VOTING_VOTED_MEMBER_LIST];
    voting.voteMaxNum = remoteObj[PF_EVENT_VOTING_VOTE_MAX_NUM];
    voting.voterList = remoteObj[PF_EVENT_VOTING_VOTER_LIST];
    
}

- (void)setCommonRemoteObject:(RemoteObject *)remoteObj withObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object {
    NSAssert([object isKindOfClass:[EventVoting class]], @"Type casting is wrong");
    EventVoting * voting = (EventVoting *)object;
    
    remoteObj[PF_EVENT_VOTING_INITIATOR_DECISION] = voting.initiatorDecision ;
    remoteObj[PF_EVENT_VOTING_INSTRUCTION] = voting.instruction ;
    remoteObj[PF_EVENT_VOTING_IS_PRIORITY] = voting.isPriority ;
    remoteObj[PF_EVENT_VOTING_TIME_SPAN] = voting.timeSpan ;
    remoteObj[PF_EVENT_VOTING_VOTED_MEMBER_LIST] = voting.votedMemberList ;
    remoteObj[PF_EVENT_VOTING_VOTE_MAX_NUM] = voting.voteMaxNum ;
    remoteObj[PF_EVENT_VOTING_VOTER_LIST] = voting.voterList ;
    
}


//- (void)setNewRemoteObject:(RemoteObject *)remoteObj withObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object {
//    [super setNewRemoteObject:remoteObj withObject:object];
//    NSAssert([object isKindOfClass:[EventVoting class]], @"Type casting is wrong");
//    EventVoting * voting = (EventVoting *)object;
//    
//    
//    //thumb
//    if (voting.thumb) {
//        PFObject * thumbRMT = [PFObject objectWithClassName:PF_THUMBNAIL_CLASS_NAME];
//        [[ThumbnailRemoteUtil sharedUtil] setNewRemoteObject:thumbRMT withObject:voting.thumb];
//        remoteObj[PF_EVENT_VOTING_THUMBNAIL] = thumbRMT;
//    }
//}
//
//
//- (void)setExistedRemoteObject:(RemoteObject *)remoteObj withObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object {
//    [super setExistedRemoteObject:remoteObj withObject:object];
//    NSAssert([object isKindOfClass:[EventCategory class]], @"Type casting is wrong");
//    
//}
//
//
//- (void)setNewObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context {
//    [super setNewObject:object withRemoteObject:remoteObj inManagedObjectContext:context];
//    NSAssert([object isKindOfClass:[EventCategory class]], @"Type casting is wrong");
//    
//    
//    EventCategory * voting = (EventCategory *)object;
//    
//    PFObject * thumbnailPicture = remoteObj[PF_EVENT_VOTING_THUMBNAIL];
//    //self.thumbnail = thumbnailPicture.name;
//    if (thumbnailPicture.updatedAt) {
//        Thumbnail * thumb = [Thumbnail createEntity:context];
//        [[ThumbnailRemoteUtil sharedUtil] setNewObject:thumb withRemoteObject:thumbnailPicture inManagedObjectContext:context];
//        voting.thumb = thumb;
//    }
//}
//
//
//- (void)setExistedObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context {
//    [super setExistedObject:object withRemoteObject:remoteObj inManagedObjectContext:context];
//    NSAssert([object isKindOfClass:[Thumbnail class]], @"Type casting is wrong");
//    EventCategory * voting = (EventCategory *)object;
//    
//    // thumb
//    PFObject * thumbnailPicture = remoteObj[PF_PLACE_THUMB];
//    if (thumbnailPicture.updatedAt ) {
//        Thumbnail * thumb = voting.thumb;
//        if (thumb) {
//            if ([thumbnailPicture.updatedAt compare:thumb.updateTime] == NSOrderedDescending) {
//                [[ThumbnailRemoteUtil sharedUtil] setExistedObject:voting.thumb withRemoteObject:thumbnailPicture inManagedObjectContext:context];
//            }
//        }
//        else {
//            thumb = [Thumbnail createEntity:self.managedObjectContext];
//            [[ThumbnailRemoteUtil sharedUtil] setExistedObject:thumb withRemoteObject:thumbnailPicture inManagedObjectContext:context];
//        }
//        voting.thumb = thumb;
//    }
//}
//

@end
