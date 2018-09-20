//
//  ContentsViewController.m
//  CoreAnimation
//
//  Created by XZM_XHY on 15/5/25.
//  Copyright (c) 2015年 HY. All rights reserved.
//

#import "ContentsViewController.h"

@interface ContentsViewController ()

@property (weak, nonatomic) IBOutlet UIView *layerView;

@property (weak, nonatomic) IBOutlet UIImageView *imv;

@end

@implementation ContentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *image = [UIImage imageNamed:@"monkey"];
    self.layerView.layer.contents = (__bridge id)(image.CGImage);
    
    self.layerView.layer.contentsGravity = kCAGravityCenter;
    self.layerView.layer.contentsScale = [UIScreen mainScreen].scale;
    
    self.imv.layer.anchorPoint = CGPointMake(1, 1);
    
//    self.layerView.layer.contentsGravity = kCAGravityResizeAspect;
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
