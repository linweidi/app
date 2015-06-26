//
//  TextHistoryViewController.m
//  TryThisGame
//
//  Created by Linwei Ding on 6/20/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "TextHistoryViewController.h"

@interface TextHistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation TextHistoryViewController

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
    // Do any additional setup after loading the view.
    
    self.textView.text = [self.matchHistory componentsJoinedByString:@"\n"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
