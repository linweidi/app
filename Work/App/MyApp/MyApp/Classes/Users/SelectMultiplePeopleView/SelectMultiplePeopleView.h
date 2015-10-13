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
//-------------------------------------------------------------------------------------------------------------------------------------------------

- (void)didSelectMultipleUsers:(NSMutableArray *)users;

@end

@interface SelectMultiplePeopleView : SelectPeopleView

@property (nonatomic, assign) id<SelectMultiplePeopleDelegate>delegate;

@end
