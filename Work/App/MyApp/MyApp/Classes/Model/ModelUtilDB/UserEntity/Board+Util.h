//
//  Board+Util.h
//  MyApp
//
//  Created by Linwei Ding on 11/14/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "Board.h"

@interface Board (Util)

#undef ENTITY_UTIL_TEMPLATE_CLASS
#undef ENTITY_UTIL_TEMPLATE_CLASS_NAME
#define ENTITY_UTIL_TEMPLATE_CLASS Board
#define ENTITY_UTIL_TEMPLATE_CLASS_NAME @"Board"

#include "../Template/EntityUtilTemplate.hh"
@end
