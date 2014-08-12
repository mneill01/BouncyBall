//
//  DBViewController.m
//  DynamicBehaviors
//
//  Created by Michael Neill on 8/11/14.
//  Copyright (c) 2014 MKN Mobile. All rights reserved.
//

#import "DBViewController.h"

@interface DBViewController ()
{
    UIDynamicAnimator *dynamicAni;
    UIGravityBehavior *gravity;
    UICollisionBehavior *collisionBehavior;
    
    int boundryCnt;
    CGPoint lastControlPoint;
    BOOL didFallThrough;
}

@property (nonatomic, weak) IBOutlet DBBumperView *bumperView;
@property (nonatomic, weak) IBOutlet DBCircleView *circleView;

@end

@implementation DBViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _bumperView.delegate = self;
    _circleView.delegate = self;
	
    // add dynamic animator
    dynamicAni = [[UIDynamicAnimator alloc] initWithReferenceView:_bumperView];
    [self buildBehaviors];
}

- (void)buildBehaviors
{
    gravity = [[UIGravityBehavior alloc] initWithItems:@[_circleView]];
    [dynamicAni addBehavior:gravity];
    
    collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[_circleView]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    collisionBehavior.collisionDelegate = self;
    [collisionBehavior addBoundaryWithIdentifier:[NSString stringWithFormat:@"BendPathBoundry_%d", boundryCnt] forPath:_bumperView.path];
    [dynamicAni addBehavior:collisionBehavior];
    
    boundryCnt++;
}

- (void)clearBehaviors
{
    [dynamicAni removeAllBehaviors];
    collisionBehavior = nil;
    gravity = nil;
}

- (void)collisionBehavior:(UICollisionBehavior*)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    //NSLog(@"Hitting Bounds!!!");
}

- (void)collisionBehavior:(UICollisionBehavior*)behavior endedContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier
{
    //NSLog(@"Moved from Bounds!!!");
}

- (void)bumperView:(DBBumperView *)bumperView pathDidChange:(UIBezierPath *)path
{
    [collisionBehavior addBoundaryWithIdentifier:[NSString stringWithFormat:@"BendPathBoundry_%d", boundryCnt] forPath:path];
    [collisionBehavior removeBoundaryWithIdentifier:[NSString stringWithFormat:@"BendPathBoundry_%d", boundryCnt - 1]];
    
    boundryCnt++;
}

- (void)circleViewCenterDidChange:(DBCircleView *)view
{
    BOOL containsPoint = [_bumperView.path containsPoint:view.center];
    
    if (containsPoint)
    {
        didFallThrough = YES;
        view.center = CGPointMake(view.center.x, view.center.y - 5);
    }
    
    if (didFallThrough && !containsPoint)
    {
        didFallThrough = NO;
        
        [self clearBehaviors];
        [self buildBehaviors];
    }
}

- (IBAction)resetBtnClk:(id)sender
{
    _circleView.center = CGPointMake(_circleView.center.x, 10);
    [self clearBehaviors];
    [self buildBehaviors];
}

@end
