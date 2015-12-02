//
//  VideoLocalDataUtility.m
//  MyApp
//
//  Created by Linwei Ding on 11/8/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
#import "Video+Util.h"
#import "VideoLocalDataUtil.h"

#undef LOCAL_DATA_CLASS_TYPE
#define LOCAL_DATA_CLASS_TYPE Video

@implementation VideoLocalDataUtil

+ (VideoLocalDataUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static VideoLocalDataUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_VIDEO_CLASS_NAME;
        
        sharedObject.index = LOCAL_DATA_VIDEO_INDEX;
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
    
    
    LOCAL_DATA_CLASS_TYPE * video = (LOCAL_DATA_CLASS_TYPE *)object;
    
    video.name = dict[PF_VIDEO_NAME];
    video.url = dict[PF_VIDEO_URL];
    video.fileName = dict[PF_VIDEO_NAME];
//    NSDictionary * filePF = dict[PF_VIDEO_FILE];
//    video.fileName = filePF[@"name"];
//    video.url = filePF[@"url"];
    
}

@end
