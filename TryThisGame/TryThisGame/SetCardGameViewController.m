//
//  SetCardGameViewController.m
//  TryThisGame
//
//  Created by Linwei Ding on 6/18/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCardMatchingGame.h"
#import "TextHistoryViewController.h"

@interface SetCardGameViewController ()


@end

@implementation SetCardGameViewController

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
    
    // Do any additional setup after loading the view.
    self.matchMode.enabled = NO;
    self.enableSwitch.enabled = NO;
    
    self.matchMode.hidden = YES;
    self.enableSwitch.hidden = YES;
    
    self.enableLabel.hidden = YES;
    
    self.slider.hidden = YES;
    self.slider.enabled = NO;
    
    
    // three card game
    self.game.matchMode = YES;
    self.matchMode.selectedSegmentIndex = 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (Deck *) createDeck {
    return [[SetCardDeck alloc] init];
}

- (TextCardMatchingGame *) game {
    if(!super.game) {
        super.game=(SetCardMatchingGame *)[[SetCardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
        NSLog(@"card button number is %d", [self.cardButtons count]	);
    }
    
    return super.game;
}

- (TextCardMatchingGame *) createMatchingGame {
    return [[SetCardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:self.deck];
}

- (void) updateUI {
    [super updateUI];
    
    for (UIButton *cardButton in self.cardButtons){
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        if(card) {

            SetCardMatchingGame * setGame = nil;
            if ([self.game isKindOfClass:[SetCardMatchingGame class]]) {
                setGame = (SetCardMatchingGame *)self.game;
            }
            else {
                NSAssert(NO, @"self.game is not SetCardMatchingGame type");
            }
            [cardButton setAttributedTitle:[setGame convertString:[self titleForCard:card]] forState:UIControlStateNormal];
            
            NSAssert([setGame convertString:[self titleForCard:card]],@"");
            //[cardButton setTitle:nil forState:UIControlStateDisabled	];
            //[cardButton remove]
            


            
            //[self.scoreLabel setText:[NSString stringWithFormat:@"Score: %d", self.game.score]];
        }
        
        
    }
    self.matchResult.attributedText = [self.game convertToAttrForString:self.game.labelText];
    //self.matchResult.text = self.game.labelText;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    [super touchCardButton:sender];
    // a small test
    NSLog(@"touch button polymorphism");
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"Set Record"]) {
        if([segue.destinationViewController isKindOfClass:[TextHistoryViewController class]]) {
            TextHistoryViewController *destVC = (TextHistoryViewController *)segue.destinationViewController;
            destVC.matchHistory = self.game.matchHistory;
        }
    }
}


@end
