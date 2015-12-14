//
//  EventCategoryLevelView.h
//  MyApp
//
//  Created by Linwei Ding on 11/13/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "EventCategoryListView.h"
#import <UIKit/UIKit.h>
@class EventCategory;

@protocol SelectEventCategoryDelegate

- (void)didSelectEventCategory:(EventCategory *)category;

@end

@interface EventCategoryLevelView : UITableViewController <SelectEventCategoryLevelDelegate>



@property (strong, nonatomic) id <SelectEventCategoryDelegate> delegate;

@end
