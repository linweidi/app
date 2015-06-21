//
//  CardGameViewController.h
//  Machismo
//
//  Created by Linwei Ding on 6/13/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "ViewController.h"

@interface CardGameViewController : ViewController

@property (nonatomic, strong) TextCardMatchingGame * game;

- (Deck *) createDeck ;

- (void) updateUI ;

- (TextCardMatchingGame *) createMatchingGame;

@end
