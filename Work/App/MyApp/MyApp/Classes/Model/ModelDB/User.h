//
//  User.h
//  MyApp
//
//  Created by Linwei Ding on 11/20/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "UserEntity.h"

@class Picture, Thumbnail;

@interface User : UserEntity

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * emailCopy;
@property (nonatomic, retain) NSString * facebookID;
@property (nonatomic, retain) NSString * fullname;
@property (nonatomic, retain) NSString * fullnameLower;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * twitterID;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) Picture *picture;
@property (nonatomic, retain) Thumbnail *thumbnail;

@end
