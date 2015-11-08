//
//  People+CoreDataProperties.h
//  MyApp
//
//  Created by Linwei Ding on 11/7/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "People.h"

NS_ASSUME_NONNULL_BEGIN

@interface People (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *userID;
@property (nullable, nonatomic, retain) User *contact;
@property (nullable, nonatomic, retain) User *userVolatile;

@end

NS_ASSUME_NONNULL_END
