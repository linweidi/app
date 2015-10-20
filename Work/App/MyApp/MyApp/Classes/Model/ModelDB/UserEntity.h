//
//  UserEntity.h
//  MyApp
//
//  Created by Linwei Ding on 10/19/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserEntity : NSManagedObject

@property (nonatomic, retain) NSDate * createTime;
@property (nonatomic, retain) NSString * globalID;
@property (nonatomic, retain) NSDate * updateTime;

@end
