//
//  EventCategory.h
//  MyApp
//
//  Created by Linwei Ding on 11/20/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SystemEntity.h"

@class Thumbnail;

@interface EventCategory : SystemEntity

@property (nonatomic, retain) NSNumber * childCount;
@property (nonatomic, retain) id childItems;
@property (nonatomic, retain) NSNumber * level;
@property (nonatomic, retain) NSString * localID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * parentItemCount;
@property (nonatomic, retain) id parentItems;
@property (nonatomic, retain) NSNumber * relatedItemCount;
@property (nonatomic, retain) id relatedItems;
@property (nonatomic, retain) NSNumber * subseqItemCount;
@property (nonatomic, retain) id subseqItems;
@property (nonatomic, retain) Thumbnail *thumb;

@end
