//
//  MessageLocalDataUtility.m
//  MyApp
//
//  Created by Linwei Ding on 11/8/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
#import "Message+Util.h"
#import "Picture+Util.h"
#import "Video+Util.h"
#import "User+Util.h"
#import "CurrentUser+Util.h"
#import "ConfigurationManager.h"
#import "MessageLocalDataUtil.h"

#undef LOCAL_DATA_CLASS_TYPE
#define LOCAL_DATA_CLASS_TYPE Message

@implementation MessageLocalDataUtil

+ (MessageLocalDataUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static MessageLocalDataUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_MESSAGE_CLASS_NAME;
        
        sharedObject.index = LOCAL_DATA_MESSAGE_INDEX;
    });
    return sharedObject;
}

#pragma mark - Inheritance methods

- (NSArray *)constructDataFromDict:(NSDictionary *)dict {
    
    NSMutableArray *resultArray = [NSMutableArray array];
    
    for (NSDictionary *obj in [dict allValues]) {
        
        LOCAL_DATA_CLASS_TYPE * object = [LOCAL_DATA_CLASS_TYPE createEntity:self.managedObjectContext];
        //Feedback *loadedData = [[Feedback alloc] init];
        
        [self setRandomValues:object data:obj];
        [resultArray addObject:object];
    }
    
    return [NSArray arrayWithArray:resultArray];
}

- (void) setRandomValues: (id) object data:(NSDictionary *)dict{
    [super setRandomValues:object data:dict];
    
    
    LOCAL_DATA_CLASS_TYPE * message = (LOCAL_DATA_CLASS_TYPE *)object;
    
    
    message.chatID = dict[PF_MESSAGE_GROUPID] ;
    message.text = dict[PF_MESSAGE_TEXT];
    
    message.picture = [Picture entityWithID:dict[PF_MESSAGE_PICTURE] inManagedObjectContext:self.managedObjectContext];
    message.video = [Video entityWithID:dict[PF_MESSAGE_VIDEO] inManagedObjectContext:self.managedObjectContext];
    
    message.createUser = [User entityWithID:dict[PF_MESSAGE_USER] inManagedObjectContext:self.managedObjectContext];
}


- (void) createLocalMessage:(NSString *)chatId text:(NSString *)text Video:(Video *)video Picture:(Picture *)picture completionHandler:(REMOTE_OBJECT_BLOCK)block{
    
    Message * message = [Message createEntity:self.managedObjectContext];
    message.createUser = [[ConfigurationManager sharedManager] getCurrentUser];
    message.chatID = chatId;
    message.text = text;
    message.picture = picture;
    message.video = video;
    
    [self setCommonValues:message];
    
}
@end
