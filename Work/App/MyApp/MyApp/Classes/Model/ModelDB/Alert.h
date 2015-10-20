//
//  Alert.h
//  MyApp
//
//  Created by Linwei Ding on 10/20/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//
// new template
#import <Foundation/Foundation.h>
#import "EntityObject.h"

@class Event;



@interface Alert : EntityObject

@property (nullable, nonatomic, retain) NSDate *time;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) Event *event;


@end

