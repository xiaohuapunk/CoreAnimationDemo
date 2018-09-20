//
//  CABasicAnimationViewController.m
//  CoreAnimation
//
//  Created by XZM_XHY on 15/6/19.
//  Copyright (c) 2015年 HY. All rights reserved.
//

#import "CABasicAnimationViewController.h"

@interface CABasicAnimationViewController ()
@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, strong) CALayer *colorLayer;
@end

@implementation CABasicAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50, 50, 100, 100);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.containerView.layer addSublayer:self.colorLayer];
}

- (void)applyBasicAnimation:(CABasicAnimation *)animation toLayer:(CALayer *)layer
{
    [layer addAnimation:animation forKey:nil];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [layer setValue:animation.toValue forKey:animation.keyPath];
    [CATransaction commit];
}

- (IBAction)changeColor:(id)sender
{
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 2;
    animation.keyPath = @"backgroundColor";
    animation.toValue = (__bridge id)(color.CGColor);
    animation.delegate = self;
    [self applyBasicAnimation:animation toLayer:self.colorLayer];
    
    NSLog(@"%@",animation);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    CABasicAnimation *animation = (CABasicAnimation *)anim;
    
    NSLog(@"%@",animation);
    
    [self.colorLayer setValue:animation.toValue forKey:animation.keyPath];
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
