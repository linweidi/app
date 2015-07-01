//
//  TestSetCardLayoutViewController.m
//  SuperCardGame
//
//  Created by Linwei Ding on 6/26/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//
#import "SetCardMatchingGame.h"
#import "TableView.h"
#import "SetCardView.h"
#import "SetCard.h"
#import "ErrorIndicationView.h"
#import "TestSetCardLayoutViewController.h"

@interface TestSetCardLayoutViewController ()

@end

@implementation TestSetCardLayoutViewController

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

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Gestures


- (IBAction)tap:(UITapGestureRecognizer *)sender {
    
    CGPoint hitPoint = [sender locationInView:self.view];
    UIView * view = [self.view hitTest:hitPoint withEvent:nil];
    
    
    if (view) {
        if ([view isKindOfClass:[TableView class]]) {
            //redeal
            NSAssert([self.game isKindOfClass:[SetCardMatchingGame class]],@"the game is not Set card game");
            BOOL valid = [((SetCardMatchingGame *)self.game) dealThreeCards];
            if (valid) {
                //there are more cards, and deal success;
                //update the view
                
                [self updateUI];
//                [UIView transitionWithView:self.tableView duration:3 options:UIViewAnimationOptionLayoutSubviews|
//                 UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut
//                                animations:^{
//                                    [self updateUI];
//                                    [self.tableView setNeedsDisplay];
//                                }completion:nil];
//                [UIView animateWithDuration:3 delay:0 options:
//                 UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
//                    [self updateUI];
//                }completion:nil];
                
            }
            else {
                //deal three cards fail
        
                [self startIndication];
            }
        }
        else {
            //none
        }
    }
    
    [super tap:sender];
}

- (void) startIndication {
    // indication
    CGRect indViewRect = CGRectMake(self.tableView.center.x/2, self.tableView.center.y/2, self.tableView.bounds.size.width/2, self.tableView.bounds.size.height/2);
    
    //instantiate the indication
    ErrorIndicationView * indicationView = [[ErrorIndicationView alloc] initWithFrame:indViewRect];
    [self.tableView addSubview:indicationView];
    [indicationView animateIndication];
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

#pragma mark -- Others
- (UIView *) createView:(CGRect)rect {
    return [[SetCardView alloc]initWithFrame:rect];
}
- (CardMatchingGame *) createGame {
    return [[SetCardMatchingGame alloc] init];
}

#pragma mark -- Update UI

- (void) updateUI {
    NSAssert([self.game isKindOfClass:[SetCardMatchingGame class]], @"the game is not set card matching game");
    SetCardMatchingGame *game = (SetCardMatchingGame *)self.game;
    
    if ([game.removedCards count]>0) {
        int totalCount = [game.removedCards count];
        for (int i = 0; i< totalCount; i++) {
            Card *card = [game.removedCards firstObject];
            NSUInteger indexView = [(NSNumber *)([game.indexRemovedCards firstObject]) unsignedIntegerValue];
            SetCardView *view = [self.tableView.subviews objectAtIndex:indexView];

            [self animateRemovedView:view];
            
            //clear removedCards array
            [game removeRemovedCard:card];
        }

        
        
        NSAssert([game.removedCards count] ==0, @"removed card count is not zero, it is: %d", [game.removedCards count] );
    }
    else {
        [super updateUI];
    }
}

- (void) animateRemovedView: (UIView *)view{
    
    CGRect newFrame = view.frame;
    //CGRect oldFrame = self.frame;
    newFrame.origin.x += self.tableView.bounds.size.width;
    //self.frame = oldFrame;
    
    [UIView animateWithDuration:2
                          delay:0
                        options:
     UIViewAnimationOptionBeginFromCurrentState|
     UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         view.frame = newFrame;
                         self.redealButton.enabled = NO;
                     }completion:^(BOOL finished){
                         //[self layoutViewOnGrid];
                         if (finished) {
                             [super updateUI];
                             if(![((SetCardMatchingGame *)self.game).removedCards count]) {
                                 //small issue here
                                 //TODO
                                 self.redealButton.enabled = YES;
                             }
                             
                         }
                         
                     }];

}

- (NSInteger) indexOfCardView:(Card *)card viewGroup:(NSArray *)views {
    NSInteger ret = -1;
    
    
    
    return ret;
}

- (void) updateCardView:(UIView *)view forCard:(Card *)card {
    SetCardView *setCardView = nil;
    SetCard * setCard  = nil;
    if ([view isKindOfClass:[SetCardView class]]) {
        setCardView = (SetCardView * )view;
    }
    else {
        NSAssert(NO, @"view is not set card view");
    }
    if ([card isKindOfClass:[SetCard class]]) {
        setCard = (SetCard *)card;
    }
    else {
        NSAssert(NO, @"card is not set card");
    }
    if (card.isMatched) {
        setCardView.shade = YES;
    }
    else {
        if (card.isChosen) {
            setCardView.shade = YES;
        }
        else {
            setCardView.shade = NO;
        }
    }
    setCardView.rank = setCard.rank;
    setCardView.shape = setCard.shape;
    setCardView.color = setCard.color;
    setCardView.pattern = setCard.pattern;
    
//    NSLog(@"the card is: rank:%d, shape:%@, \
//          color:%@, pattern:%@, shade:%d ", setCard.rank,
//           setCard.shape, setCard.color, setCard.pattern, setCardView.shade);
    
    [self animateDealCardsForView:setCardView card:setCard];
    
}
@end
