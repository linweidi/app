//
//  Recent+CoreDataProperties.h
//  MyApp
//
//  Created by Linwei Ding on 11/16/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Recent.h"

NS_ASSUME_NONNULL_BEGIN

@interface Recent (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *chatID;
@property (nullable, nonatomic, retain) NSNumber *counter;
@property (nullable, nonatomic, retain) NSString *details;
@property (nullable, nonatomic, retain) NSString *fullname;
@property (nullable, nonatomic, retain) NSString *lastMessage;
@property (nullable, nonatomic, retain) id members;
@property (nullable, nonatomic, retain) User *lastUser;
@property (nullable, nonatomic, retain) User *userVolatile;

@end

NS_ASSUME_NONNULL_END
