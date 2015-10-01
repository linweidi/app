//
//  RemoteFile.h
//  MyApp
//
//  Created by Linwei Ding on 9/30/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemoteFile : NSObject

+ (RemoteFile *) fileWithName:(NSString *)name url:(NSString *)url;

+ (RemoteFile *) fileWithName:(NSString *)name data:(NSData *)data;

- (void) getDataAsync:(REMOTE_DATA_BLOCK)block;

- (void) saveDataAsync: (REMOTE_BOOL_BLOCK)block;

@property (strong, readonly, nonatomic) PFFile * file;

@property (strong, readonly, nonatomic) NSString * name;
@property (strong, readonly, nonatomic) NSString * url;
@end
