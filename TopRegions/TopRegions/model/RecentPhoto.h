//
//  RecentPhoto.h
//  TopRegions
//
//  Created by Linwei Ding on 7/31/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photo;

@interface RecentPhoto : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) Photo *photo;

@end
