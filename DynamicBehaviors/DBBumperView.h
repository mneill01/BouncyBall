//
//  DBBumperView.h
//  DynamicBehaviors
//
//  Created by Michael Neill on 8/11/14.
//  Copyright (c) 2014 MKN Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DBBumperView;

@protocol DBBumperViewDelegate <NSObject>

- (void)bumperView:(DBBumperView *)bumperView pathDidChange:(UIBezierPath *)path;

@end

@interface DBBumperView : UIView

@property (nonatomic, weak) id <DBBumperViewDelegate> delegate;
@property (nonatomic, readonly) UIBezierPath *path;

@end
