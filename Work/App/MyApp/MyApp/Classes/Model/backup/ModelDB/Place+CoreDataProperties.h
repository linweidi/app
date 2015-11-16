//
//  Place+CoreDataProperties.h
//  MyApp
//
//  Created by Linwei Ding on 11/14/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Place.h"

NS_ASSUME_NONNULL_BEGIN

@interface Place (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *closeTime;
@property (nullable, nonatomic, retain) NSNumber *likes;
@property (nullable, nonatomic, retain) NSString *location;
@property (nullable, nonatomic, retain) NSString *map;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSDate *openTime;
@property (nullable, nonatomic, retain) NSNumber *parking;
@property (nullable, nonatomic, retain) NSNumber *price;
@property (nullable, nonatomic, retain) NSNumber *rankings;
@property (nullable, nonatomic, retain) NSString *tips;
@property (nullable, nonatomic, retain) NSSet<EventCategory *> *categories;
@property (nullable, nonatomic, retain) NSSet<Picture *> *photos;
@property (nullable, nonatomic, retain) Thumbnail *thumb;

@end

@interface Place (CoreDataGeneratedAccessors)

- (void)addCategoriesObject:(EventCategory *)value;
- (void)removeCategoriesObject:(EventCategory *)value;
- (void)addCategories:(NSSet<EventCategory *> *)values;
- (void)removeCategories:(NSSet<EventCategory *> *)values;

- (void)addPhotosObject:(Picture *)value;
- (void)removePhotosObject:(Picture *)value;
- (void)addPhotos:(NSSet<Picture *> *)values;
- (void)removePhotos:(NSSet<Picture *> *)values;

@end

NS_ASSUME_NONNULL_END
