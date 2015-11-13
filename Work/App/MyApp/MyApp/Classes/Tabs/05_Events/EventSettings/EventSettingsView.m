//
//  EventSettingsView.m
//  MyApp
//
//  Created by Linwei Ding on 11/12/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//
#import "Event+Util.h"
#import "EventSettingsView.h"

@interface EventSettingsView ()

@end

@implementation EventSettingsView



- (instancetype)initWithEvent:(Event *)event
{
    self = [super init];
    if (self) {
        self.event = event;
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
