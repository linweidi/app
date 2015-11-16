//
//  DocumentHelper.h
//  MyApp
//
//  Created by Linwei Ding on 10/14/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface DocumentHelper : NSObject

+ (DocumentHelper *)sharedManager ;

- (void)createMainQueueManagedObjectContext:(void (^)(BOOL succeeded))completionHandler;

@property (strong, nonatomic) UIManagedDocument *document;
@property  (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSURL * documentPath;

@end
