//
//  AlertRemoteUtil.m
//  MyApp
//
//  Created by Linwei Ding on 10/21/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import "AlertRemoteUtil.h"

@implementation AlertRemoteUtil
- (void) setNewAlert:(Alert *)alert withRemoteObject:(RemoteObject *)object inManagedObjectContext: (NSManagedObjectContext *)context {
    alert.globalID = object[PF_ALERT_OBJECTID];
    alert.createTime = object[PF_ALERT_CREATE_TIME];
    alert.updateTime = object[PF_ALERT_UPDATE_TIME];
    [self setCommonAlert:alert withRemoteObject:object];
}

- (void) setExistedAlert:(Alert *)alert withRemoteObject:(RemoteObject *)object inManagedObjectContext: (NSManagedObjectContext *)context {
    //alert.globalID = object[PF_ALERT_OBJECTID];
    //alert.createTime = object[PF_ALERT_CREATE_TIME];
    alert.updateTime = object[PF_ALERT_UPDATE_TIME];
    
    [self setCommonAlert:alert withRemoteObject:object];
}

- (void) setNewRemoteAlert:(RemoteObject *)object withAlert:(Alert *)alert inManagedObjectContext: (NSManagedObjectContext *)context{
    object[PF_ALERT_CREATE_TIME] = alert.createTime;
    object[PF_ALERT_UPDATE_TIME] = alert.updateTime;
    [self setCommonRemoteAlert:object withAlert:alert];
}

- (void) setExistedRemoteAlert:(RemoteObject *)object withAlert:(Alert *)alert inManagedObjectContext: (NSManagedObjectContext *)context{
    object[PF_ALERT_UPDATE_TIME] = alert.updateTime;
    [self setCommonRemoteAlert:object withAlert:alert];
}

- (RemoteObject *) createNewRemoteAlert:(Alert *)alert inManagedObjectContext: (NSManagedObjectContext *)context{
    PFObject * object = [PFObject objectWithClassName:PF_ALERT_CLASS_NAME];
#warning how to see the globalID?
#warning how to see the createdAt?
    [self setNewRemoteAlert:object withAlert:alert inManagedObjectContext:context];
    
    return object;
}

- (RemoteObject *) createExistedRemoteAlert:(Alert *)alert inManagedObjectContext: (NSManagedObjectContext *)context{
    PFObject * object = [PFObject objectWithoutDataWithClassName:PF_ALERT_CLASS_NAME objectId:PF_ALERT_OBJECTID];
    [self setExistedRemoteAlert:object withAlert:alert inManagedObjectContext:context];
    return object;
}

#pragma mark -- private method

- (void) setCommonAlert:(Alert *)alert withRemoteObject:(RemoteObject *)object {
    
    alert.time = object[PF_ALERT_TIME];
    alert.type = object[PF_ALERT_TYPE];
}

- (void) setCommonRemoteAlert:(RemoteObject *)object withAlert:(Alert *)alert {
    object[PF_ALERT_TIME] = alert.time;
    object[PF_ALERT_TYPE] = alert.type;
}
@end
