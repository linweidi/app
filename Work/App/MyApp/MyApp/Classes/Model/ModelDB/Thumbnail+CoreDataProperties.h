//
//  Thumbnail+CoreDataProperties.h
//  MyApp
//
//  Created by Linwei Ding on 9/23/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Thumbnail.h"

NS_ASSUME_NONNULL_BEGIN

@interface Thumbnail (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *data;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) User *user;

@end

NS_ASSUME_NONNULL_END
