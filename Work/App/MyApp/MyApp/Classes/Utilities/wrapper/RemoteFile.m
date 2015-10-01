//
//  RemoteFile.m
//  MyApp
//
//  Created by Linwei Ding on 9/30/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import <Parse/Parse.h>
#import "AppHeader.h"
#import "RemoteFile.h"


@interface RemoteFile()
@property (strong, readwrite, nonatomic) PFFile * file;

@end

@implementation RemoteFile

+ (RemoteFile *) fileWithName:(NSString *)name url:(NSString *)url {
    RemoteFile * remoteFile = [[RemoteFile alloc] init];
    remoteFile.file = [PFFile fileWithName:name contentsAtPath:url];
    
    return remoteFile;
}

+ (RemoteFile *) fileWithName:(NSString *)name data:(NSData *)data{
    RemoteFile * remoteFile = [[RemoteFile alloc] init];
    remoteFile.file = [PFFile fileWithName:name  data:data];
    
    return remoteFile;
}


- (void) getDataAsync:(REMOTE_DATA_BLOCK)block {
    [self.file getDataInBackgroundWithBlock:block];
}

- (void) saveDataAsync: (REMOTE_BOOL_BLOCK)block {
    [self.file saveInBackgroundWithBlock:block];
}

- (NSString *)name {
    return self.file.name;
}

- (NSString *)url {
    return self.file.url;
}

@end
