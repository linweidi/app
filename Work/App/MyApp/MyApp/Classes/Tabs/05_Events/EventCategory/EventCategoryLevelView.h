//
//  EventCategoryLevelView.h
//  MyApp
//
//  Created by Linwei Ding on 11/13/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

//#import "EventCategoryTableView.h"
#import <UIKit/UIKit.h>
@class EventCategory;


@interface EventCategoryLevelView : UITableViewController <SelectEventCategoryDelegate>

- (void)didSelectEventCategory:(EventCategory *)category level:(int)level;

@property (strong, nonatomic) id <SelectEventCategoryDelegate> delegate;

@end
