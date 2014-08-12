//
//  DBBumperView.m
//  DynamicBehaviors
//
//  Created by Michael Neill on 8/11/14.
//  Copyright (c) 2014 MKN Mobile. All rights reserved.
//

#import "DBBumperView.h"

@implementation DBBumperView
{
    UIBezierPath *_path;
}

- (void)awakeFromNib
{
    [self buildPathWithControlPoint:CGPointMake((self.bounds.size.width / 2), self.bounds.size.height * 0.75)];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddPath(ctx, _path.CGPath);
    CGContextSetFillColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextFillPath(ctx);
}

- (void)buildPathWithControlPoint:(CGPoint)controlPoint
{
    CGFloat heightOffset = 100;
    
    _path = [UIBezierPath bezierPath];
    [_path moveToPoint:CGPointMake(0, heightOffset)];
    [_path addQuadCurveToPoint:CGPointMake(self.bounds.size.width, heightOffset) controlPoint:controlPoint];
    [_path addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    [_path addLineToPoint:CGPointMake(0, self.bounds.size.height)];
    
    [_path closePath];
}

- (UIBezierPath *)path
{
    return _path;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[touches allObjects] objectAtIndex:0];
    CGPoint touchPos = [touch locationInView:touch.view];
    [self buildPathWithControlPoint:touchPos];
    [self setNeedsDisplay];
    
    if (_delegate && [_delegate respondsToSelector:@selector(bumperView:pathDidChange:)])
        [_delegate bumperView:self pathDidChange:_path];
}

@end
