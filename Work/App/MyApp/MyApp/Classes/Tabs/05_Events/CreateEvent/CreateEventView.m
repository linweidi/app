//
//  CreateEventView.m
//  MyApp
//
//  Created by Linwei Ding on 11/10/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import "CreateEventView.h"

@interface CreateEventView ()

@end

@implementation CreateEventView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [super viewDidLoad];
	self.title = @"Create Group";
	//---------------------------------------------------------------------------------------------------------------------------------------------
//	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self
//																						  action:@selector(actionCancel)];
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self
//																						   action:@selector(actionDone)];
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
//	[self.tableView addGestureRecognizer:gestureRecognizer];
//	gestureRecognizer.cancelsTouchesInView = NO;
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	self.tableView.tableHeaderView = viewHeader;
//	self.tableView.tableFooterView = [[UIView alloc] init];
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	//users = [[NSMutableArray alloc] init];
//	selection = [[NSMutableArray alloc] init];
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	[self loadPeople];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
