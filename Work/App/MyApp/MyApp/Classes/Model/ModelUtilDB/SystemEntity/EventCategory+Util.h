//
//  EventCategory+Util.h
//  MyApp
//
//  Created by Linwei Ding on 10/21/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import "EventCategory.h"

@interface EventCategory (Util)
#undef ENTITY_UTIL_TEMPLATE_CLASS
#undef ENTITY_UTIL_TEMPLATE_CLASS_NAME
#define ENTITY_UTIL_TEMPLATE_CLASS EventCategory
#define ENTITY_UTIL_TEMPLATE_CLASS_NAME @"EventCategory"

#include "../Template/EntityUtilTemplate.hh"



+ (ENTITY_UTIL_TEMPLATE_CLASS *)entityWithLocalID:(NSString *)localID inManagedObjectContext:  (NSManagedObjectContext *)context;

@end
