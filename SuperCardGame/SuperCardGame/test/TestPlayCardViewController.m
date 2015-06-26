//
//  PlayCardViewController.m
//  SuperCardGame
//
//  Created by Linwei Ding on 6/25/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "TestPlayCardViewController.h"



@interface TestPlayCardViewController ()



@end

@implementation TestPlayCardViewController

#pragma mark -- View Procedure
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
    
    // Do any additional setup after loading the view, typically from a nib.
    [self.cardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.cardView action:@selector(pinch:)]];
    
    [self.tableView addSubview:self.cardView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Functions


- (void)drawRandomPlayingCard
{
    Card *card = [self.deck drawRandomCard];
    if ([card isKindOfClass:[PlayingCard class]]) {
        PlayingCard *playingCard = (PlayingCard *)card;
        self.cardView.rank = playingCard.rank;
        self.cardView.suit = playingCard.suit;
    }
}

#pragma mark -- Gestures
- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
    
    if (!self.cardView.faceUp) [self drawRandomPlayingCard];
    self.cardView.faceUp = !self.cardView.faceUp;
}

- (IBAction)tap:(UITapGestureRecognizer *)sender {
    if (!self.cardView.faceUp) [self drawRandomPlayingCard];
    self.cardView.faceUp = !self.cardView.faceUp;
}



#pragma mark -- Properties


- (PlayingCardView *) cardView {
    if (!_cardView) {
        CGRect cardFrame = CGRectMake(self.tableView.center.x/2, self.tableView.center.y/2, self.tableView.bounds.size.width/2, self.tableView.bounds.size.height/2);
        _cardView = [[PlayingCardView alloc] initWithFrame:cardFrame];
        
    }
    
    return _cardView;
}

- (Deck *)deck
{
    if (!_deck) _deck = [[PlayingCardDeck alloc] init];
    return _deck;
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
