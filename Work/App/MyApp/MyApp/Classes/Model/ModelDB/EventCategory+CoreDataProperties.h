//
//  EventCategory+CoreDataProperties.h
//  MyApp
//
//  Created by Linwei Ding on 11/28/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "EventCategory.h"

NS_ASSUME_NONNULL_BEGIN

@interface EventCategory (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *childCount;
@property (nullable, nonatomic, retain) id childItems;
@property (nullable, nonatomic, retain) NSNumber *level;
@property (nullable, nonatomic, retain) NSString *localID;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *notes;
@property (nullable, nonatomic, retain) NSNumber *parentItemCount;
@property (nullable, nonatomic, retain) id parentItems;
@property (nullable, nonatomic, retain) NSNumber *relatedItemCount;
@property (nullable, nonatomic, retain) id relatedItems;
@property (nullable, nonatomic, retain) NSNumber *subseqItemCount;
@property (nullable, nonatomic, retain) id subseqItems;
@property (nullable, nonatomic, retain) Thumbnail *thumb;

@end

NS_ASSUME_NONNULL_END
