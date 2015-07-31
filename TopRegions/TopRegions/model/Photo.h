//
//  Photo.h
//  TopRegions
//
//  Created by Linwei Ding on 7/31/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photographer, RecentPhoto, Region;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSString * thumbnail;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * unique;
@property (nonatomic, retain) Region *region;
@property (nonatomic, retain) Photographer *whoTook;
@property (nonatomic, retain) NSSet *recentPhotos;
@end

@interface Photo (CoreDataGeneratedAccessors)

- (void)addRecentPhotosObject:(RecentPhoto *)value;
- (void)removeRecentPhotosObject:(RecentPhoto *)value;
- (void)addRecentPhotos:(NSSet *)values;
- (void)removeRecentPhotos:(NSSet *)values;

@end
