//
//  Thumbnail.h
//  MyApp
//
//  Created by Linwei Ding on 11/20/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "UserEntity.h"

@class EventCategory, Place, User;

@interface Thumbnail : UserEntity

@property (nonatomic, retain) NSData * data;
@property (nonatomic, retain) NSString * fileName;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) EventCategory *categoryInv;
@property (nonatomic, retain) Place *placeInv;
@property (nonatomic, retain) User *userInv;

@end
