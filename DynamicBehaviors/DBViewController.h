//
//  DBViewController.h
//  DynamicBehaviors
//
//  Created by Michael Neill on 8/11/14.
//  Copyright (c) 2014 MKN Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBBumperView.h"
#import "DBCircleView.h"

@interface DBViewController : UIViewController <UICollisionBehaviorDelegate, DBBumperViewDelegate, DBCircleViewDelegate>

@end
