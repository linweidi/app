//
//  TopRegionsAppDelegate+MOC.h
//  TopRegions
//
//  Created by Linwei Ding on 7/30/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "TopRegionsAppDelegate.h"

@interface TopRegionsAppDelegate (MOC)
- (NSManagedObjectContext *)createMainQueueManagedObjectContext;


@end
