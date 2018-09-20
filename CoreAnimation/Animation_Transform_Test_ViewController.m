//
//  Animation_Transform_Test_ViewController.m
//  CoreAnimation
//
//  Created by XZM_XHY on 15/6/23.
//  Copyright (c) 2015年 HY. All rights reserved.
//

#import "Animation_Transform_Test_ViewController.h"

@interface Animation_Transform_Test_ViewController ()
@property (nonatomic, strong) CALayer *birdLayer;
@end

@implementation Animation_Transform_Test_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _birdLayer = [CALayer layer];
    _birdLayer.frame = CGRectMake(0, 0, 120, 120);
    _birdLayer.contentsGravity = kCAGravityResizeAspectFill;
    _birdLayer.contentsScale = [UIScreen mainScreen].scale;
    UIImage *birdImg = [UIImage imageNamed:@"bird"];
    _birdLayer.contents = (__bridge id)(birdImg.CGImage);
    [self.view.layer addSublayer:_birdLayer];
}

- (void)viewDidLayoutSubviews
{
    _birdLayer.position = self.view.center;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)animation:(id)sender
{
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = 2.0;
    animation.byValue = @(M_PI * 2);
    [_birdLayer addAnimation:animation forKey:nil];
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
