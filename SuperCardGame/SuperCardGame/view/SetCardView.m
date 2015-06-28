//
//  SetCardView.m
//  SuperCardGame
//
//  Created by Linwei Ding on 6/27/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "SetCardView.h"

@interface SetCardView()

@property (nonatomic) CGRect imageBounds;
@property (strong,nonatomic) NSMutableArray * boundsArray;

// shape
- (UIBezierPath *) bezierPathForFrame:(CGRect)rect;
- (void) drawSquiggle:(UIBezierPath *) path withFrame:(CGRect)rect ;
- (void) drawDiamond:(UIBezierPath *) path withFrame:(CGRect)rect;
@end

@implementation SetCardView

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
    // Drawing code
    CGContextRef ctxt;
    ctxt = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctxt);
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    CGContextRestoreGState(ctxt);
    [self updatePips];
}

- (void)pinch:(UIPinchGestureRecognizer *)gesture
{
    //    if ((gesture.state == UIGestureRecognizerStateChanged) ||
    //        (gesture.state == UIGestureRecognizerStateEnded)) {
    //        self.faceCardScaleFactor *= gesture.scale;
    //        gesture.scale = 1.0;
    //    }
    
}

#pragma mark - Pips

- (void) updatePips {
    UIBezierPath *path = nil;
    
    CGRect rect = CGRectMake(0, 0, self.imageBounds.size.width, self.imageBounds.size.height/3);
    path = [self bezierPathForFrame:rect];
    
    CGContextRef ctxt;
    ctxt = UIGraphicsGetCurrentContext();
    //UIBezierPath * stripePath = [[UIBezierPath alloc] init];
    [self updateBoundsArray];
    [self updatePathColor:path];

    
    
    for (NSValue * relativeRect in self.boundsArray) {
        CGContextSaveGState(ctxt);
        
        CGContextTranslateCTM(ctxt, relativeRect.CGRectValue.origin.x, relativeRect.CGRectValue.origin.y);
        [self updatePathPattern:path];
        
        CGContextRestoreGState(ctxt);
    }

//

}

- (void) updatePathColor: (UIBezierPath *)path {
    if ([self.color isEqualToString:@"red"]) {
        [[UIColor redColor] setFill ];
        [[UIColor redColor] setStroke ];
    }
    else if([self.color isEqualToString:@"green"]) {
        [[UIColor greenColor] setFill ];
        [[UIColor greenColor] setStroke ];
    }
    else if ([self.color isEqualToString:@"purple"]) {
        [[UIColor purpleColor] setFill ];
        [[UIColor purpleColor] setStroke ];
    }
    else {
        NSAssert(NO,@"the color is not supported, color = %@", self.color);
    }
}
- (void) updatePathPattern: (UIBezierPath *)path {
    if ([self.pattern isEqualToString:@"solid"]) {
        [path fill];
    }
    else if([self.pattern isEqualToString:@"striped"]) {

        //UIBezierPath * stripePath = [[UIBezierPath alloc] init];
        [self drawStripeLines:path inBounds:self.imageBounds];
//        CGContextRef ctxt = UIGraphicsGetCurrentContext();
//        CGContextSaveGState(ctxt);
        [path addClip];
        [path stroke];
//        CGContextRestoreGState(ctxt);
        
    }
    else if ([self.pattern isEqualToString:@"unfilled"]) {
        [path stroke];
    }
    else {
        NSAssert(NO,@"the color is not supported, color = %@", self.color);
    }
}

static const int STRIPE_LINE_INTERVAL = 20;
- (void) drawStripeLines:(UIBezierPath *)path inBounds:(CGRect)bounds {
    for (int i = 1; i<STRIPE_LINE_INTERVAL; i++) {
        [path moveToPoint:CGPointMake(0, bounds.size.height*i/STRIPE_LINE_INTERVAL)];
        [path addLineToPoint:CGPointMake(bounds.size.height*i/STRIPE_LINE_INTERVAL, 0)];
    }
   
}

- (UIBezierPath *) bezierPathForFrame:(CGRect)rect {
    UIBezierPath * path = nil; //[UIBezierPath bezierPathWith]
    if ([self.shape isEqualToString:@"squiggles"]) {
        path = [[UIBezierPath alloc] init];
        [self drawSquiggle:path withFrame:rect];
    }
    else if ([self.shape isEqualToString:@"diamonds"]) {
        path = [[UIBezierPath alloc] init];
        [self drawDiamond:path withFrame:rect];
    }
    else if ([self.shape isEqualToString:@"ovals"]) {
        path = [UIBezierPath bezierPathWithOvalInRect:rect];
    }
    else {
        NSAssert(NO,@"the shape is not supported, shape = %@", self.shape);
    }
    
    return path;
}

