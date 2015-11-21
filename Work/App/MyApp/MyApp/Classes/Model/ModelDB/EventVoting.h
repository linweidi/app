//
//  EventVoting.h
//  MyApp
//
//  Created by Linwei Ding on 11/20/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "UserEntity.h"


@interface EventVoting : UserEntity

@property (nonatomic, retain) NSNumber * initiatorDecision;
@property (nonatomic, retain) NSString * instruction;
@property (nonatomic, retain) NSNumber * isPriority;
@property (nonatomic, retain) NSNumber * timeSpan;
@property (nonatomic, retain) NSNumber * voteMaxNum;
@property (nonatomic, retain) id votedMemberList;
@property (nonatomic, retain) id voterList;

@end
