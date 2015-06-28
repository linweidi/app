//
//  TestSetCardViewController.h
//  SuperCardGame
//
//  Created by Linwei Ding on 6/27/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "SetCardView.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import <UIKit/UIKit.h>

@interface TestSetCardViewController : UIViewController

@property (nonatomic,strong) SetCardView *cardView;
@property (strong, nonatomic) Deck *deck;
@property (weak, nonatomic) IBOutlet UIView *tableView;
@end
