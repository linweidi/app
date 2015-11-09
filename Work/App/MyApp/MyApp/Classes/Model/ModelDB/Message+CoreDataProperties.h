//
//  Message+CoreDataProperties.h
//  MyApp
//
//  Created by Linwei Ding on 11/8/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Message.h"

NS_ASSUME_NONNULL_BEGIN

@interface Message (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *chatID;
@property (nullable, nonatomic, retain) NSString *text;
@property (nullable, nonatomic, retain) Picture *picture;
@property (nullable, nonatomic, retain) User *createUser;
@property (nullable, nonatomic, retain) Video *video;

@end

NS_ASSUME_NONNULL_END
