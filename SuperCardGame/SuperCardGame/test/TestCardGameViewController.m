//
//  TestCardGameViewController.m
//  SuperCardGame
//
//  Created by Linwei Ding on 6/25/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "TestCardGameViewController.h"

@interface TestCardGameViewController ()


@end

@implementation TestCardGameViewController

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
    self.grid.cellAspectRatio = 0.9;
    self.grid.minimumNumberOfCells = 12;
    
    BOOL valid = [self.grid inputsAreValid];
    if (valid) {
        //empty
    }
    else {
        NSAssert(NO, @"Input to grid is not valid" );
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Update UI
- (void) layoutViewOnGrid {
    CGPoint center;
    CGRect frame;
    CGSize size;
    
    PlayingCardView * view = nil;
    for (int i =0; i<self.grid.rowCount; i++) {
        for (int j=0; j<self.grid.columnCount; j++) {
            center = [self.grid centerOfCellAtRow:i inColumn:j];
            frame = [self.grid frameOfCellAtRow:i inColumn:j];
            size = [self.grid cellSize];
            view = [[PlayingCardView alloc]initWithFrame:frame];
            
            [self.tableView addSubview:view];
            
        }
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
        _game = [[CardMatchingGame alloc] initWithCardCount:12 usingDeck:self.deck];
        
    }
    return _game;
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
