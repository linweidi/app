//
//  ThumbnailManager.m
//  MyApp
//
//  Created by Linwei Ding on 9/30/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//
#import "Thumbnail+Util.h"
#import "ThumbnailManager.h"

@interface ThumbnailManager()
@property (strong, nonatomic) NSMutableDictionary * allThumbnails;

@end

@implementation ThumbnailManager

+ (ThumbnailManager *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static ThumbnailManager *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.allThumbnails = [[NSMutableDictionary alloc] init];
        
    });
    return sharedObject;
}

- (void) addThumbnail:(Thumbnail *)thumbnail  {
    NSString * thumbName = thumbnail.name  ;
    
    self.allThumbnails[thumbName] = thumbnail;
}

- (BOOL) removeThumbnail: (NSString *) thumbName {
    BOOL ret = NO;
    if ([self exists:thumbName]) {
        [self.allThumbnails removeObjectForKey:thumbName];
        ret = YES;
    }
    
    return ret;
    
}

- (BOOL) exists: (NSString *) thumbName {
    return [self.allThumbnails objectForKey:thumbName]!=nil;
}

- (Thumbnail *) getThumbnail: (NSString *) thumbName {
    return [self.allThumbnails objectForKey:thumbName];
}

- (Thumbnail *) extractThumbnail:(NSString *)thumbName {
    Thumbnail * thumbnail = nil;
    if ([self exists:thumbName]) {
        thumbnail = [self getThumbnail:thumbName];
        [self removeThumbnail:thumbName];
    }
    
    return thumbnail;
}


@end
