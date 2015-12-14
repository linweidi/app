//
//  EventCategoryTableView.h
//  MyApp
//
//  Created by Linwei Ding on 11/13/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "CoreDataTableViewController.h"

@class EventCategory;

@protocol SelectEventCategoryLevelDelegate

- (void)didSelectEventCategoryLevel:(EventCategory *)category level:(int)level;

@end


@interface EventCategoryListView : CoreDataTableViewController

@property (nonatomic) int level;
@property (strong, nonatomic) NSString * parentID;
@property (strong, nonatomic) id <SelectEventCategoryLevelDelegate> delegate;
@end
