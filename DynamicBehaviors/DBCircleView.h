//
//  DBCircleView.h
//  DynamicBehaviors
//
//  Created by Michael Neill on 8/11/14.
//  Copyright (c) 2014 MKN Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DBCircleView;

@protocol DBCircleViewDelegate <NSObject>

- (void)circleViewCenterDidChange:(DBCircleView *)view;

@end

@interface DBCircleView : UIView

@property (nonatomic, weak) id <DBCircleViewDelegate> delegate;

@end
