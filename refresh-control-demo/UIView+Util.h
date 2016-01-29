//
//  UIView+Util.h
//  refresh-control-demo
//
//  Created by CavinTang on 1/29/16.
//  Copyright © 2016 Cavin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Util)

+ (instancetype)viewFromXib;

@property(nonatomic,assign) CGPoint origin;
@property(nonatomic,assign) CGFloat originX;
@property(nonatomic,assign) CGFloat originY;
@property(nonatomic,assign) CGSize  size;
@property(nonatomic,assign) CGFloat  sizeW;
@property(nonatomic,assign) CGFloat  sizeH;
@property(nonatomic,assign) CGFloat centerX;
@property(nonatomic,assign) CGFloat centerY;

@end
