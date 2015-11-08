//
//  Message+Util.m
//  MyApp
//
//  Created by Linwei Ding on 9/30/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//
#import "AppHeader.h"
#import "User+Util.h"
#import "CurrentUser+Util.h"
#import "Message+Util.h"

@implementation Message (Util)

#undef ENTITY_UTIL_TEMPLATE_CLASS
#undef ENTITY_UTIL_TEMPLATE_CLASS_NAME
#define ENTITY_UTIL_TEMPLATE_CLASS Message
#define ENTITY_UTIL_TEMPLATE_CLASS_NAME @"Message"

#include "../Template/EntityUtilTemplate.mh"




+ (BOOL) existsMessageEntity:(NSString *)chatID createdTime:(NSDate *)date inManagedObjectContext: (NSManagedObjectContext *)context {
    BOOL ret = NO;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PF_MESSAGE_CLASS_NAME] ;
    request.predicate = [NSPredicate predicateWithFormat:@"chatID = %@ && createdTime > %@", chatID, date];
    request.fetchLimit = MESSAGEVIEW_DISPLAY_ITEM_NUM;
    request.sortDescriptors = @[[NSSortDescriptor
                                 sortDescriptorWithKey:PF_MESSAGE_CREATEDAT
                                 ascending:NO
                                 selector:@selector(compare:)],
                                ];
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error   ];
    
    if (!matches ) {
        //NSAssert(NO, @"match does not exist");
        
    }
    else if ([matches count] > 0) {
        ret = YES;
    }
    
    return ret;
}

+ (NSArray *)messageEntities:(NSString *)chatID inManagedObjectContext: (NSManagedObjectContext *)context {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PF_MESSAGE_CLASS_NAME] ;
    request.predicate = [NSPredicate predicateWithFormat:@"chatID = %@", chatID];
    request.fetchLimit = MESSAGEVIEW_DISPLAY_ITEM_NUM;
    request.sortDescriptors = @[[NSSortDescriptor
                                 sortDescriptorWithKey:PF_MESSAGE_CREATEDAT
                                 ascending:NO
                                 selector:@selector(compare:)],
                                ];
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error   ];
    
    if (!matches ) {
        NSAssert(NO, @"match does not exist");
        
    }
    
    return matches;
}

//+ (Message *) createMessageEntity:(PFObject *)object inManagedObjectContext: (NSManagedObjectContext *)context {
//    
//    Message * message = nil;
//    
//    NSAssert(object, @"input is nil");
//
//    //create a new one
//    message = [NSEntityDescription insertNewObjectForEntityForName:PF_MESSAGE_CLASS_NAME inManagedObjectContext:context];
//
//    [message setWithPFObject:object inManagedObjectContext:context];
//    
//    return message;
//}


+ (NSArray *) messageEntities:(NSString *)chatID createdTime:(NSDate *)date inManagedObjectContext: (NSManagedObjectContext *)context {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PF_MESSAGE_CLASS_NAME] ;
    request.predicate = [NSPredicate predicateWithFormat:@"chatID = %@ && createdTime > %@", chatID, date];
    request.fetchLimit = MESSAGEVIEW_DISPLAY_ITEM_NUM;
    request.sortDescriptors = @[[NSSortDescriptor
                                 sortDescriptorWithKey:PF_MESSAGE_CREATEDAT
                                 ascending:NO
                                 selector:@selector(compare:)],
                                ];
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error   ];
    
    if (!matches ) {
        NSAssert(NO, @"match does not exist");
        
    }
    
    return matches;
}

//
//+ (Message *) messageEntityWithPFObject:(PFObject *)object inManagedObjectContext: (NSManagedObjectContext *)context {
//    
//    Message * message = nil;
//    
//    message = [Message messageEntityWithGlobalID:object.objectId inManagedObjectContext:context];
//    
//    NSAssert(message, @"returned message is nil");
//    
//    [message setWithPFObject:object inManagedObjectContext:context];
//    
//    return message;
//}
//
//+ (Message *) messageEntityWithGlobalID:(NSString *)globalID inManagedObjectContext: (NSManagedObjectContext *)context {
//    
//    Message * message = nil;
//    
//    NSAssert(globalID, @"input is nil");
//    
//
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PF_MESSAGE_CLASS_NAME] ;
//    request.predicate = [NSPredicate predicateWithFormat:@"globalID = %@", globalID];
//    NSError *error;
//    NSArray *matches = [context executeFetchRequest:request error:&error   ];
//    
//    if (!matches || ([matches count]>1)) {
//        NSAssert(NO, @"match count is not unique");
//    }
//    else if (![matches count]) {
//        //create a new one
//        message = [NSEntityDescription insertNewObjectForEntityForName:PF_MESSAGE_CLASS_NAME inManagedObjectContext:context];
//
//    }
//    else {
//        message = [matches lastObject];
//
//    }
//        
//    
//    
//    return message;
//}
//
//- (void) setWithRemoteObject:(RemoteObject *)object inManagedObjectContext: (NSManagedObjectContext *)context{
//    [self setWithPFObject:object inManagedObjectContext:context];
//}
//
//- (void) setWithPFObject:(PFObject *)object inManagedObjectContext: (NSManagedObjectContext *)context{
//    self.globalID = object.objectId;
//    self.chatID = object[PF_MESSAGE_GROUPID];
//    self.createdTime = object[PF_MESSAGE_CREATEDAT];
//    PFFile * file = object[PF_MESSAGE_PICTURE];
//    self.pictureName = file.name;
//    self.pictureURL = file.url;
//    file = object[PF_MESSAGE_VIDEO];
//    self.videoName = file.name;
//    self.videoURL = file.url;
//    self.text =  object[PF_MESSAGE_TEXT];
//    
//    self.user = [User convertFromRemoteUser:object[PF_MESSAGE_USER] inManagedObjectContext:context];
//
//}
//
@end
