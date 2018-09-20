//
//  CAKeyframeAnimationViewController.m
//  CoreAnimation
//
//  Created by XZM_XHY on 15/6/19.
//  Copyright (c) 2015年 HY. All rights reserved.
//

#import "CAKeyframeAnimationViewController.h"

@interface CAKeyframeAnimationViewController ()

@end

@implementation CAKeyframeAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 用Bezier绘制曲线路径
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(-25, 200)];
    [bezierPath addCurveToPoint:CGPointMake([UIScreen mainScreen].bounds.size.width + 25, 220)
                  controlPoint1:CGPointMake([UIScreen mainScreen].bounds.size.width / 3, 350)
                  controlPoint2:CGPointMake([UIScreen mainScreen].bounds.size.width * 2 / 3, 120)];
    
    // 添加曲线图层
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    pathLayer.lineJoin = kCALineJoinRound;
    pathLayer.lineCap = kCALineCapRound;
    [self.view.layer addSublayer:pathLayer];
    
    CALayer *layer = [CALayer layer];
    layer.contentsGravity= kCAGravityResizeAspect;
    layer.contentsScale = [UIScreen mainScreen].scale;
    layer.contents = (__bridge id)[UIImage imageNamed:@"bird"].CGImage;
//    CATransform3D transform = CATransform3DRotate(layer.transform, M_PI, 0, 1, 0);
//    layer.transform = transform;
    layer.frame = CGRectMake(0, 0, 50, 50);
    layer.position = CGPointMake(10, 200);
    [self.view.layer addSublayer:layer];
    
    // 动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 6.0f;
    animation.repeatCount = INFINITY;
    animation.rotationMode = kCAAnimationRotateAuto;
    animation.path = bezierPath.CGPath;
    [layer addAnimation:animation forKey:nil];
    
}

- (void)dealloc
{
    NSLog(@"dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
