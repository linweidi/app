//
//  Message.h
//  MyApp
//
//  Created by Linwei Ding on 10/1/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "EntityObject.h"

@class User;

@interface Message : EntityObject

@property (nonatomic, retain) NSDate * createdTime;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * chatID;
@property (nonatomic, retain) NSString * videoName;
@property (nonatomic, retain) NSString * pictureName;
@property (nonatomic, retain) NSString * pictureURL;
@property (nonatomic, retain) NSString * videoURL;
@property (nonatomic, retain) User *user;

@end
