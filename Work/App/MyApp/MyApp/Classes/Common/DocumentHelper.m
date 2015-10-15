//
//  DocumentHelper.m
//  MyApp
//
//  Created by Linwei Ding on 10/14/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//
#import "AppConstant.h"
#import "DocumentHelper.h"

@implementation DocumentHelper

+ (DocumentHelper *)sharedManager {
    static dispatch_once_t predicate = 0;
    static DocumentHelper *sharedObject;
    
    dispatch_once(&predicate, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}

- (BOOL) createDatabaseDocument {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL * documentsDirectory = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject	];
    NSString * nameDBDoc = @"RegionDatabase";
    
    self.documentPath = [documentsDirectory URLByAppendingPathComponent:nameDBDoc isDirectory:NO];
    NSAssert(self.documentPath, @"the database path does not exist at all!");
    
    self.document = [[UIManagedDocument alloc] initWithFileURL:self.documentPath];
    
    NSAssert(self.document , @"the managed document does not exist at all!");
    
    BOOL fileExists = [fileManager fileExistsAtPath:[self.documentPath path] isDirectory:NO];
    //fileExists = [fileManager fileExistsAtPath:[documentsDirectory path]];
    //fileExists = [fileManager fileExistsAtPath:[documentPath path]];
    NSLog(@"load document completed");
    
    return fileExists;
}

- (NSManagedObjectContext *)createMainQueueManagedObjectContext:(void (^)(BOOL succeeded))completionHandler{
    
    __block NSManagedObjectContext * context = nil;
    
    BOOL fileExists = [self createDatabaseDocument];
    
    if (fileExists) {
        if (self.document.documentState == UIDocumentStateNormal) {
            if (!self.managedObjectContext) {
                context = self.document.managedObjectContext;
                self.managedObjectContext = context;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(YES);
                //[self startFlickrFetch];
            });
        }
        else if (self.document.documentState == UIDocumentStateClosed ) {
            [self.document  openWithCompletionHandler:^(BOOL success) {
                if (success) {
                    context = self.document.managedObjectContext;
                    self.managedObjectContext = context;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completionHandler(YES);
                        //[self startFlickrFetch];
                    });
                }
                else {
                    completionHandler(success);
                }
            }];
        }
        else {
            // do something here for conflct, saveError, editDisabled
            NSAssert(NO, @"document open fails");
            completionHandler(NO);
        }
        
    }
    else {
        // not exist, then create one
        NSAssert(self.documentPath, @"document path does not exist");
        [self.document  saveToURL:self.documentPath forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if (success) {
                context = self.document.managedObjectContext;
                self.managedObjectContext = context;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    //[self startFlickrFetch];
                    completionHandler(success);
                });
            }
            else {
                completionHandler(success);
            }
        }];
    }
    
    return context;
}

#pragma mark -- set context
- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    _managedObjectContext = managedObjectContext;
    
    // every time the context changes, we'll restart our timer
    // so kill (invalidate) the current one
    // (we didn't get to this line of code in lecture, sorry!)
    /*
    [self.flickrForegroundFetchTimer invalidate];
    self.flickrForegroundFetchTimer = nil;
    
    if (self.photoDatabaseContext)
    {
        // this timer will fire only when we are in the foreground
        self.flickrForegroundFetchTimer = [NSTimer scheduledTimerWithTimeInterval:FOREGROUND_FLICKR_FETCH_INTERVAL
                                                                           target:self
                                                                         selector:@selector(startFlickrFetch:)
                                                                         userInfo:nil
                                                                          repeats:YES];
    }
    */
    
    // let everyone who might be interested know this context is available
    // this happens very early in the running of our application
    // it would make NO SENSE to listen to this radio station in a View Controller that was segued to, for example
    // (but that's okay because a segued-to View Controller would presumably be "prepared" by being given a context to work in)
    NSDictionary *userInfo = self.managedObjectContext ? @{ MainDatabaseAvailableContext : self.managedObjectContext } : nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:MainDatabaseAvailableNotification object:self userInfo:userInfo];
}


@end
