//
//  ErrorIndicationView.m
//  SuperCardGame
//
//  Created by Linwei Ding on 6/28/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "ErrorIndicationView.h"

@implementation ErrorIndicationView

#pragma mark - Initialization

- (void)setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

#pragma mark - Drawing

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }
- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];

    
    [self drawCross];

}

- (void) drawCross {
    // Drawing code
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    [path moveToPoint:self.bounds.origin];
    [path addLineToPoint:CGPointMake(self.bounds.origin.x + self.bounds.size.width, self.bounds.origin.y + self.bounds.size.height)];
    [path moveToPoint:CGPointMake(self.bounds.origin.x + self.bounds.size.width, self.bounds.origin.y)];
    [path addLineToPoint:CGPointMake(self.bounds.origin.x, self.bounds.origin.y + self.bounds.size.height)];
    
    path.lineWidth = 4;
    
    [[UIColor redColor] setStroke];
    //[[UIColor redColor] setFill];
    [path stroke];
    //[path fill];
}

#pragma mark -- Animation
- (void) animateIndication {
    
    self.opaque = NO;
    self.alpha = 0;
    
    __weak ErrorIndicationView * weakView = self;
    
    //animation of indication
    [UIView transitionWithView:weakView duration:3 options:UIViewAnimationOptionShowHideTransitionViews|UIViewAnimationOptionCurveEaseOut animations:^{
        weakView.alpha = 1.0;
    }completion:^(BOOL finished){
        if (finished) {
            [weakView removeFromSuperview];
        }
    }];
}
@end
