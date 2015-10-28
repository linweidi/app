//
//  EventVoteItem.h
//  MyApp
//
//  Created by Linwei Ding on 10/27/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "UserEntity.h"


@interface EventVoteItem : UserEntity

@property (nonatomic, retain) NSNumber * score;
@property (nonatomic, retain) NSNumber * voteNum;
@property (nonatomic, retain) NSString * voterName;
@property (nonatomic, retain) NSString * votingID;

@end
