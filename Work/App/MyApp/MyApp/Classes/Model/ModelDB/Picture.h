//
//  Picture.h
//  MyApp
//
//  Created by Linwei Ding on 9/30/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "EntityObject.h"


@interface Picture : EntityObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * url;

@end
