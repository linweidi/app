//
//  Event.h
//  MyApp
//
//  Created by Linwei Ding on 11/28/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserEntity.h"

@class Alert, EventCategory, Place, User;

NS_ASSUME_NONNULL_BEGIN

@interface Event : UserEntity

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "Event+CoreDataProperties.h"
