//
//  Thumbnail+CoreDataProperties.h
//  MyApp
//
//  Created by Linwei Ding on 11/13/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Thumbnail.h"

NS_ASSUME_NONNULL_BEGIN

@interface Thumbnail (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *data;
@property (nullable, nonatomic, retain) NSString *fileName;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *url;
@property (nullable, nonatomic, retain) Place *placeInv;
@property (nullable, nonatomic, retain) User *userInv;
@property (nullable, nonatomic, retain) EventCategory *categoryInv;

@end

NS_ASSUME_NONNULL_END
