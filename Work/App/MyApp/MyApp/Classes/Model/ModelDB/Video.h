//
//  Video.h
//  MyApp
//
//  Created by Linwei Ding on 11/20/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "UserEntity.h"

@class Message;

@interface Video : UserEntity

@property (nonatomic, retain) NSData * dataVolatile;
@property (nonatomic, retain) NSString * fileName;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) Message *messageInv;

@end
