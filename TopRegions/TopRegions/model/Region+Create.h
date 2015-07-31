//
//  Region+Create.h
//  TopRegions
//
//  Created by Linwei Ding on 7/30/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "Region.h"

@interface Region (Create)
+ (Region *)regionWithName:(NSString *)name
                inManagedObjectContext:(NSManagedObjectContext *)context;

@end
