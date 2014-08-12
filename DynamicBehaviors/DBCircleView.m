//
//  DBCircleView.m
//  DynamicBehaviors
//
//  Created by Michael Neill on 8/11/14.
//  Copyright (c) 2014 MKN Mobile. All rights reserved.
//

#import "DBCircleView.h"

@implementation DBCircleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIBezierPath *bPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    
    CGContextAddPath(ctx, bPath.CGPath);
    CGContextSetFillColorWithColor(ctx, [UIColor orangeColor].CGColor);
    CGContextFillPath(ctx);
}

- (void)setCenter:(CGPoint)center
{
    [super setCenter:center];
    
    if (_delegate && [_delegate respondsToSelector:@selector(circleViewCenterDidChange:)])
        [_delegate circleViewCenterDidChange:self];
}

@end
