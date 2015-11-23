//
//  ThumbnailLocalDataUtility.m
//  MyApp
//
//  Created by Linwei Ding on 11/8/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
#import "Thumbnail+Util.h"
#import "ThumbnailLocalDataUtil.h"

#undef LOCAL_DATA_CLASS_TYPE
#define LOCAL_DATA_CLASS_TYPE Thumbnail

@implementation ThumbnailLocalDataUtil

+ (ThumbnailLocalDataUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static ThumbnailLocalDataUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_THUMBNAIL_CLASS_NAME;
        
        sharedObject.index = LOCAL_DATA_THUMBNAIL_INDEX;
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
    
    
    LOCAL_DATA_CLASS_TYPE * thumb = (LOCAL_DATA_CLASS_TYPE *)object;
    
    thumb.name = dict[PF_THUMBNAIL_NAME];
    //    PFFile * filePF = remoteObj[PF_THUMBNAIL_FILE];
    //    thumb.fileName = filePF.name;
    //    thumb.globalID = remoteObj.objectId;
    //    thumb.createTime = remoteObj.createdAt;
    //    thumb.updateTime = remoteObj.updatedAt;
    thumb.url = dict[PF_THUMBNAIL_URL];
    
    NSDictionary * filePF = dict[PF_THUMBNAIL_FILE];
    thumb.fileName = filePF[@"name"];
    thumb.url = filePF[@"url"];

}

@end
