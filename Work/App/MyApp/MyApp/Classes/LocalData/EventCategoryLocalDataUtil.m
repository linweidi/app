//
//  EventCategoryLocalDataUtil.m
//  MyApp
//
//  Created by Linwei Ding on 11/20/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//
#import "Thumbnail+Util.h"
#import "EventCategory+Util.h"
#import "EventCategoryLocalDataUtil.h"


#undef LOCAL_DATA_CLASS_TYPE
#define LOCAL_DATA_CLASS_TYPE EventCategory


@implementation EventCategoryLocalDataUtil


+ (EventCategoryLocalDataUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static EventCategoryLocalDataUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_EVENT_CATEGORY_CLASS_NAME;
        
        sharedObject.index = LOCAL_DATA_EVENT_CATEGORY_INDEX;
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
    
    
    LOCAL_DATA_CLASS_TYPE * category = (LOCAL_DATA_CLASS_TYPE *)object;
    
    category.childCount = dict[PF_EVENT_CATEGORY_CHILD_COUNT];
    category.childItems = dict[PF_EVENT_CATEGORY_CHILD_ITEMS];
    category.level = dict[PF_EVENT_CATEGORY_LEVEL];
    category.localID = dict[PF_EVENT_CATEGORY_LOCALID];
    category.name = dict[PF_EVENT_CATEGORY_NAME];
    category.notes = dict[PF_EVENT_CATEGORY_NOTES];
    category.parentItemCount = dict[PF_EVENT_CATEGORY_PARENT_COUNT];
    category.parentItems = dict[PF_EVENT_CATEGORY_PARENT_ITEMS];
    category.relatedItemCount = dict[PF_EVENT_CATEGORY_RELATED_COUNT];
    category.relatedItems = dict[PF_EVENT_CATEGORY_RELATED_ITEMS];
    category.subseqItemCount = dict[PF_EVENT_CATEGORY_SUBSEQ_COUNT];
    category.subseqItems = dict[PF_EVENT_CATEGORY_SUBSEQ_ITEMS];
    
    if (dict[PF_EVENT_CATEGORY_THUMBNAIL]) {
        Thumbnail * thumb = [Thumbnail fetchEntityWithID:dict[PF_EVENT_CATEGORY_THUMBNAIL] inManagedObjectContext:self.managedObjectContext];
        category.thumb = thumb;
    }


    
}

@end
