//
//  Alert+CoreDataProperties.h
//  MyApp
//
//  Created by Linwei Ding on 11/8/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Alert.h"

NS_ASSUME_NONNULL_BEGIN

@interface Alert (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *time;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) Event *event;

@end

NS_ASSUME_NONNULL_END
