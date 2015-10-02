//
//  SelectSinglePeopleView.h
//  MyApp
//
//  Created by Linwei Ding on 10/1/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import "SelectPeopleView.h"

@class User;
@protocol SelectSinglePeopleDelegate
//-------------------------------------------------------------------------------------------------------------------------------------------------

- (void)didSelectSinglePeople:(User *)user;

@end

@interface SelectSinglePeopleView : SelectPeopleView

@property (nonatomic, assign) id<SelectSinglePeopleDelegate>delegate;

@end
