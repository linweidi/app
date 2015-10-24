//
//  Board.h
//  MyApp
//
//  Created by Linwei Ding on 10/19/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SystemEntity.h"


@interface Board : SystemEntity

@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) id eventIDs;
@property (nonatomic, retain) NSNumber * categoryID;

@end
