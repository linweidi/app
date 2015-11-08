//
//  Picture+CoreDataProperties.h
//  MyApp
//
//  Created by Linwei Ding on 11/7/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Picture.h"

NS_ASSUME_NONNULL_BEGIN

@interface Picture (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *dataVolatile;
@property (nullable, nonatomic, retain) NSString *fileName;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *url;
@property (nullable, nonatomic, retain) Message *message;
@property (nullable, nonatomic, retain) Place *place;
@property (nullable, nonatomic, retain) User *user;

@end

NS_ASSUME_NONNULL_END
