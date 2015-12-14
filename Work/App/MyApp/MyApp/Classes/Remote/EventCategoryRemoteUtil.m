//
//  EventCategoryRemoteUtil.m
//  MyApp
//
//  Created by Linwei Ding on 11/14/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "EventCategory+Util.h"
#import "ThumbnailRemoteUtil.h"
#import "Thumbnail+Util.h"
#import "EventCategoryRemoteUtil.h"

@implementation EventCategoryRemoteUtil

+ (EventCategoryRemoteUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static EventCategoryRemoteUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_EVENT_CATEGORY_CLASS_NAME;
    });
    return sharedObject;
}

- (void)setCommonObject:(SystemEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context {
    NSAssert([object isKindOfClass:[EventCategory class]], @"Type casting is wrong");
    EventCategory * category = (EventCategory *)object;
    
    NSMutableSet * collection = nil;
    
    category.childCount = remoteObj[PF_EVENT_CATEGORY_CHILD_COUNT];
    //category.childItems = remoteObj[PF_EVENT_CATEGORY_CHILD_ITEMS];
    category.level = remoteObj[PF_EVENT_CATEGORY_LEVEL];
    category.localID = remoteObj[PF_EVENT_CATEGORY_LOCALID];
    category.name = remoteObj[PF_EVENT_CATEGORY_NAME];
    category.notes = remoteObj[PF_EVENT_CATEGORY_NOTES];
    category.parentItemCount = remoteObj[PF_EVENT_CATEGORY_PARENT_COUNT];
    //category.parentItems = remoteObj[PF_EVENT_CATEGORY_PARENT_ITEMS];
    category.relatedItemCount = remoteObj[PF_EVENT_CATEGORY_RELATED_COUNT];
    //category.relatedItems = remoteObj[PF_EVENT_CATEGORY_RELATED_ITEMS];
    category.subseqItemCount = remoteObj[PF_EVENT_CATEGORY_SUBSEQ_COUNT];
    //category.subseqItems = remoteObj[PF_EVENT_CATEGORY_SUBSEQ_ITEMS];
    
    collection = [self createSetFromStringArray:remoteObj[PF_EVENT_CATEGORY_CHILD_ITEMS]];
    [category addChildItems:collection];
    
    collection = [self createSetFromStringArray:remoteObj[PF_EVENT_CATEGORY_PARENT_ITEMS]];
    [category addParentItems:collection];
    
    collection = [self createSetFromStringArray:remoteObj[PF_EVENT_CATEGORY_RELATED_ITEMS]];
    [category addRelatedItems:collection];
    
    collection = [self createSetFromStringArray:remoteObj[PF_EVENT_CATEGORY_SUBSEQ_ITEMS]];
    [category addSubseqItems:collection];
    
}

- (void)setCommonRemoteObject:(RemoteObject *)remoteObj withObject:(SystemEntity *)object {
    NSAssert([object isKindOfClass:[EventCategory class]], @"Type casting is wrong");
    EventCategory * category = (EventCategory *)object;

    
    remoteObj[PF_EVENT_CATEGORY_CHILD_COUNT] = category.childCount;
    remoteObj[PF_EVENT_CATEGORY_CHILD_ITEMS] = [self createArrayFromElementSet:category.childItems] ;
    remoteObj[PF_EVENT_CATEGORY_LEVEL] = category.level ;
    remoteObj[PF_EVENT_CATEGORY_LOCALID] = category.localID ;
    remoteObj[PF_EVENT_CATEGORY_NAME] = category.name ;
    remoteObj[PF_EVENT_CATEGORY_NOTES] = category.notes ;
    remoteObj[PF_EVENT_CATEGORY_PARENT_COUNT] = category.parentItemCount ;
    remoteObj[PF_EVENT_CATEGORY_PARENT_ITEMS] = [self createArrayFromElementSet:category.parentItems] ;
    remoteObj[PF_EVENT_CATEGORY_RELATED_COUNT] = category.relatedItemCount ;
    remoteObj[PF_EVENT_CATEGORY_RELATED_ITEMS] = [self createArrayFromElementSet:category.relatedItems]  ;
    remoteObj[PF_EVENT_CATEGORY_SUBSEQ_COUNT] = category.subseqItemCount ;
    remoteObj[PF_EVENT_CATEGORY_SUBSEQ_ITEMS] = [self createArrayFromElementSet:category.subseqItems]  ;
    
}


- (void)setNewRemoteObject:(RemoteObject *)remoteObj withObject:(SystemEntity *)object {
    [super setNewRemoteObject:remoteObj withObject:object];
    NSAssert([object isKindOfClass:[EventCategory class]], @"Type casting is wrong");
    EventCategory * category = (EventCategory *)object;
    

    //thumb
    if (category.thumb) {
        PFObject * thumbRMT = [PFObject objectWithClassName:PF_THUMBNAIL_CLASS_NAME];
        [[ThumbnailRemoteUtil sharedUtil] setNewRemoteObject:thumbRMT withObject:category.thumb];
        remoteObj[PF_EVENT_CATEGORY_THUMBNAIL] = thumbRMT;
    }
}


- (void)setExistedRemoteObject:(RemoteObject *)remoteObj withObject:(SystemEntity *)object {
    [super setExistedRemoteObject:remoteObj withObject:object];
    NSAssert([object isKindOfClass:[EventCategory class]], @"Type casting is wrong");

}


- (void)setNewObject:(SystemEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context {
    [super setNewObject:object withRemoteObject:remoteObj inManagedObjectContext:context];
    NSAssert([object isKindOfClass:[EventCategory class]], @"Type casting is wrong");
    
    
    EventCategory * category = (EventCategory *)object;
 
    PFObject * thumbnailPicture = remoteObj[PF_EVENT_CATEGORY_THUMBNAIL];
    //self.thumbnail = thumbnailPicture.name;
    if (thumbnailPicture.updatedAt) {
        Thumbnail * thumb = [Thumbnail createEntity:context];
        [[ThumbnailRemoteUtil sharedUtil] setNewObject:thumb withRemoteObject:thumbnailPicture inManagedObjectContext:context];
        category.thumb = thumb;
    }
}


- (void)setExistedObject:(SystemEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context {
    [super setExistedObject:object withRemoteObject:remoteObj inManagedObjectContext:context];
    NSAssert([object isKindOfClass:[Thumbnail class]], @"Type casting is wrong");
    EventCategory * category = (EventCategory *)object;
    
    // thumb
    PFObject * thumbnailPicture = remoteObj[PF_PLACE_THUMB];
    if (thumbnailPicture.updatedAt ) {
        Thumbnail * thumb = category.thumb;
        if (thumb) {
            if ([thumbnailPicture.updatedAt compare:thumb.updateTime] == NSOrderedDescending) {
                [[ThumbnailRemoteUtil sharedUtil] setExistedObject:category.thumb withRemoteObject:thumbnailPicture inManagedObjectContext:context];
            }
        }
        else {
            thumb = [Thumbnail createEntity:self.managedObjectContext];
            [[ThumbnailRemoteUtil sharedUtil] setExistedObject:thumb withRemoteObject:thumbnailPicture inManagedObjectContext:context];
        }
        category.thumb = thumb;
    }
}



@end
