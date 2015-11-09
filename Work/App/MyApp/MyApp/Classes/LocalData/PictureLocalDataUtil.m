//
//  PictureLocalDataUtility.m
//  MyApp
//
//  Created by Linwei Ding on 11/8/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
#import "Picture+Util.h"
#import "PictureLocalDataUtil.h"

#undef LOCAL_DATA_CLASS_TYPE
#define LOCAL_DATA_CLASS_TYPE Picture

@implementation PictureLocalDataUtil

+ (PictureLocalDataUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static PictureLocalDataUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_PICTURE_CLASS_NAME;
        
        sharedObject.index = LOCAL_DATA_PICTURE_INDEX;
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
    
    
    LOCAL_DATA_CLASS_TYPE * picture = (LOCAL_DATA_CLASS_TYPE *)object;
    
    picture.name = dict[PF_PICTURE_NAME];
    picture.url = dict[PF_PICTURE_URL];
    
    NSDictionary * filePF = dict[PF_PICTURE_FILE];
    picture.fileName = filePF[@"name"];
    picture.url = filePF[@"url"];
    
}

@end
