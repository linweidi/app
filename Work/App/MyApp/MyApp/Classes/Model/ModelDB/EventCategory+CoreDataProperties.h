//
//  EventCategory+CoreDataProperties.h
//  MyApp
//
//  Created by Linwei Ding on 12/13/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "EventCategory.h"

NS_ASSUME_NONNULL_BEGIN

@interface EventCategory (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *childCount;
@property (nullable, nonatomic, retain) NSNumber *level;
@property (nullable, nonatomic, retain) NSString *localID;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *notes;
@property (nullable, nonatomic, retain) NSNumber *parentItemCount;
@property (nullable, nonatomic, retain) NSNumber *relatedItemCount;
@property (nullable, nonatomic, retain) NSNumber *subseqItemCount;
@property (nullable, nonatomic, retain) Thumbnail *thumb;
@property (nullable, nonatomic, retain) NSSet<ArrayElement *> *childItems;
@property (nullable, nonatomic, retain) NSSet<ArrayElement *> *parentItems;
@property (nullable, nonatomic, retain) NSSet<ArrayElement *> *relatedItems;
@property (nullable, nonatomic, retain) NSSet<ArrayElement *> *subseqItems;

@end

@interface EventCategory (CoreDataGeneratedAccessors)

- (void)addChildItemsObject:(ArrayElement *)value;
- (void)removeChildItemsObject:(ArrayElement *)value;
- (void)addChildItems:(NSSet<ArrayElement *> *)values;
- (void)removeChildItems:(NSSet<ArrayElement *> *)values;

- (void)addParentItemsObject:(ArrayElement *)value;
- (void)removeParentItemsObject:(ArrayElement *)value;
- (void)addParentItems:(NSSet<ArrayElement *> *)values;
- (void)removeParentItems:(NSSet<ArrayElement *> *)values;

- (void)addRelatedItemsObject:(ArrayElement *)value;
- (void)removeRelatedItemsObject:(ArrayElement *)value;
- (void)addRelatedItems:(NSSet<ArrayElement *> *)values;
- (void)removeRelatedItems:(NSSet<ArrayElement *> *)values;

- (void)addSubseqItemsObject:(ArrayElement *)value;
- (void)removeSubseqItemsObject:(ArrayElement *)value;
- (void)addSubseqItems:(NSSet<ArrayElement *> *)values;
- (void)removeSubseqItems:(NSSet<ArrayElement *> *)values;

@end

NS_ASSUME_NONNULL_END
