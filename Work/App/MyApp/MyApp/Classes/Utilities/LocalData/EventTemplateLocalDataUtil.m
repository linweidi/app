//
//  EventTemplateLocalDataUtil.m
//  MyApp
//
//  Created by Linwei Ding on 11/20/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import "EventCategory+Util.h"
#import "Place+Util.h"
#import "EventTemplate+Util.h"
#import "EventTemplateLocalDataUtil.h"

#undef LOCAL_DATA_CLASS_TYPE
#define LOCAL_DATA_CLASS_TYPE EventTemplate

@implementation EventTemplateLocalDataUtil

+ (EventTemplateLocalDataUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static EventTemplateLocalDataUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_EVENT_TEMPLATE_CLASS_NAME;
        
        sharedObject.index = LOCAL_DATA_EVENT_TEMPLATE_INDEX;
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
    
    
    LOCAL_DATA_CLASS_TYPE * template = (LOCAL_DATA_CLASS_TYPE *)object;
    
    template.boardIDs = dict[PF_EVENT_TEMPLATE_BOARDIDS];
    template.groupIDs = dict[PF_EVENT_TEMPLATE_GROUPIDS];
    template.invitees = dict[PF_EVENT_TEMPLATE_INVITEES];
    template.location = dict[PF_EVENT_TEMPLATE_LOCATION];
    template.notes = dict[PF_EVENT_TEMPLATE_NOTES];
    template.scope = dict[PF_EVENT_TEMPLATE_SCOPE];
    template.title = dict[PF_EVENT_TEMPLATE_TITLE];
    
    template.category = [EventCategory entityWithID:dict[PF_EVENT_TEMPLATE_CATEGORY] inManagedObjectContext:self.managedObjectContext];
    template.place = [Place entityWithID:dict[PF_EVENT_TEMPLATE_PLACE] inManagedObjectContext:self.managedObjectContext];
    
}

@end
