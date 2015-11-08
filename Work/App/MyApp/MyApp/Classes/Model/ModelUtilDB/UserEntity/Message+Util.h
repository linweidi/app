//
//  Message+Util.h
//  MyApp
//
//  Created by Linwei Ding on 9/30/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import "Message.h"

@interface Message (Util)

#undef ENTITY_UTIL_TEMPLATE_CLASS
#undef ENTITY_UTIL_TEMPLATE_CLASS_NAME
#define ENTITY_UTIL_TEMPLATE_CLASS Message
#define ENTITY_UTIL_TEMPLATE_CLASS_NAME @"Message"

#include "../Template/EntityUtilTemplate.hh"

+ (BOOL) existsMessageEntity:(NSString *)chatID createdTime:(NSDate *)date inManagedObjectContext: (NSManagedObjectContext *)context ;

+ (NSArray *)messageEntities:(NSString *)chatID inManagedObjectContext: (NSManagedObjectContext *)context;
//
+ (NSArray *) messageEntities:(NSString *)chatID createdTime:(NSDate *)date inManagedObjectContext: (NSManagedObjectContext *)context;
//
//+ (Message *) messageEntityWithPFObject:(PFObject *)object inManagedObjectContext: (NSManagedObjectContext *)context;
//
//+ (Message *) messageEntityWithGlobalID:(NSString *)globalID inManagedObjectContext: (NSManagedObjectContext *)context;
//
//- (void) setWithPFObject:(PFObject *)object inManagedObjectContext: (NSManagedObjectContext *)context;
//
//
//+ (Message *) createMessageEntity:(PFObject *)object inManagedObjectContext: (NSManagedObjectContext *)context;
@end
