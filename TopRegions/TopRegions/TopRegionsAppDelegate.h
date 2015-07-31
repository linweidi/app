//
//  PhotomaniaAppDelegate.h
//  Photomania
//
//  Created by CS193p Instructor.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopRegionsAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSManagedObjectContext *photoDatabaseContext;

@property (nonatomic, strong) UIManagedDocument * document;

- (void)startFlickrFetch;
@end
