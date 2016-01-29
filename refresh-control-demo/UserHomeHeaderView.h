//
//  UserHomeHeaderView.h
//  refresh-control-demo
//
//  Created by CavinTang on 1/29/16.
//  Copyright © 2016 Cavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Util.h"

@interface UserHomeHeaderView : UIView

@property (nonatomic, weak) IBOutlet UIImageView *bgImageView;
@property (nonatomic, weak) IBOutlet UIView *bgImageMaskView;
@property (nonatomic, weak) IBOutlet UIView *containerView;

- (void)updateBGScale;

@end
