//
//  ViewController.m
//  Machismo
//
//  Created by Linwei Ding on 6/4/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//


#import "ViewController.h"

#import "PlayingCard.h"

@interface ViewController ()


@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation ViewController

@synthesize game = _game;

- (void) viewDidLoad {
    [super viewDidLoad];
    [self.slider removeConstraints:self.view.constraints];
    CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI*-0.5);
    self.slider.translatesAutoresizingMaskIntoConstraints = YES;
    self.slider.transform = trans;
}

- (TextCardMatchingGame *) game {
    
//    if(!_game) {
//        _game = [[TextCardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
//    }
//    
//    return _game;
    //NSAssert(NO,@"Abstract Class is instatntited");
    return _game;
}

- (IBAction)slideChangeValue:(UISlider *)sender {
    // here UIslider must be integer
        self.matchResult.text = self.game.textArray[(int)(sender.value)];
    
}



- (IBAction)switchChangeMode:(UISegmentedControl *)sender {
    if(self.matchMode.selectedSegmentIndex == 0 ) {
        NSLog(@"seleted segment index is 0");
        self.game.matchMode = NO ;
    }
    else {
        NSLog(@"seleted segment index is 1");
        self.game.matchMode = YES;
    }
    
    
}

- (IBAction)switchEnable:(UISwitch *)sender {
    if([sender isOn]) {
        self.redealButton.enabled = YES;
    }
    else {
        self.redealButton.enabled = NO;
    }
}

- (IBAction)touchCardButton:(UIButton *)sender {
    /*
    if([sender.currentTitle length]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    }
    else {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"A♣︎" forState:UIControlStateNormal];
    }
    
    self.flipCount++;
     */
//    if([sender.currentTitle length]) {
//        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
//                          forState:UIControlStateNormal];
//        [sender setTitle:@"" forState:UIControlStateNormal];
//    }
//    else {
//
//        Card * card = [self.deck drawRandomCard];
//        if(card) {
//            [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
//                              forState:UIControlStateNormal];
//            [sender setTitle:card.contents forState:UIControlStateNormal];
//            self.flipCount++;
//        }
//
//    }
    self.matchMode.enabled = NO;
    
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    
    [self.game chooseCardAtIndex:chosenButtonIndex];
    //Card  * card = [self.game cardAtIndex:chosenButtonIndex];
    
    [self updateUI];

    
}


- (void) updateUI {
    for (UIButton *cardButton in self.cardButtons){
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        if(card) {
            [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
            [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
            cardButton.enabled = !card.isMatched;
            
            [self.scoreLabel setText:[NSString stringWithFormat:@"Score: %d", self.game.score]];
        }
        
        
    }
    
    self.matchResult.text = self.game.labelText;
}

- (NSString *) titleForCard: (Card *)card {
    return card.isMatched?card.contents:card.isChosen?card.contents:@"";
}

- (UIImage *) backgroundImageForCard: (Card*)card {
    UIImage * imageFront = [UIImage imageNamed:@"cardfront"];
    UIImage * imageBack = [UIImage imageNamed:@"cardback"];
    return card.isMatched?imageFront:card.isChosen?imageFront:imageBack;
}

//virtual method
- (Deck *)createDeck {
    NSAssert(NO, @"virtual function");
    return nil;
}

- (TextCardMatchingGame *) createMatchingGame {
    NSAssert(NO, @"virtual function");
    return nil;
}

- (IBAction)touchForRedeal:(UIButton *)sender {
    self.deck = [self createDeck];
    self.game = [self createMatchingGame];
    [self updateUI];
    

    if(self.matchMode.selectedSegmentIndex == 0 ) {
        NSLog(@"seleted segment index is 0");
        self.game.matchMode = NO ;
    }
    else {
        NSLog(@"seleted segment index is 1");
        self.game.matchMode = YES;
    }
    
    //enable switch
    self.matchMode.enabled = YES;
    

}

//- (void)resetUI {
//    [self.scoreLabel setText:[NSString stringWithFormat:@"Score: %d", self.game.score]];
//    
//}

@end
