//
//  CAEmitterLayerViewController.m
//  CoreAnimation
//
//  Created by XZM_XHY on 15/6/17.
//  Copyright (c) 2015年 HY. All rights reserved.
//

#import "CAEmitterLayerViewController.h"

@interface CAEmitterLayerViewController ()
@property (nonatomic, weak) IBOutlet UIView *containerView;
@end

@implementation CAEmitterLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = [UIScreen mainScreen].bounds;//CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
    [self.containerView.layer addSublayer:emitter];
    
    emitter.renderMode = kCAEmitterLayerAdditive;
    emitter.emitterPosition = emitter.position;
    emitter.emitterShape = kCAEmitterLayerLine;
    
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id)([UIImage imageNamed:@"fireStar"].CGImage);
    cell.birthRate = 20;
    cell.lifetime = 5.0;
    cell.color = [UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:1.0].CGColor;
    cell.alphaSpeed = -0.4;
    cell.velocity = 50;
    cell.velocityRange = 50;
    cell.emissionRange = M_PI * 2;
    emitter.emitterCells = @[cell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
