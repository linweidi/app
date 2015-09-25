//
//  Thumbnail+Util.h
//  MyApp
//
//  Created by Linwei Ding on 9/23/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//

#import "Thumbnail.h"

@interface Thumbnail (Util)

+ (Thumbnail *) thumbnailEntityWithPFUser:(PFFile *)thumbFile withUser:(User *)user inManagedObjectContext: (NSManagedObjectContext *)context;


+ (Thumbnail *) thumbnailEntity:(NSString *)name inManagedObjectContext: (NSManagedObjectContext *)context ;

@end
