//
//  User+CoreDataProperties.h
//  MyApp
//
//  Created by Linwei Ding on 11/7/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *emailCopy;
@property (nullable, nonatomic, retain) NSString *facebookID;
@property (nullable, nonatomic, retain) NSString *fullname;
@property (nullable, nonatomic, retain) NSString *fullnameLower;
@property (nullable, nonatomic, retain) NSString *password;
@property (nullable, nonatomic, retain) NSString *twitterID;
@property (nullable, nonatomic, retain) NSString *username;
@property (nullable, nonatomic, retain) Picture *picture;
@property (nullable, nonatomic, retain) Thumbnail *thumbnail;

@end

NS_ASSUME_NONNULL_END
