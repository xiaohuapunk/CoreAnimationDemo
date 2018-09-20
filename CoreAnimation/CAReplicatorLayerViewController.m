//
//  CAReplicatorLayerViewController.m
//  CoreAnimation
//
//  Created by XZM_XHY on 15/6/16.
//  Copyright (c) 2015年 HY. All rights reserved.
//

#import "CAReplicatorLayerViewController.h"

@interface CAReplicatorLayerViewController ()
@property (nonatomic, weak) IBOutlet UIView *containerView;
@end

@implementation CAReplicatorLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
//    CALayer *layer = [CALayer layer];
//    layer.backgroundColor = [UIColor whiteColor].CGColor;
//    layer.frame = CGRectMake(100, 100, 100, 100);
//    [self.containerView.layer addSublayer:layer];
//    
//    CATransform3D transform = CATransform3DRotate(layer.transform, M_PI_4, 0, 0, 1);
//    transform = CATransform3DTranslate(transform, 100, 0, 0);
//    layer.transform = transform;
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
    replicatorLayer.backgroundColor = [UIColor colorWithRed:0.937 green:0.710 blue:0.404 alpha:1.000].CGColor;
    [self.containerView.layer addSublayer:replicatorLayer];
    
    replicatorLayer.instanceCount = 10;
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 75, 0);
    transform = CATransform3DRotate(transform, M_PI / 5.0, 0, 0, 1);
    transform = CATransform3DTranslate(transform, 0, -54, 0);
    transform = CATransform3DTranslate(transform, -65, 0, 0);
    replicatorLayer.instanceTransform = transform;
    
    replicatorLayer.instanceBlueOffset = -0.1;
    replicatorLayer.instanceGreenOffset = -0.1;
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(replicatorLayer.position.x - 75.0 / 2.0,replicatorLayer.position.y - 75.0 * 3, 75.0f, 75.0f);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [replicatorLayer addSublayer:layer];
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
