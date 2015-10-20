//
//  SystemEntity.h
//  MyApp
//
//  Created by Linwei Ding on 10/19/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SystemEntity : NSManagedObject

@property (nonatomic, retain) NSDate * createTime;
@property (nonatomic, retain) NSDate * updateTime;
@property (nonatomic, retain) NSString * globalID;
@property (nonatomic, retain) NSString * systemID;
@property (nonatomic, retain) NSString * versionID;

@end
