//
//  Place.h
//  MyApp
//
//  Created by Linwei Ding on 10/27/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SystemEntity.h"

@class Picture, Thumbnail;

@interface Place : SystemEntity

@property (nonatomic, retain) NSDate * closeTime;
@property (nonatomic, retain) NSString * likes;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * map;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * openTime;
@property (nonatomic, retain) NSNumber * parking;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSNumber * rankings;
@property (nonatomic, retain) NSString * tips;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSSet *photos;
@property (nonatomic, retain) Thumbnail *thumb;
@end

@interface Place (CoreDataGeneratedAccessors)

- (void)addPhotosObject:(Picture *)value;
- (void)removePhotosObject:(Picture *)value;
- (void)addPhotos:(NSSet *)values;
- (void)removePhotos:(NSSet *)values;

@end
