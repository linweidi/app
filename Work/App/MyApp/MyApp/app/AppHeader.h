//
//  AppHeader.h
//  MyApp
//
//  Created by Linwei Ding on 9/30/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#ifndef MyApp_AppHeader_h
#define MyApp_AppHeader_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "AppConstant.h"
#import "DataModelHeader.h"

#import "RemoteFile.h"

#import "UserManager.h"


typedef void (^REMOTE_BOOL_BLOCK)(BOOL succeeded, NSError * error);

typedef void (^REMOTE_OBJECT_BLOCK)(BOOL succeeded, NSError * error, PFObject * object);

typedef void (^REMOTE_ARRAY_BLOCK)(NSArray * objects, NSError * error);

typedef void (^REMOTE_DATA_BLOCK)(NSData * data, NSError * error);

typedef PFObject RemoteObject;

typedef PFUser RemoteUser;

#endif
