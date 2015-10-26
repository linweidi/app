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
    testObject.objectId = nil;
    [testObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"After save: the testObject's date is:%@", testObject.createdAt);
            NSLog(@"After save: the testObject's date is:%@", testObject[@"createAt"]);
            NSLog(@"After save: the testObject's date is:%@", testObject[@"createdAt"]);
            NSLog(@"After save: the testObject's date is:%@", testObject.updatedAt);
            NSLog(@"After save: the testObject's globalID is:%@", testObject.objectId);
        }
    }];
    
    PFObject *testObject2 = [PFObject objectWithClassName:@"TestObject"];
    testObject2.objectId = @"IxtGMprwCB";
    testObject2[@"foo"] = @"newBar4";
    //testObject2[@"createdAt"] = [NSDate date];
    NSLog(@"before save: the testObject2's current date is:%@", [NSDate date]);
    NSLog(@"before save: the testObject2's date is:%@", testObject2[@"createAt"]);
    [testObject2 saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"After save: the testObject2's date is:%@", testObject2[@"createAt"]);
            NSLog(@"After save: the testObject2's date is:%@", testObject2[@"updateAt"]);
            NSLog(@"After save: the testObject2's globalID is:%@", testObject2[@"objectId"]);
            
            NSLog(@"After save: the testObject2's date is:%@", testObject2.createdAt);
            NSLog(@"After save: the testObject2's date is:%@", testObject2.updatedAt);
            NSLog(@"After save: the testObject2's globalID is:%@", testObject2.objectId);
        }
    }];
    
    PFObject *testObject3 = [PFObject objectWithClassName:@"Event"];
    testObject3[@"foo"] = @"bar";
    PFObject * testObject4 = [PFObject objectWithClassName:@"Alert"];
    testObject3[@"Alert"] = testObject4;
    [testObject3 saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"After save: the testObject3 event's globalID is:%@", testObject3.objectId);
            NSLog(@"After save: the testObject4 event's globalID is:%@", testObject4.objectId);
            NSLog(@"After save: the testObject3 event's createAt is:%@", testObject3.createdAt);
            NSLog(@"After save: the testObject4 event's createAt is:%@", testObject4.createdAt);
            NSLog(@"After save: the testObject3 event's updateAt is:%@", testObject3.updatedAt);
            NSLog(@"After save: the testObject4 event's updateAt is:%@", testObject4.updatedAt);
            PFObject * testObject5 = [PFObject objectWithoutDataWithClassName:@"Event" objectId:testObject3.objectId];
            
            [testObject5 fetchInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
                if (!error) {
                    NSLog(@"testObject5's foo is %@", testObject5[@"foo"]);
                    NSLog(@"testObject5's alert is %@", testObject5[@"Alert"]);
                    
                    NSLog(@"PFObject5's foo is %@", object[@"foo"]);
                    NSLog(@"PFObject5's alert is %@", object[@"Alert"]);
                }
            }];
            
            //PFObject * testObject6 = [PFObject objectWithoutDataWithClassName:@"Event" objectId:testObject3.objectId];
            PFQuery * query = [PFQuery queryWithClassName:@"Event"];
            [query getObjectInBackgroundWithId:testObject3.objectId block:^(PFObject * _Nullable object, NSError * _Nullable error) {
                if (!error) {
                    //NSLog(@"testObject6's foo is %@", testObject6[@"foo"]);
                    //NSLog(@"testObject6's alert is %@", testObject6[@"Alert"]);
                    
                    NSLog(@"PFObject6's foo is %@", object[@"foo"]);
                    NSLog(@"PFObject6's alert is %@", object[@"Alert"]);
                }
            }];
        }

    }];
    
    /*
    PFObject *testObject6 = [PFObject objectWithClassName:@"Event"];
    testObject6[@"foo"] = @"bar";
    NSBundle * bundle = [NSBundle mainBundle];
    NSString * path = [bundle pathForResource:@"Default" ofType:@"png"];
    PFFile * file = [PFFile fileWithName:@"picture" data:[NSData dataWithContentsOfFile:path]];
    testObject6[@"File"] = file;
    [testObject6 saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"PFObject6's foo is %@", testObject6[@"foo"]);
            PFFile * outFile = testObject6[@"File"];
            NSLog(@"PFObject6's File's name is %@", outFile.name);
            NSLog(@"PFObject6's File's url is %@", outFile.url);
            //NSLog(@"PFObject6's File's data is %@", outFile.data);

        }
    }];
    NSLog(@"PFObject6's objectID is %@", testObject6.objectId);
    */
    
    __block NSString * oldURL = nil;
    __block NSString * oldName = nil;
    __block NSString * newURL = nil;
    __block NSString * newName = nil;
    //PFObject *testObject7 = [PFObject objectWithClassName:@"Event"];
    //testObject7.objectId = @"pdOZlkFuE2";
    //testObject2[@"foo"] = @"newBar4";
    PFQuery * query2 = [PFQuery queryWithClassName:@"Event"];
    //[query2 includeKey:@"File"];
    [query2 getObjectInBackgroundWithId:@"pdOZlkFuE2" block:^(PFObject * _Nullable object, NSError * _Nullable error) {
        if (!error) {
            //[object[@"File"]
            NSLog(@"PFObject7's foo is %@", object[@"foo"]);
            NSLog(@"PFObject7's File is %@", object[@"File"]);
            NSLog(@"PFObject7's File's name is %@", ((PFFile *)object[@"File"]).name);
            NSLog(@"PFObject7's File's url is %@", ((PFFile *)object[@"File"]).url);
            oldName = ((PFFile *)object[@"File"]).name;
            oldURL = ((PFFile *)object[@"File"]).url;
            NSBundle * bundle = [NSBundle mainBundle];
            NSString * path = [bundle pathForResource:@"Default" ofType:@"png"];
            //PFFile * file = [PFFile fileWithName:@"picture" data:[NSData dataWithContentsOfFile:path]];
            PFFile * newFile = [PFFile fileWithName:@"picture" data:[NSData dataWithContentsOfFile:path]];
            [newFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (!error) {
                    NSLog(@"PFObject7's File's new name is %@", ((PFFile *)object[@"File"]).name);
                    NSLog(@"PFObject7's File's new url is %@", ((PFFile *)object[@"File"]).url);
                    newName = ((PFFile *)object[@"File"]).name;
                    newURL = ((PFFile *)object[@"File"]).url;
                }
            }];
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
