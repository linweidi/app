//
//  Thumbnail+Util.h
//  MyApp
//
//  Created by Linwei Ding on 9/23/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//

#import "Parse/Parse.h"
#import "Thumbnail.h"

@interface Thumbnail (Util)
#undef ENTITY_UTIL_TEMPLATE_CLASS
#undef ENTITY_UTIL_TEMPLATE_CLASS_NAME
#define ENTITY_UTIL_TEMPLATE_CLASS Thumbnail
#define ENTITY_UTIL_TEMPLATE_CLASS_NAME @"Thumbnail"

#include "../Template/EntityUtilTemplate.hh"

//+ (Thumbnail *) thumbnailEntity:(NSString *)name inManagedObjectContext: (NSManagedObjectContext *)context ;


+ (Thumbnail *) thumbnailEntityWithPFUser:(PFFile *)thumbFile withUserID:(NSString *)userID inManagedObjectContext: (NSManagedObjectContext *)context;

@end
