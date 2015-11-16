//
//  PlaceListView.h
//  MyApp
//
//  Created by Linwei Ding on 11/14/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "CoreDataTableViewController.h"

@class EventCategory;
@interface PlaceTableView : CoreDataTableViewController

@property (strong, nonatomic) EventCategory * category;

@end