- (void) drawSquiggle:(UIBezierPath *) path withFrame:(CGRect)rect {

    //x: 5, 104 y:6.9 - 65.6
    [path moveToPoint:CGPointMake(104, 15)];
    [path addCurveToPoint:CGPointMake(63, 54) controlPoint1:CGPointMake(112.4, 36.9) controlPoint2:CGPointMake(89.7, 60.8)];
    [path addCurveToPoint:CGPointMake(27, 53) controlPoint1:CGPointMake(52.3, 51.3) controlPoint2:CGPointMake(42.2, 42)];
    [path addCurveToPoint:CGPointMake(5, 40) controlPoint1:CGPointMake(9.6, 65.6) controlPoint2:CGPointMake(5.4, 58.3)];
    [path addCurveToPoint:CGPointMake(36, 12) controlPoint1:CGPointMake(4.6, 22) controlPoint2:CGPointMake(19.1, 9.7)];
    [path addCurveToPoint:CGPointMake(89, 14) controlPoint1:CGPointMake(59.2, 15.2) controlPoint2:CGPointMake(61.9, 31.5)];
    [path addCurveToPoint:CGPointMake(104, 15) controlPoint1:CGPointMake(95.3, 10) controlPoint2:CGPointMake(100.9, 6.9)];
    [path closePath];
    
    [path applyTransform:CGAffineTransformMakeScale(0.9524*rect.size.width/100, 0.9524*rect.size.height/50)];
    [path applyTransform:CGAffineTransformMakeTranslation(rect.origin.x, rect.origin.y)];
    
}

- (void) drawDiamond:(UIBezierPath *) path withFrame:(CGRect)rect{
    [path moveToPoint:CGPointMake(rect.origin.x, rect.origin.y+rect.size.height/2)];
    [path addLineToPoint:CGPointMake(rect.origin.x+rect.size.width/2, rect.origin.y)];
    [path addLineToPoint:CGPointMake(rect.origin.x+rect.size.width, rect.origin.y+rect.size.height/2)];
    [path addLineToPoint:CGPointMake(rect.origin.x+rect.size.width/2, rect.origin.y+rect.size.height)];
    [path closePath];
    
}



#pragma mark -- Properties

- (CGRect)imageBounds {
    _imageBounds = CGRectInset(self.bounds, self.bounds.size.width*0.3, self.bounds.size.height*0.3);
    //NSLog(@"the bound is: %@",NSStringFromCGRect(self.bounds));
    //NSLog(@"the pips bound is: %@",NSStringFromCGRect(_imageBounds));
    
    return _imageBounds;
}

- (NSArray *) boundsArray {
    if (!_boundsArray) {
        [self updateBoundsArray];
    }
    return _boundsArray;
}

- (void)setRank:(NSUInteger)rank {
    _rank = rank;
    [self setNeedsDisplay];
}

- (void) setPattern:(NSString *)pattern {
    _pattern = pattern;
    [self setNeedsDisplay];
}

- (void)setShape:(NSString *)shape {
    _shape = shape;
    [self setNeedsDisplay];
}

- (void)setColor:(NSString *)color {
    _color = color;
    [self setNeedsDisplay];
}

- (void) updateBoundsArray {
    NSMutableArray * array = [[NSMutableArray alloc] init];
    CGRect rect;
    NSValue * bounds = nil;
    
    if(self.rank == 0) {
        rect = CGRectInset(self.imageBounds, 0, self.imageBounds.size.height/3);//self.imageBounds;
        bounds = [NSValue valueWithCGRect:rect];
        [array addObject:bounds];
    }
    else if (self.rank == 1) {
        rect = self.imageBounds;
        rect.size.height = self.imageBounds.size.height/2;
        
        //first
        rect = CGRectInset(rect, 0, rect.size.height/6);  //(rect.size.height - rect.size.height*2/3)/2;
        bounds = [NSValue valueWithCGRect:rect];
        [array addObject:bounds];
        
        //second
        rect = self.imageBounds;
        rect.size.height = self.imageBounds.size.height/2;
        rect.origin.y = self.imageBounds.origin.y +self.imageBounds.size.height/2;
        rect = CGRectInset(rect, 0, rect.size.height/6);
        bounds = [NSValue valueWithCGRect:rect];
        [array addObject:bounds];
    }
    else if (self.rank == 2) {
        rect = self.imageBounds;
        rect.size.height = self.imageBounds.size.height/3;
        
        //first
        bounds = [NSValue valueWithCGRect:rect];
        [array addObject:bounds];
        
        
        //second
        rect.origin.y = self.imageBounds.origin.y +self.imageBounds.size.height/3;
        bounds = [NSValue valueWithCGRect:rect];
        [array addObject:bounds];
        
        //thrid
        rect.origin.y = self.imageBounds.origin.y +self.imageBounds.size.height*2/3;
        bounds = [NSValue valueWithCGRect:rect];
        [array addObject:bounds];
    }
    else {
        NSAssert(NO,@"the rank is not supported, the rank = %d", self.rank );
    }
    
    self.boundsArray = array;
}
@end
