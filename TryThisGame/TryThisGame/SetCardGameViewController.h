//
//  SetCardGameViewController.h
//  TryThisGame
//
//  Created by Linwei Ding on 6/18/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "ViewController.h"

@interface SetCardGameViewController : ViewController

- (Deck *) createDeck;

- (void) updateUI ;

@property (nonatomic, strong) TextCardMatchingGame * game;

- (TextCardMatchingGame *) createMatchingGame ;
@end
