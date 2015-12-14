//
//  ArrayElement+CoreDataProperties.h
//  MyApp
//
//  Created by Linwei Ding on 12/13/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ArrayElement.h"

NS_ASSUME_NONNULL_BEGIN

@interface ArrayElement (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *indexStr;

@end

NS_ASSUME_NONNULL_END
