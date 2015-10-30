//
//  Picture+Util.h
//  MyApp
//
//  Created by Linwei Ding on 10/22/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
#import <Parse/Parse.h>
#import <Foundation/Foundation.h>
#import "Picture.h"

@interface Picture (Util)
#undef ENTITY_UTIL_TEMPLATE_CLASS
#undef ENTITY_UTIL_TEMPLATE_CLASS_NAME
#define ENTITY_UTIL_TEMPLATE_CLASS Picture
#define ENTITY_UTIL_TEMPLATE_CLASS_NAME @"Picture"

#include "../Template/EntityUtilTemplate.hh"

@end
