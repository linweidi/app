//
//  Group+CoreDataProperties.h
//  MyApp
//
//  Created by Linwei Ding on 9/22/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Group.h"

NS_ASSUME_NONNULL_BEGIN

@interface Group (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *members;
@property (nullable, nonatomic, retain) NSString *user;

@end

NS_ASSUME_NONNULL_END
