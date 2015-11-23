//
//  EventTemplateRemoteUtil.m
//  MyApp
//
//  Created by Linwei Ding on 11/20/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//
#import "EventCategory+Util.h"
#import "Place+Util.h"
#import "EventTemplate+Util.h"
#import "EventTemplateRemoteUtil.h"

@implementation EventTemplateRemoteUtil

+ (EventTemplateRemoteUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static EventTemplateRemoteUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_EVENT_TEMPLATE_CLASS_NAME;
    });
    return sharedObject;
}

- (void)setCommonObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context {
    NSAssert([object isKindOfClass:[EventTemplate class]], @"Type casting is wrong");
    EventTemplate * template = (EventTemplate *)object;
    
    template.boardIDs = remoteObj[PF_EVENT_TEMPLATE_BOARDIDS];
    template.groupIDs = remoteObj[PF_EVENT_TEMPLATE_GROUPIDS];
    template.invitees = remoteObj[PF_EVENT_TEMPLATE_INVITEES];
    template.location = remoteObj[PF_EVENT_TEMPLATE_LOCATION];
    template.notes = remoteObj[PF_EVENT_TEMPLATE_NOTES];
    template.scope = remoteObj[PF_EVENT_TEMPLATE_SCOPE];
    template.title = remoteObj[PF_EVENT_TEMPLATE_TITLE];
}

- (void)setCommonRemoteObject:(RemoteObject *)remoteObj withObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object {
    NSAssert([object isKindOfClass:[EventTemplate class]], @"Type casting is wrong");
    EventTemplate * template = (EventTemplate *)object;
    
    remoteObj[PF_EVENT_TEMPLATE_BOARDIDS] = template.boardIDs ;
    remoteObj[PF_EVENT_TEMPLATE_GROUPIDS] = template.groupIDs ;
    remoteObj[PF_EVENT_TEMPLATE_INVITEES] = template.invitees ;
    remoteObj[PF_EVENT_TEMPLATE_LOCATION] = template.location ;
    remoteObj[PF_EVENT_TEMPLATE_NOTES] = template.notes ;
    remoteObj[PF_EVENT_TEMPLATE_SCOPE] = template.scope ;
    remoteObj[PF_EVENT_TEMPLATE_TITLE] = template.title ;
    
}

- (void)setNewRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object {
    [super setNewRemoteObject:remoteObj withObject:object];
    NSAssert([object isKindOfClass:[EventTemplate class]], @"Type casting is wrong");
    EventTemplate * template = (EventTemplate *)object;
    
    if (template.place) {
        PFObject * placePF = [PFObject objectWithoutDataWithClassName:PF_PLACE_CLASS_NAME objectId:template.place.globalID];
        remoteObj[PF_EVENT_TEMPLATE_PLACE] = placePF;
    }
    
    if (template.category) {
        PFObject * categoryPF = [PFObject objectWithoutDataWithClassName:PF_EVENT_CATEGORY_CLASS_NAME objectId:template.category.globalID];
        remoteObj[PF_EVENT_TEMPLATE_CATEGORY] = categoryPF;   //get a new category
    }
}

- (void)setExistedRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object {
    [super setExistedRemoteObject:remoteObj withObject:object];
    NSAssert([object isKindOfClass:[EventTemplate class]], @"Type casting is wrong");
    NSAssert(NO, @"should not user setExistedRemoteObject");
}

- (void)setNewObject:(UserEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context {
    [super setNewObject:object withRemoteObject:remoteObj inManagedObjectContext:context];
    NSAssert([object isKindOfClass:[EventTemplate class]], @"Type casting is wrong");
    EventTemplate * template = (EventTemplate *)object;
    
    
    
    // place
    PFObject * placePF = remoteObj[PF_EVENT_TEMPLATE_PLACE];
    template.place = [Place entityWithID:placePF.objectId inManagedObjectContext:context];
    
    
    
    // category
    PFObject * categoryPF = remoteObj[PF_EVENT_TEMPLATE_CATEGORY];
    template.category = [EventCategory entityWithID:categoryPF.objectId inManagedObjectContext:context];
}

- (void)setExistedObject:(UserEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context {
    [super setExistedObject:object withRemoteObject:remoteObj inManagedObjectContext:context];
    NSAssert([object isKindOfClass:[EventTemplate class]], @"Type casting is wrong");
    EventTemplate * template = (EventTemplate *)object;
    
    // place
    PFObject * placePF = remoteObj[PF_EVENT_TEMPLATE_PLACE];
    template.place = [Place entityWithID:placePF.objectId inManagedObjectContext:context];
    
    // category
    PFObject * categoryPF = remoteObj[PF_EVENT_TEMPLATE_CATEGORY];
    template.category = [EventCategory entityWithID:categoryPF.objectId inManagedObjectContext:context];
}


@end
