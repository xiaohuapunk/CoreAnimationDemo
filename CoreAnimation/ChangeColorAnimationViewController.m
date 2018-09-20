//
//  ChangeColorAnimationViewController.m
//  CoreAnimation
//
//  Created by XZM_XHY on 15/6/17.
//  Copyright (c) 2015年 HY. All rights reserved.
//

#import "ChangeColorAnimationViewController.h"

@interface ChangeColorAnimationViewController ()
@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, strong) CALayer *colorLayer;
@end

@implementation ChangeColorAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50, 50, 100, 100);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.containerView.layer addSublayer:self.colorLayer];
    
    
}

- (IBAction)changeColor:(id)sender
{
    // 通过提交一个事务 添加动画
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.25];
    
    [CATransaction setCompletionBlock:^{
        CGAffineTransform transform = self.colorLayer.affineTransform;
        transform = CGAffineTransformRotate(transform, M_PI_2);
        self.colorLayer.affineTransform = transform;
    }];
    
//    CGFloat red = arc4random() / (CGFloat)INT_MAX;
//    CGFloat green = arc4random() / (CGFloat)INT_MAX;
//    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
//    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1].CGColor;
    
    // CAKeyframeAnimation有一个NSArray类型的timingFunctions属性，我们可以用它来对每次动画的步骤指定不同的计时函数。但是指定函数的个数一定要等于keyframes数组的元素个数减一，因为它是描述每一帧之间动画速度的函数
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = 5.0;
    animation.values = @[
                         (__bridge id)[UIColor blueColor].CGColor,
                         (__bridge id)[UIColor redColor].CGColor,
                         (__bridge id)[UIColor grayColor].CGColor,
                         (__bridge id)[UIColor blueColor].CGColor
                         ];
    CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.timingFunctions = @[fn,fn,fn];
    animation.repeatCount = 3;
    [self.colorLayer addAnimation:animation forKey:nil];
    
    [CATransaction commit];
    
    
    
    
    
    
    
    
    
    ///
    /// UIView关联的图层（CALayer）禁用了隐式动画
    /// UIView 复写了 actionForLayer:forKey方法，如果修改的属性在动画块内部则返回CABaseAnimation,否则返回nil，就没有动画了
    ///
    NSLog(@"Outside: %@",[self.containerView actionForLayer:self.containerView.layer forKey:@"backgroundColor"]);
    
    [UIView beginAnimations:nil context:nil];
    NSLog(@"Inside: %@",[self.containerView actionForLayer:self.containerView.layer forKey:@"backgroundColor"]);
    
    [UIView commitAnimations];
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
