//
//  CardGameViewController.m
//  Machismo
//
//  Created by Linwei Ding on 6/13/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "ThreeCardMatchingGame.h"
#import "TextHistoryViewController.h"

@interface CardGameViewController ()

@end

@implementation CardGameViewController

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
    self.matchMode.enabled = NO;
    self.enableSwitch.enabled = NO;

    self.matchMode.hidden = YES;
    self.enableSwitch.hidden = YES;
    
    self.enableLabel.hidden = YES;
    
    self.slider.hidden = YES;
    self.slider.enabled = NO;
    
    // two card game
    self.game.matchMode = NO;
    self.matchMode.selectedSegmentIndex = 0;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (TextCardMatchingGame *) game {
    if(!super.game) {
        super.game= [[ThreeCardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    }
    
    return super.game;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"Poke Record"]) {
        if([segue.destinationViewController isKindOfClass:[TextHistoryViewController class]]) {
            TextHistoryViewController *destVC = (TextHistoryViewController *)segue.destinationViewController;
            destVC.matchHistory = self.game.matchHistory;
        }
    }
}

- (Deck *) createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (TextCardMatchingGame *) createMatchingGame {
    return [[ThreeCardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:self.deck];
}

- (void) updateUI {
    [super updateUI];
    self.matchResult.attributedText = [self.game convertToAttrForString:self.game.labelText];
}


@end
