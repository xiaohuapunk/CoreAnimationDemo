//
//  CAShapeLayerViewController.m
//  CoreAnimation
//
//  Created by XZM_XHY on 15/6/12.
//  Copyright (c) 2015年 HY. All rights reserved.
//

#import "CAShapeLayerViewController.h"

@interface CAShapeLayerViewController ()

@property (nonatomic, weak) IBOutlet UIView *containerView;

@end

@implementation CAShapeLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 利用BezzierPath构造路径
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(175, 100)];
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    // ShapeLayer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 1.0;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    
    [self.containerView.layer addSublayer:shapeLayer];
    
    
    CGRect rect = CGRectMake(230, 100, 100, 100);
    CGSize radii = CGSizeMake(20, 20);
    UIRectCorner corners = UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
    
    UIBezierPath *aPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer *aShapeLayer = [CAShapeLayer layer];
    aShapeLayer.strokeColor = [UIColor redColor].CGColor;
    aShapeLayer.fillColor = [UIColor clearColor].CGColor;
    aShapeLayer.lineWidth = 2;
    aShapeLayer.lineJoin = kCALineJoinRound;
    aShapeLayer.lineCap = kCALineCapRound;
    aShapeLayer.path = aPath.CGPath;
    [self.containerView.layer addSublayer:aShapeLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
