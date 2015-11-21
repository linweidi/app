//
//  EventVoteItem.h
//  MyApp
//
//  Created by Linwei Ding on 11/20/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "UserEntity.h"


@interface EventVoteItem : UserEntity

@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) NSNumber * score;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSNumber * voteCount;
@property (nonatomic, retain) NSString * votingID;
@property (nonatomic, retain) id voters;

@end
