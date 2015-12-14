//
//  BaseLocalUtility.h
//  MyApp
//
//  Created by Linwei Ding on 11/7/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
#import "AppHeader.h"
#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

@interface BaseLocalDataUtil : NSObject

@property (strong, nonatomic) NSString * className;

@property (nonatomic) int dayRange;

@property (nonatomic) int index;

@property (strong, nonatomic) NSManagedObjectContext * managedObjectContext;

@property (strong, nonatomic) NSArray * keys;

#pragma mark -- Base Methods
- (NSDate *) getRandomPastDate ;

- (NSString *) getUniqueGlobalID ;

- (NSArray *)loadData ;

- (NSArray *)loadDataRandom: (NSInteger) count ;

- (void) setCommonValues:(id) object;

- (void) setObjectEntity:(NSManagedObject *)object1 byObject:(NSManagedObject *)object2;

- (NSMutableSet *) createSetFromStringArray:(NSArray *)collections ;

#pragma mark -- Inheritance Methods
- (void) setRandomValues: (id) object data:(NSDictionary *)dict;

- (NSArray *)constructDataFromDict:(NSDictionary *)dict;


@end
