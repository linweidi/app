//
//  ArrayElement+Util.h
//  MyApp
//
//  Created by Linwei Ding on 12/13/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "ArrayElement.h"

@interface ArrayElement (Util)

#undef ENTITY_UTIL_TEMPLATE_CLASS
#undef ENTITY_UTIL_TEMPLATE_CLASS_NAME
#define ENTITY_UTIL_TEMPLATE_CLASS ArrayElement
#define ENTITY_UTIL_TEMPLATE_CLASS_NAME @"ArrayElement"

#include "../Template/EntityUtilTemplate.hh"

@end
