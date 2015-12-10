//
//  SelectMultiplePeopleView.m
//  MyApp
//
//  Created by Linwei Ding on 10/1/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import "AppHeader.h"
#import "UserManager.h"
#import "User+Util.h"
#import "People+Util.h"
#import "SelectMultiplePeopleView.h"

@interface SelectMultiplePeopleView ()

@end

@implementation SelectMultiplePeopleView

@synthesize delegate;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Select Multiple";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self
                                                                                           action:@selector(actionDone)];
    NSParameterAssert(self.delegate);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)actionDone
{
	if ([self.selection count] == 0) {
        [ProgressHUD showError:@"Please select some users."];
        return;
    }

//	[self dismissViewControllerAnimated:YES completion:^{
//		if (delegate != nil)
//		{
//			NSMutableArray *selectedUsers = [[NSMutableArray alloc] init];
//            
//            for (NSString * userID in self.selection) {
//                User * user = [[UserManager sharedUtil] getUser:userID];
//                NSAssert(user, @"user does not exist");
//                [selectedUsers addObject:user];
//            }
//            [delegate didSelectMultipleUsers:selectedUsers];
//			
//		}
//	}];
    
    if (delegate != nil)
    {
//        NSMutableArray *selectedUsers = [[NSMutableArray alloc] init];
//        
//        for (NSString * userID in self.selection) {
//            User * user = [[UserManager sharedUtil] getUser:userID];
//            NSAssert(user, @"user does not exist");
//            [selectedUsers addObject:user];
//        }
//        [delegate didSelectMultipleUsers:selectedUsers];
        
        [delegate didSelectMultipleUserIDs:self.selection];
        
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
