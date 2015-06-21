//
//  ViewController.h
//  Machismo
//
//  Created by Linwei Ding on 6/4/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "TextCardMatchingGame.h"

//Abstract Class
@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *matchMode;
@property (weak, nonatomic) IBOutlet UISwitch *enableSwitch;

@property (weak, nonatomic) IBOutlet UIButton *redealButton;

@property (weak, nonatomic) IBOutlet UILabel *enableLabel;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (nonatomic, strong) TextCardMatchingGame * game;

@property (nonatomic, strong) Deck * deck;

@property (weak, nonatomic) IBOutlet UILabel *matchResult;

@property (weak, nonatomic) IBOutlet UISlider *slider;

//virtual function
- (TextCardMatchingGame *) createMatchingGame;


- (void) updateUI ;

//virtual function;
- (Deck *)createDeck;

- (NSString *) titleForCard: (Card *)card;

- (UIImage *) backgroundImageForCard: (Card*)card;

- (IBAction)touchCardButton:(UIButton *)sender;

@end

