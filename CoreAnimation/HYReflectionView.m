//
//  HYReflectionView.m
//  CoreAnimation
//
//  Created by XZM_XHY on 15/6/16.
//  Copyright (c) 2015年 HY. All rights reserved.
//

#import "HYReflectionView.h"

@implementation HYReflectionView

/**
 *  复写view的自动生成图层的方法，根据返回的layer类似自动生成类对应的实例图层（CALayer）
 *
 *  @return 返回 CAReplicatorLayer 类型
 */
+ (Class)layerClass
{
    return [CAReplicatorLayer class];
}

- (void)setup
{
    CAReplicatorLayer *layer = (CAReplicatorLayer *)self.layer;
    layer.contentsScale = [UIScreen mainScreen].scale;
    layer.instanceCount = 2;
    
    CATransform3D transform = CATransform3DIdentity;
    CGFloat verticalOffset = self.bounds.size.height + 2;
    transform = CATransform3DTranslate(transform, 0, verticalOffset, 0);
    transform = CATransform3DScale(transform, 1.0f, -1.0f, 0.0f);
    layer.instanceTransform = transform;
    layer.instanceAlphaOffset = -0.6f;
    
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    self.layer.mask = gradientLayer;
    gradientLayer.colors = @[(__bridge id)[UIColor blackColor].CGColor,
                              (__bridge id)[UIColor blackColor].CGColor,
                              (__bridge id)[UIColor clearColor].CGColor];
    
    //update mask
    [CATransaction begin];
    [CATransaction setDisableActions:YES]; // don't animate
    CGFloat total = layer.bounds.size.height * 2.0f + 4.0;
    CGFloat halfWay = (layer.bounds.size.height + 4.0) / total - 0.01f;
    gradientLayer.frame = CGRectMake(0.0f, 0.0f, self.bounds.size.width, total);
    gradientLayer.locations = @[@0.0f, @(halfWay), @(halfWay + (1.0f - halfWay) * 4.0)];
    [CATransaction commit];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setup];
}

@end
