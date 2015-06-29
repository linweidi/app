//
//  TableView.m
//  SuperCardGame
//
//  Created by Linwei Ding on 6/25/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "TableView.h"
#import "CardView.h"
#import "PlayingCardView.h"

@implementation TableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (NSUInteger) indexOfView:(UIView *)view  {
    NSAssert([view isKindOfClass:[CardView class]],@"the view is not cardview");
    return [self.subviews indexOfObject:view];
}


#pragma mark -- Properties

//- (void) setBounds:(CGRect)bounds {
//    [super setBounds:bounds];
//    [self updateGrid];
//}
//
//- (void) setCenter:(CGPoint)center {
//    [super setCenter:center];
//    [self updateGrid];
//    
//}
//
//- (void) setFrame:(CGRect)frame {
//    [super setFrame:frame];
//    [self updateGrid];
//}
//
//- (void) updateGrid {
//    self.grid.size = self.bounds.size;
//    self.grid.cellAspectRatio = 0.9;
//    self.grid.minimumNumberOfCells = 12;
//    
//    BOOL valid = [self.grid inputsAreValid];
//    if (valid) {
//        //empty
//    }
//    else {
//        NSAssert(NO, @"Input to grid is not valid" );
//    }
//}
//
//- (void) updateCardsView {
//    CGPoint center;
//    CGRect frame;
//    CGSize size;
//    
//    PlayingCardView * view = nil;
//    for (int i =0; i<self.grid.rowCount; i++) {
//        for (int j=0; j<self.grid.columnCount; j++) {
//            center = [self.grid centerOfCellAtRow:i inColumn:j];
//            frame = [self.grid frameOfCellAtRow:i inColumn:j];
//            size = [self.grid cellSize];
//            view = [[PlayingCardView alloc] initWithFrame:frame];
//            self
//            cardViews addObject:<#(id)#>
//        }
//    }
//}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}


@end
