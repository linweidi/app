//
//  SelectSinglePeopleView.m
//  MyApp
//
//  Created by Linwei Ding on 10/1/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import "AppHeader.h"
#import "UserManager.h"
#import "User+Util.h"
#import "People+Util.h"
#import "SelectSinglePeopleView.h"

@interface SelectSinglePeopleView ()

@end

@implementation SelectSinglePeopleView

@synthesize delegate;


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
    
    self.title = @"Select Single";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    People * people= [self.fetchedResultsController objectAtIndexPath:indexPath];
    User * contact = people.contact;
//    
//    if ([selection count] == 1) {
//        NSString * userID = [selection firstObject];
//        contact = [UserManager ]
//    }
    
	[self dismissViewControllerAnimated:YES completion:^{
		if (delegate != nil) {
            [delegate didSelectSinglePeople:contact];
        }
	}];
}
@end
