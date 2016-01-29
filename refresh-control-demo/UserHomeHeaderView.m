//
//  UserHomeHeaderView.m
//  refresh-control-demo
//
//  Created by CavinTang on 1/29/16.
//  Copyright © 2016 Cavin. All rights reserved.
//

#import "UserHomeHeaderView.h"

@interface UserHomeHeaderView ()

@property (nonatomic, assign) CGRect bgImageViewOriginFrame;

@end

@implementation UserHomeHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.containerView.sizeH = [UIScreen mainScreen].bounds.size.height * 2;
    self.containerView.originY = self.sizeH - self.containerView.sizeH;
    
    self.bgImageViewOriginFrame = self.bgImageView.frame;
}

- (void)updateBGScale
{
    CGPoint topOffset = [self convertPoint:CGPointZero toView:[[UIApplication sharedApplication] keyWindow]];
    
    CGFloat distance = MAX(0, topOffset.y);
    CGFloat scale = 1 + distance / self.bgImageViewOriginFrame.size.height;
    
    self.bgImageMaskView.centerY =
    self.bgImageView.centerY = self.bgImageViewOriginFrame.origin.y + self.bgImageViewOriginFrame.size.height / 2 - distance / 2;
    CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
    self.bgImageMaskView.transform =
    self.bgImageView.transform = transform;
}

@end
