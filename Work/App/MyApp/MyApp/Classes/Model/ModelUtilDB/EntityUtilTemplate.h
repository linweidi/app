//
//  EntityUtilTemplate.h
//  MyApp
//
//  Created by Linwei Ding on 10/20/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Parse/Parse.h>


#ifndef ENTITY_UTIL_TEMPLATE_CLASS
#define ENTITY_UTIL_TEMPLATE_CLASS UserEntity
#endif

#ifndef ENTITY_UTIL_TEMPLATE_CLASS_NAME
#define ENTITY_UTIL_TEMPLATE_CLASS_NAME @"UserEntity"
#endif

#ifndef ENTITY_UTIL_TEMPLATE_CLASS_UPDATE_TIME
#define ENTITY_UTIL_TEMPLATE_CLASS_UPDATE_TIME @"updateTime"
#endif


//@class UserEntity;
//@interface ENTITY_UTIL_TEMPLATE_CLASS (Util)
+ (ENTITY_UTIL_TEMPLATE_CLASS *)createEntity: (NSManagedObjectContext *)context ;

+ (ENTITY_UTIL_TEMPLATE_CLASS *)entityWithID:(NSString *)globalID inManagedObjectContext:  (NSManagedObjectContext *)context;

+ (BOOL) deleteEntityWithID:(NSString *)globalID
     inManagedObjectContext: (NSManagedObjectContext *)context;

+ (NSArray *) fetchEntityAll:(NSManagedObjectContext *)context ;

+ (void) clearEntityAll:(NSManagedObjectContext *)context;

+ (ENTITY_UTIL_TEMPLATE_CLASS *) latestEntity:(NSManagedObjectContext *)context ;

//@end

