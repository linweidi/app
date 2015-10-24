//
//  RemoteHeader.h
//  MyApp
//
//  Created by Linwei Ding on 10/12/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//

#ifndef RemoteHeader_h
#define RemoteHeader_h

#import <Parse/Parse.h>
#import <Foundation/Foundation.h>


typedef PFObject RemoteObject;

typedef PFUser RemoteUser;

typedef PFFile RemoteFile;

typedef void (^REMOTE_BOOL_BLOCK)(BOOL succeeded, NSError * error);

typedef void (^REMOTE_RT_OBJECT_BLOCK)(RemoteObject object, NSError * error);

typedef void (^REMOTE_OBJECT_BLOCK)(id object, NSError * error);

typedef void (^REMOTE_ARRAY_BLOCK)(NSArray * objects, NSError * error);

typedef void (^REMOTE_DATA_BLOCK)(NSData * data, NSError * error);


#endif /* RemoteHeader_h */
