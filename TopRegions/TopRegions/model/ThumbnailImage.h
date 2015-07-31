//
//  ThumbnailImage.h
//  TopRegions
//
//  Created by Linwei Ding on 7/31/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ThumbnailImage : NSManagedObject

@property (nonatomic, retain) NSData * data;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * imageURL;

@end
