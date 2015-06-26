//
//  SuperCardViewController.h
//  SuperCardGame
//
//  Created by Linwei Ding on 6/24/15.
//  Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"

@interface SuperCardViewController : UIViewController


//virtual function
- (CardMatchingGame *) createMatchingGame;

- (void) updateUI ;

//virtual function;
- (Deck *)createDeck;

- (NSString *) titleForCard: (Card *)card;

- (UIImage *) backgroundImageForCard: (Card*)card;

@end
