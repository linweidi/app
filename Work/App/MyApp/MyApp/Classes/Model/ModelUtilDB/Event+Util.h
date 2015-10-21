//
//  Event+Util.h
//  MyApp
//
//  Created by Linwei Ding on 9/23/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//
#import <Parse/Parse.h>
#import "Event.h"




@interface Event (Util)

#define ENTITY_UTIL_TEMPLATE_CLASS Event
#define ENTITY_UTIL_TEMPLATE_CLASS_NAME @"Event"

#include "EntityUtilTemplate.hh"

@end
