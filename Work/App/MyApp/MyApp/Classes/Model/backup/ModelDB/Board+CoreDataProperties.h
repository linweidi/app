//
//  Board+CoreDataProperties.h
//  MyApp
//
//  Created by Linwei Ding on 11/14/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Board.h"

NS_ASSUME_NONNULL_BEGIN

@interface Board (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *categoryID;
@property (nullable, nonatomic, retain) NSString *city;
@property (nullable, nonatomic, retain) id eventIDs;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *categoryName;
@property (nullable, nonatomic, retain) NSString *country;
@property (nullable, nonatomic, retain) NSString *state;

@end

NS_ASSUME_NONNULL_END
