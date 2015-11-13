//
//  BaseCalendarViewController.h
//  MyApp
//
//  Created by Linwei Ding on 10/14/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CoreDataViewController.h"

@interface BaseCalendarViewController : CoreDataViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
