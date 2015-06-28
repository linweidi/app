//
//  TestBasicCardLayoutViewController.m
//  SuperCardGame
//
//  Created by Linwei Ding on 6/27/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//


#import "TableView.h"
#import "TestBasicCardLayoutViewController.h"

@interface TestBasicCardLayoutViewController ()

@end

@implementation TestBasicCardLayoutViewController

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
    self.grid.size = self.tableView.bounds.size;
    self.grid.cellAspectRatio = 0.7;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.grid.minimumNumberOfCells = [self.game cardNumber];
    
    BOOL valid = [self.grid inputsAreValid];
    if (valid) {
        //empty
    }
    else {
        NSAssert(NO, @"Input to grid is not valid" );
    }
    [self layoutViewOnGrid];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
    //
    //    if (!self.cardView.faceUp) [self drawRandomPlayingCard];
    //    self.cardView.faceUp = !self.cardView.faceUp;
}

- (IBAction)tap:(UITapGestureRecognizer *)sender {
    CGPoint hitPoint = [sender locationInView:self.view];
    UIView * view = [self.view hitTest:hitPoint withEvent:nil];
    if (view) {
//        if ([view isKindOfClass:[PlayingCardView class]]) {
//            cardView = (PlayingCardView *)view;
        
            NSUInteger indexOfView = [(TableView *)self.tableView indexOfView:view ];
            
            //update the card
            [self.game chooseCardAtIndex:indexOfView];
            
            //update the view
            [self updateUI];
        
        
    }
    
}

#pragma mark -- Update UI
- (void) layoutViewOnGrid {
    CGPoint center;
    CGRect frame;
    //CGRect bounds;
    
    UIView * view = nil;
    
    
    NSAssert([self.tableView.subviews count]==0, @"the card views' count is not 0, it is: %d",
             [self.tableView.subviews count]);
    
    int cardIndex = 0;
    for (int i =0; i<self.grid.rowCount; i++) {
        for (int j=0; j<self.grid.columnCount; j++) {
            
            // card number is constant in poker game
            if (cardIndex < [self.game cardNumber]) {
                
                center = [self.grid centerOfCellAtRow:i inColumn:j];
                frame = [self.grid frameOfCellAtRow:i inColumn:j];
                //bounds = [self.grid boundsOfCellAtRow:i inColumn:j];
                //NSLog(@"the bound width:%f, heigh:%f, frame width:%f, heigh:%f",bounds.size.width, bounds.size.height,frame.size.width, frame.size.height);
                view = [self createView:frame];
                view.center = center;
                //bounds.size = frame.size;
                //view.bounds = bounds;// = bounds.origin.x;
                //NSLog(@"the bound width:%f, heigh:%f, frame width:%f, heigh:%f",view.bounds.size.width, view.bounds.size.height,view.frame.size.width, view.frame.size.height);
                //                //draw view
                //                if ([self.game isKindOfClass:[PokerCardMatchingGame class]]) {
                //                    PlayingCard *card = (PlayingCard *)[self.game cardAtIndex:cardIndex];
                //
                //                    // set view info according to card
                //                    [self setCardView:view forCard:card];
                //                }
                
                // add view to table view
                [self.tableView addSubview:view];
                
                
                //add gesture to each view
                
                
                cardIndex++;
            }
            else {
                break;
            }
            
            
        }
        if (cardIndex >= [self.game cardNumber]) {
            break;
        }
    }
    
    NSAssert(cardIndex ==[self.game cardNumber], @"the created view number is not right:%d", cardIndex);
}

- (void) updateUI {
    
    int indexCardView = 0;
    for (UIView *cardView in self.tableView.subviews) {
        NSAssert(indexCardView<[self.tableView.subviews count],
                 @"the index of card view is greater than subview count, indexCardView = %d",indexCardView);

        Card *card = [self.game cardAtIndex:indexCardView];
        
        if(card) {
            // update card view
            [self updateCardView:cardView forCard:card];
            
            
        }
        
        indexCardView++;
    }
    
}

#pragma mark -- Virtual Functions
//virtual function
- (void) updateCardView:(UIView *)view forCard:(Card *)card {
    NSAssert(NO, @"Virtual Function is called");
}

- (UIView *) createView:(CGRect)rect{
    NSAssert(NO, @"Virtual Function is called");
    return nil;
}

- (CardMatchingGame *) createGame {
    NSAssert(NO, @"Virtual Function is called");
    return nil;
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

#pragma mark -- Gestures
- (IBAction)touchForRedeal:(UIButton *)sender {
    self.game = [self createGame];
    [self updateUI];
}


#pragma mark -- Properties
- (Grid *)grid {
    if (!_grid) {
        _grid = [[Grid alloc] init];
    }
    return _grid;
}

- (CardMatchingGame *) game {
    if (!_game) {
        _game = [self createGame];
        
    }
    return _game;
}

@end
