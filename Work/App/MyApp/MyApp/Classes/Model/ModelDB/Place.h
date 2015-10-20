//
//  Place.h
//  MyApp
//
//  Created by Linwei Ding on 10/19/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SystemEntity.h"

@class Thumbnail;

@interface Place : SystemEntity

@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSString * parking;
@property (nonatomic, retain) NSString * rankings;
@property (nonatomic, retain) NSDate * openTime;
@property (nonatomic, retain) NSDate * closeTime;
@property (nonatomic, retain) NSString * map;
@property (nonatomic, retain) NSString * tips;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) id photos;
@property (nonatomic, retain) NSString * like;
@property (nonatomic, retain) NSSet *thumbs;
@end

@interface Place (CoreDataGeneratedAccessors)

- (void)addThumbsObject:(Thumbnail *)value;
- (void)removeThumbsObject:(Thumbnail *)value;
- (void)addThumbs:(NSSet *)values;
- (void)removeThumbs:(NSSet *)values;

@end
