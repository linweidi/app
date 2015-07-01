	//
//  SuperCardViewController.m
//  SuperCardGame
//
//  Created by Linwei Ding on 6/24/15.
//  Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//
#import "TableView.h"
#import "CardView.h"
#import "SuperCardViewController.h"


@interface SuperCardViewController ()
@property (strong, nonatomic) UIDynamicAnimator * animator;
@property (nonatomic, strong) UIAttachmentBehavior * attachBehavior;

@property (nonatomic) BOOL hitOnCard;
@property (nonatomic) BOOL isStackCards;
@end

@implementation SuperCardViewController


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
    
    self.grid.cellAspectRatio = 0.7;
}

- (void)viewDidLayoutSubviews {
    [self.game.dealCards addObjectsFromArray:self.game.cards];
    [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
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

#pragma mark -- Gestures
- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
    //
    //    if (!self.cardView.faceUp) [self drawRandomPlayingCard];
    //    self.cardView.faceUp = !self.cardView.faceUp;
}

- (UIDynamicAnimator *)animator {
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view ];
    }
    
    
    return _animator;
}

//- (UIAttachmentBehavior *)attachBehavior {
//    if (!_attachBehavior) {
//        _attachBehavior = [[UIAttachmentBehavior alloc] init];
//        [self.animator addBehavior:_attachBehavior];
//    }
//    return _attachBehavior;
//    
//}

- (IBAction)tap:(UITapGestureRecognizer *)sender {
    CGPoint hitPoint = [sender locationInView:self.view];
    UIView * view = [self.view hitTest:hitPoint withEvent:nil];
    
    
    if (view) {
        if ([view isKindOfClass:[CardView class]]) {
            if (self.isStackCards) {
                self.grid.resolved = NO;
                [self updateUI];
                
                self.isStackCards = NO;
            }
            else {
                CardView *cardView = nil;
                cardView = (CardView *)view;
                
                NSUInteger indexOfView = [(TableView *)self.tableView indexOfView:cardView ];
                
                //update the card
                [self.game chooseCardAtIndex:indexOfView];
                
                //update the view
                
                [self updateUI];
                
                
            }
            
        }
        else {
            //none
        }
    }
}

#pragma mark -- Update UI
- (void) layoutViewOnGrid {
    
    //re-grid
    
    int cardNumber = [self.game cardNumber];
    if (cardNumber != self.grid.minimumNumberOfCells || !CGSizeEqualToSize(self.grid.size, self.tableView.bounds.size) || !self.grid.resolved) {
        self.grid.minimumNumberOfCells = cardNumber;
        self.grid.size = self.tableView.bounds.size;
        //remove all the subview in the table view
        
        for (UIView *view in self.tableView.subviews) {
            [view removeFromSuperview];
        }
    }
    else {
        // if card number is the same, we do not need relayout
        return;
    }
    
    BOOL valid = [self.grid inputsAreValid];
    if (valid) {
        //empty
    }
    else {
        NSAssert(NO, @"Input to grid is not valid" );
    }
    
    
    CGPoint center;
    CGRect frame;
    //CGRect bounds;
    
    UIView * view = nil;
    
    
    
    NSAssert([self.tableView.subviews count]==0, @"the card views' count is not 0, it is: %d",[self.tableView.subviews count]);
    
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
    
    [self layoutViewOnGrid];
    
    int indexCardView = 0;
    for (UIView *cardView in self.tableView.subviews) {
        NSAssert(indexCardView<[self.tableView.subviews count],
                 @"the index of card view is greater than subview count, indexCardView = %d",indexCardView);
        
        Card *card = [self.game cardAtIndex:indexCardView];
        
        if(card) {
            // update card view
            [self updateCardView:cardView forCard:card];
            
            
        }
        
        NSLog(@"INDEX:%d %@", indexCardView, 	cardView);
        
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
    [self.game.dealCards addObjectsFromArray:self.game.cards];
    
    self.grid.resolved = NO;
    [self updateUI];
}
- (IBAction)pan:(UIPanGestureRecognizer *)sender {

    if (sender.state ==  UIGestureRecognizerStateBegan) {
        CGPoint beginPoint = [sender locationInView:self.tableView];
        UIView *hitView = [self.tableView hitTest:beginPoint withEvent:nil];
        if (hitView) {
            if ([hitView isKindOfClass:[CardView class]]) {
                self.hitOnCard = YES;
            }
        }
    }
    else if (sender.state == UIGestureRecognizerStateChanged ) {
        if (self.hitOnCard) {
            for (UIAttachmentBehavior *attachment in self.animator.behaviors) {
                CGPoint translation = [sender translationInView:self.tableView];
                attachment.anchorPoint = CGPointMake(attachment.anchorPoint.x + translation.x,attachment.anchorPoint.y + translation.y);
                
            }
            [sender setTranslation:CGPointZero inView:self.tableView];
        }

    }
    else if ( sender.state == UIGestureRecognizerStateEnded) {
        if (self.hitOnCard) {
            self.hitOnCard = NO;}
    }
    else {
        //fail
        self.hitOnCard = NO;
    }
}

static const float CARD_POSITION_OFFSET_X = 5;
static const float CARD_POSITION_OFFSET_Y = 5;
- (IBAction)pinch:(UIPinchGestureRecognizer *)sender {
    CGPoint anchor = CGPointZero;
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        anchor = [sender locationInView:self.tableView];
        NSAssert(!CGPointEqualToPoint(anchor, CGPointZero) , @"the anchor point is zeror");
        int i = 0;
        for (CardView * view in self.tableView.subviews) {
            UIAttachmentBehavior * attachBehavior =  [[UIAttachmentBehavior alloc] initWithItem:view attachedToAnchor:anchor];
            attachBehavior.length= 0;
            attachBehavior.anchorPoint = CGPointMake(anchor.x + i*CARD_POSITION_OFFSET_X, anchor.y+i*CARD_POSITION_OFFSET_Y);
            [self.animator addBehavior:attachBehavior];
            
            i++;
        }
        self.isStackCards = YES;
    }
    else if (sender.state == UIGestureRecognizerStateChanged) {
        int i = 0;
        for (UIAttachmentBehavior *attachment in self.animator.behaviors) {
            attachment.anchorPoint = CGPointMake(anchor.x + i*CARD_POSITION_OFFSET_X*sender.scale, anchor.y+i*CARD_POSITION_OFFSET_Y*sender.scale);
            i++;
        }

    }
    else if (sender.state == UIGestureRecognizerStateEnded) {

        self.isStackCards = YES;
    }
    else {
        //fail

        [self.animator removeAllBehaviors];
            
        self.isStackCards = NO;
        self.grid.resolved = NO;
        [self updateUI];
    }
}


- (void)animateDealCardsForView: (CardView *)view card:(Card*)card{
    if ([self.game.dealCards containsObject:card]) {
        [view animateArrivingCard];
        [self.game.dealCards removeObject:card];
        [view setNeedsDisplay];
    }
    else {
        [view setNeedsDisplay];
    }
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
