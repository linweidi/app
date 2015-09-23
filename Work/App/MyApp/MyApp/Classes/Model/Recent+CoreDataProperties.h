//
//  Recent+CoreDataProperties.h
//  MyApp
//
//  Created by Linwei Ding on 9/22/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Recent.h"

NS_ASSUME_NONNULL_BEGIN

@interface Recent (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *chatId;
@property (nullable, nonatomic, retain) NSNumber *counter;
@property (nullable, nonatomic, retain) NSString *details;
@property (nullable, nonatomic, retain) NSString *lastMessage;
@property (nullable, nonatomic, retain) NSString *lastUser;
@property (nullable, nonatomic, retain) NSString *member;
@property (nullable, nonatomic, retain) NSDate *updateDate;
@property (nullable, nonatomic, retain) NSString *user;

@end

NS_ASSUME_NONNULL_END
