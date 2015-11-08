//
//  Video+Util.h
//  MyApp
//
//  Created by Linwei Ding on 10/28/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import "Video.h"

@interface Video (Util)
#undef ENTITY_UTIL_TEMPLATE_CLASS
#undef ENTITY_UTIL_TEMPLATE_CLASS_NAME
#define ENTITY_UTIL_TEMPLATE_CLASS Video
#define ENTITY_UTIL_TEMPLATE_CLASS_NAME @"Video"

#include "../Template/EntityUtilTemplate.hh"
@end
