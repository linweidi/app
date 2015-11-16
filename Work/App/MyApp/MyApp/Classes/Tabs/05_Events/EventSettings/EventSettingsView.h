//
//  EventSettingsView.h
//  MyApp
//
//  Created by Linwei Ding on 11/12/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleTextfieldViewController.h"

@class Event;
@interface EventSettingsView : UITableViewController <SingleTextfieldVCDelegate>

- (instancetype)initWithEvent:(Event *)event;


@property (strong, nonatomic) Event * event;

- (void)updateTextfield:(NSString *)text indexPath:(NSIndexPath *)indexPath;
//@property (strong, nonatomic) NSString * text;

@end
