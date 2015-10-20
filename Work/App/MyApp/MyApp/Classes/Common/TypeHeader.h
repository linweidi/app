//
//  TypeHeader.h
//  MyApp
//
//  Created by Linwei Ding on 10/14/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#ifndef MyApp_TypeHeader_h
#define MyApp_TypeHeader_h

typedef void (^LOCAL_BOOL_BLOCK)(BOOL succeeded, NSError * error);

typedef void (^LOCAL_ARRAY_BLOCK)(NSArray * objects, NSError * error);

typedef void (^LOCAL_DATA_BLOCK)(NSData * data, NSError * error);

#endif
