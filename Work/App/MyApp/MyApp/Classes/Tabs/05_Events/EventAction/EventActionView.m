//
//  EventActionView.m
//  MyApp
//
//  Created by Linwei Ding on 12/14/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "EventActionView.h"

@interface EventActionView ()

@property (strong, nonatomic) NSString * eventID;

@end

@implementation EventActionView

- (instancetype) initWithEventID: (NSString *) eventID {
    self = [super init];
    if (self) {
        self.eventID = eventID;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSMutableArray * rightBarButtons = [[NSMutableArray alloc] init];
    
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(actionDoneButton)];
    
    
    
    [rightBarButtons addObject: doneButton];
    // add switch view button
    self.navigationItem.rightBarButtonItems = rightBarButtons;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) actionDoneButton {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
