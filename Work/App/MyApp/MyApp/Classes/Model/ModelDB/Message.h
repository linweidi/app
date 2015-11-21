//
//  Message.h
//  MyApp
//
//  Created by Linwei Ding on 11/20/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "UserEntity.h"

@class Picture, User, Video;

@interface Message : UserEntity

@property (nonatomic, retain) NSString * chatID;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) User *createUser;
@property (nonatomic, retain) Picture *picture;
@property (nonatomic, retain) Video *video;

@end
