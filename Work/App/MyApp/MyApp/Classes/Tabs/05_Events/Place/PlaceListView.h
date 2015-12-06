//
//  PlaceListView.h
//  MyApp
//
//  Created by Linwei Ding on 12/6/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"

@class EventCategory;
@interface PlaceListView : BaseTableViewController

@property (strong, nonatomic) EventCategory * eventCategory;
@end
