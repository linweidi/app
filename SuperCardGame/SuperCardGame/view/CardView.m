//
//  CardView.m
//  SuperCardGame
//
//  Created by Linwei Ding on 6/28/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "CardView.h"

@implementation CardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) animateArrivingCard {
    CGRect newFrame = self.frame;
    CGRect oldFrame = self.frame;
    oldFrame.origin.x -= self.superview.bounds.size.width;
    self.frame = oldFrame;
    
    __weak CardView * weakView = self;
    [UIView animateWithDuration:2
                          delay:0
                        options:
     UIViewAnimationOptionBeginFromCurrentState|
     UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         weakView.frame = newFrame;
                         
                     }completion:nil];
}

- (void) animateDepartureCard {
    CGRect newFrame = self.frame;
    CGRect oldFrame = self.frame;
    newFrame.origin.x += self.superview.bounds.size.width;
    self.frame = oldFrame;
    
    __weak CardView * weakView = self;
    [UIView animateWithDuration:2
                          delay:0
                        options:
     UIViewAnimationOptionBeginFromCurrentState|
     UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         weakView.frame = newFrame;
                         
                     }completion:nil];
}


@end
