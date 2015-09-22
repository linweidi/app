//
//  Recent.h
//  MyApp
//
//  Created by Linwei Ding on 9/22/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Recent : NSManagedObject

@property (nonatomic, retain) NSString * user;
@property (nonatomic, retain) NSString * chatId;
@property (nonatomic, retain) NSString * member;
@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) NSString * lastUser;
@property (nonatomic, retain) NSString * lastMessage;
@property (nonatomic, retain) NSNumber * counter;
@property (nonatomic, retain) NSDate * updateDate;

@end
