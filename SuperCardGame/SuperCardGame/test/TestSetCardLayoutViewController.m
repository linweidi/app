//
//  TestSetCardLayoutViewController.m
//  SuperCardGame
//
//  Created by Linwei Ding on 6/26/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//
#import "SetCardMatchingGame.h"
#import "TableView.h"
#import "SetCardView.h"
#import "SetCard.h"
#import "TestSetCardLayoutViewController.h"

@interface TestSetCardLayoutViewController ()

@end

@implementation TestSetCardLayoutViewController

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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Gestures



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -- Others
- (UIView *) createView:(CGRect)rect {
    return [[SetCardView alloc]initWithFrame:rect];
}
- (CardMatchingGame *) createGame {
    return [[SetCardMatchingGame alloc] init];
}

#pragma mark -- Update UI
- (void) updateCardView:(UIView *)view forCard:(Card *)card {
    SetCardView *setCardView = nil;
    SetCard * setCard  = nil;
    if ([view isKindOfClass:[SetCardView class]]) {
        setCardView = (SetCardView * )view;
    }
    else {
        NSAssert(NO, @"view is not playing card view");
    }
    if ([card isKindOfClass:[SetCard class]]) {
        setCard = (SetCard *)card;
    }
    if (card.isMatched) {
//        setCardView.suit = setCard.suit;
//        setCardView.rank = setCard.rank;
//        setCardView.faceUp = YES;
    }
    else {
        if (card.isChosen) {
//            setCardView.suit = setCard.suit;
//            setCardView.rank = setCard.rank;
//            setCardView.faceUp = YES;
        }
        else {
//            setCardView.suit = nil;
//            setCardView.rank = 0;
//            setCardView.faceUp = NO;
        }
    }
    
}
@end
