//
//  ThumbnailImage+Load.h
//  TopRegions
//
//  Created by Linwei Ding on 7/30/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "ThumbnailImage.h"

@interface ThumbnailImage (Load)
+ (ThumbnailImage *)thumbnailWithURL:(NSString *)imageURL
             inManagedObjectContext:(NSManagedObjectContext *)context;
@end
