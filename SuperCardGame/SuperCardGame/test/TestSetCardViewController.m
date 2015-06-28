//
//  TestSetCardViewController.m
//  SuperCardGame
//
//  Created by Linwei Ding on 6/27/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "TestSetCardViewController.h"

@interface TestSetCardViewController ()

@end

@implementation TestSetCardViewController

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
    [self drawRandomPlayingCard];
    // Do any additional setup after loading the view, typically from a nib.
    //[self.cardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.cardView action:@selector(pinch:)]];
    
    [self.tableView addSubview:self.cardView];
}

- (void) viewDidAppear:(BOOL)animated  {
    [super viewDidAppear:animated];
    [self.cardView setNeedsDisplay];
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
    if ([card isKindOfClass:[SetCard class]]) {
        SetCard *setCard = (SetCard *)card;
        self.cardView.rank = setCard.rank;
        self.cardView.color = setCard.color;
        self.cardView.shape = setCard.shape;
        self.cardView.pattern = setCard.pattern;
        
        NSLog(@"rank =%d, %@, %@, %@", setCard.rank, setCard.color,
              setCard.shape, setCard.pattern);
        
        [self.cardView setNeedsDisplay];
    }
}

#pragma mark -- Gestures
- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
    
//    if (!self.cardView.faceUp) [self drawRandomPlayingCard];
//    self.cardView.faceUp = !self.cardView.faceUp;
}

- (IBAction)tap:(UITapGestureRecognizer *)sender {
    if (!self.cardView.shade) [self drawRandomPlayingCard];
    self.cardView.shade = !self.cardView.shade;
    
}



#pragma mark -- Properties


- (SetCardView *) cardView {
    if (!_cardView) {
        CGRect cardFrame = CGRectMake(self.tableView.center.x/2, self.tableView.center.y/2, self.tableView.bounds.size.width/2, self.tableView.bounds.size.height/2);
        _cardView = [[SetCardView alloc] initWithFrame:cardFrame];
        
    }
    
    return _cardView;
}

- (Deck *)deck
{
    if (!_deck) _deck = [[SetCardDeck alloc] init];
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
