//
//  Board.h
//  MyApp
//
//  Created by Linwei Ding on 10/27/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SystemEntity.h"


@interface Board : SystemEntity

@property (nonatomic, retain) NSNumber * categoryID;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) id eventIDs;
@property (nonatomic, retain) NSString * type;

@end
