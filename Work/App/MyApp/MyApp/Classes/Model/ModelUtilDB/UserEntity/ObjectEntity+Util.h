//
//  ObjectEntity+Util.h
//  MyApp
//
//  Created by Linwei Ding on 10/28/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import "ObjectEntity.h"

@interface ObjectEntity (Util)
#define ENTITY_UTIL_TEMPLATE_CLASS ObjectEntity
#define ENTITY_UTIL_TEMPLATE_CLASS_NAME @"ObjectEntity"

#include "../Template/EntityUtilTemplate.hh"
@end
