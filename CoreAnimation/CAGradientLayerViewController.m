//
//  CAGradientLayerViewController.m
//  CoreAnimation
//
//  Created by XZM_XHY on 15/6/15.
//  Copyright (c) 2015年 HY. All rights reserved.
//

#import "CAGradientLayerViewController.h"

@interface CAGradientLayerViewController ()
@property (nonatomic, weak) IBOutlet UIView *containerView;
@end

@implementation CAGradientLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.view.bounds;
    [self.containerView.layer addSublayer:gradientLayer];
    // 填出渐变颜色 多值
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor blueColor].CGColor, (__bridge id)[UIColor greenColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor];
    // 设置每种颜色的填充范围
    gradientLayer.locations = @[@0.0, @0.2, @0.25, @0.5];
    
    gradientLayer.startPoint = CGPointMake(1, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
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
