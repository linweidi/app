//
//  TopRegionsAppDelegate+MOC.m
//  TopRegions
//
//  Created by Linwei Ding on 7/30/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "TopRegionsAppDelegate+MOC.h"

@implementation TopRegionsAppDelegate (MOC)

- (NSManagedObjectContext *)createMainQueueManagedObjectContext {
    
    __block NSManagedObjectContext * context = nil;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL * documentsDirectory = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject	];
    NSString * nameDBDoc = @"RegionDatabase";
    NSURL * documentPath = [documentsDirectory URLByAppendingPathComponent:nameDBDoc isDirectory:NO];
    NSAssert(documentPath, @"the database path does not exist at all!");
    
    self.document = [[UIManagedDocument alloc] initWithFileURL:documentPath];
    
    NSAssert(self.document , @"the managed document does not exist at all!");
    BOOL fileExists = [fileManager fileExistsAtPath:[documentPath path] isDirectory:NO];
    fileExists = [fileManager fileExistsAtPath:[documentsDirectory path]];
    NSAssert(self.document , @"the managed document does not exist at all!");
     fileExists = [fileManager fileExistsAtPath:[documentPath path]];
    
    if (fileExists) {
        if (self.document.documentState == UIDocumentStateNormal) {
            [self startFlickrFetch];
        }
        else if (self.document.documentState == UIDocumentStateClosed ) {
            [self.document  openWithCompletionHandler:^(BOOL success) {
                if (success) {
                    context = self.document.managedObjectContext;
                    self.photoDatabaseContext = context;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self startFlickrFetch];
                    });
                }
            }];
        }

    }
    else {
        // not exist, then create one
        [self.document  saveToURL:documentPath forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if (success) {
                context = self.document.managedObjectContext;
                self.photoDatabaseContext = context;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self startFlickrFetch];
                });
            }
        }];
    }
    
    return context;
}


@end
