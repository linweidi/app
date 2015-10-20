//
//  EventVoteItem.h
//  MyApp
//
//  Created by Linwei Ding on 10/19/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "EntityObject.h"


@interface EventVoteItem : EntityObject

@property (nonatomic, retain) NSNumber * score;
@property (nonatomic, retain) NSString * voterName;
@property (nonatomic, retain) NSNumber * voteNum;
@property (nonatomic, retain) NSString * votingID;

@end
