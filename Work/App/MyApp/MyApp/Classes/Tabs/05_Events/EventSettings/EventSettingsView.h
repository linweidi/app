//
//  EventSettingsView.h
//  MyApp
//
//  Created by Linwei Ding on 11/12/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import "CoreDataTableViewController.h"

@class Event;
@interface EventSettingsView : CoreDataTableViewController

- (instancetype)initWithEvent:(Event *)event;


@property (strong, nonatomic) Event * event;
@end
