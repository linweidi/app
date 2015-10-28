//
//  EventCategory.h
//  MyApp
//
//  Created by Linwei Ding on 10/27/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SystemEntity.h"


@interface EventCategory : SystemEntity

@property (nonatomic, retain) id childArray;
@property (nonatomic, retain) NSNumber * childCount;
@property (nonatomic, retain) NSNumber * level;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * parent;
@property (nonatomic, retain) id relatedArray;
@property (nonatomic, retain) id subArray;

@end
