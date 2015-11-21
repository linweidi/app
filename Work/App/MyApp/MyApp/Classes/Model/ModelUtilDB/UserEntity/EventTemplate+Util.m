//
//  EventTemplate+Util.m
//  MyApp
//
//  Created by Linwei Ding on 11/20/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import "EventTemplate+Util.h"

@implementation EventTemplate (Util)

#undef ENTITY_UTIL_TEMPLATE_CLASS
#undef ENTITY_UTIL_TEMPLATE_CLASS_NAME
#define ENTITY_UTIL_TEMPLATE_CLASS EventTemplate
#define ENTITY_UTIL_TEMPLATE_CLASS_NAME @"EventTemplate"

#include "../Template/EntityUtilTemplate.mh"

@end
