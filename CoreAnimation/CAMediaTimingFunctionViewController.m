//
//  CAMediaTimingFunctionViewController.m
//  CoreAnimation
//
//  Created by XZM_XHY on 15/6/24.
//  Copyright (c) 2015年 HY. All rights reserved.
//

#import "CAMediaTimingFunctionViewController.h"

@interface CAMediaTimingFunctionViewController ()
@property (nonatomic, strong) CALayer *colorLayer;
@property (nonatomic, strong) UIView *colorView;
@end

@implementation CAMediaTimingFunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(0, 0, 100, 100);
    self.colorLayer.backgroundColor = [UIColor grayColor].CGColor;
    [self.view.layer addSublayer:self.colorLayer];
    
    self.colorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.colorView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.colorView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    self.colorLayer.position = self.view.center;
    self.colorView.center = self.view.center;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pt = [[touches anyObject] locationInView:self.view];
    
//    [CATransaction begin];
//    [CATransaction setAnimationDuration:3.0];
//    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//    self.colorLayer.position = pt;
//    [CATransaction commit];
    
    [UIView animateWithDuration:3.0
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.colorView.center = pt;
                     }
                     completion:NULL];
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
