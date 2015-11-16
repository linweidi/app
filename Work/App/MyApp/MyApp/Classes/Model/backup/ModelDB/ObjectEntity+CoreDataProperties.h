//
//  ObjectEntity+CoreDataProperties.h
//  MyApp
//
//  Created by Linwei Ding on 11/12/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ObjectEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface ObjectEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *createTime;
@property (nullable, nonatomic, retain) NSString *globalID;
@property (nullable, nonatomic, retain) NSDate *updateTime;

@end

NS_ASSUME_NONNULL_END
