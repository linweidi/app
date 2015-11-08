//
//  ObjectEntity+Util.m
//  MyApp
//
//  Created by Linwei Ding on 10/28/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import "ObjectEntity+Util.h"

@implementation ObjectEntity (Util)

#undef ENTITY_UTIL_TEMPLATE_CLASS
#undef ENTITY_UTIL_TEMPLATE_CLASS_NAME
#define ENTITY_UTIL_TEMPLATE_CLASS ObjectEntity
#define ENTITY_UTIL_TEMPLATE_CLASS_NAME @"ObjectEntity"

#include "../Template/EntityUtilTemplate.mh"
@end
