/**
 * Copyright (c) 2015-present, Parse, LLC.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "ParseStarterProjectViewController.h"

#import <Parse/Parse.h>

@implementation ParseStarterProjectViewController

#pragma mark -
#pragma mark UIViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    NSLog(@"before save: the testObject's globalID is:%@", testObject.objectId);
    testObject[@"date"] = [NSDate date];
    NSLog(@"before save: the testObject's date is:%@", testObject[@"date"]);
    [testObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"After save: the testObject's date is:%@", testObject.createdAt);
            NSLog(@"After save: the testObject's globalID is:%@", testObject.objectId);
        }
    }];
    
    PFObject *testObject2 = [PFObject objectWithClassName:@"TestObject"];
    testObject2.objectId = @"IxtGMprwCB";
    testObject2[@"foo"] = @"newBar3";
    testObject2[@"createdAt"] = [NSDate date];
    NSLog(@"before save: the testObject2's current date is:%@", [NSDate date]);
    NSLog(@"before save: the testObject2's date is:%@", testObject2[@"createdAt"]);
    [testObject2 saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"After save: the testObject2's date is:%@", testObject2.createdAt);
            //NSLog(@"After save: the testObject's globalID is:%@", testObject.objectId);
        }
    }];
    
    PFObject *testObject3 = [PFObject objectWithClassName:@"Event"];
    testObject3[@"foo"] = @"bar";
    PFObject * testObject4 = [PFObject objectWithClassName:@"Alert"];
    testObject3[@"Alert"] = testObject4;
    [testObject3 saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"After save: the event's globalID is:%@", testObject3.objectId);
            NSLog(@"After save: the event's globalID is:%@", testObject4.objectId);
        }

    }];
    
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
