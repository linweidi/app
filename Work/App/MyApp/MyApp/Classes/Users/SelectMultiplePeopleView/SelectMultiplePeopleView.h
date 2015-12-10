//
//  SelectMultiplePeopleView.h
//  MyApp
//
//  Created by Linwei Ding on 10/1/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import "SelectPeopleView.h"

@class User;
@protocol SelectMultiplePeopleDelegate

@optional
- (void)didSelectMultipleUsers:(NSMutableArray *)users;
- (void)didSelectMultipleUserIDs:(NSMutableArray *)userIDs;
@end

@interface SelectMultiplePeopleView : SelectPeopleView

@property (nonatomic, weak) id<SelectMultiplePeopleDelegate>delegate;

@end
