//
//  SystemEntity+CoreDataProperties.h
//  MyApp
//
//  Created by Linwei Ding on 11/28/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SystemEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface SystemEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *systemID;
@property (nullable, nonatomic, retain) NSString *versionID;

@end

NS_ASSUME_NONNULL_END
