//
//  Alert+Util.h
//  MyApp
//
//  Created by Linwei Ding on 9/23/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//
#import <Parse/Parse.h>
#import "Alert.h"

@interface Alert (Util)

#undef ENTITY_UTIL_TEMPLATE_CLASS
#undef ENTITY_UTIL_TEMPLATE_CLASS_NAME
#define ENTITY_UTIL_TEMPLATE_CLASS Alert
#define ENTITY_UTIL_TEMPLATE_CLASS_NAME @"Alert"

#include "../Template/EntityUtilTemplate.hh"

@end
