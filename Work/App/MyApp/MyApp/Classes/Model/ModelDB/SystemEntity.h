//
//  SystemEntity.h
//  MyApp
//
//  Created by Linwei Ding on 11/20/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ObjectEntity.h"


@interface SystemEntity : ObjectEntity

@property (nonatomic, retain) NSString * systemID;
@property (nonatomic, retain) NSString * versionID;

@end
