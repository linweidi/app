//
//  ThumbnailManager.h
//  MyApp
//
//  Created by Linwei Ding on 9/30/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Thumbnail;

@interface ThumbnailManager : NSObject
+ (ThumbnailManager *)sharedUtil;

- (void) addThumbnail:(Thumbnail *)thumbnail;

- (BOOL) removeThumbnail: (NSString *) thumbName;

- (BOOL) exists: (NSString *) thumbName;

- (Thumbnail *) getThumbnail: (NSString *) thumbName;

- (Thumbnail *) extractThumbnail:(NSString *)thumbName;

@end
