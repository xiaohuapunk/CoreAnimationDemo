//
//  TransformViewController.m
//  CoreAnimation
//
//  Created by XZM_XHY on 15/5/25.
//  Copyright (c) 2015年 HY. All rights reserved.
//

#import "TransformViewController.h"

@interface TransformViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imv;
@property (assign, nonatomic) CGAffineTransform transform;

@end

@implementation TransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)leftTransform:(id)sender
{
//    [UIView animateWithDuration:0.5 animations:^{
//        // UIView
//        //    self.imv.transform = CGAffineTransformRotate(self.imv.transform, -90 * M_PI / 180);
//        
//        // Layer affineTransform
//        CGAffineTransform transform = CGAffineTransformRotate(self.imv.transform, -90 * M_PI / 180);
//        self.imv.layer.affineTransform = transform;
//    }];
    
    // Layer transform
    CATransform3D transform = CATransform3DRotate(self.imv.layer.transform, -90 * M_PI / 180, 0, 0, 1);
    self.imv.layer.transform = transform;
    
}

- (IBAction)rightTransform:(id)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        // UIView
        //    self.imv.transform = CGAffineTransformRotate(self.imv.transform, 90 * M_PI / 180);
        
        // Layer affineTransform
//        CGAffineTransform transform = CGAffineTransformRotate(self.imv.transform, 90 * M_PI / 180);
//        self.imv.layer.affineTransform = transform;
        
        CATransform3D transform = self.imv.layer.transform;
        transform.m34 = -1 / 500.0;
        transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
        self.imv.layer.transform = transform;
    }];
}

- (CGAffineTransform)CGAffineTransformMarkShearX:(CGFloat)x Y:(CGFloat)y
{
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform.c = -x;
    transform.b = y;
    return transform;
}

- (IBAction)shearTransform:(id)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        self.imv.layer.affineTransform = [self CGAffineTransformMarkShearX:1 Y:0];
    }];
    
}

- (IBAction)cancelShearTransform:(id)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        self.imv.layer.affineTransform = [self CGAffineTransformMarkShearX:0 Y:0];
    }];
    
}

- (IBAction)transformReverse:(id)sender
{
    [UIView animateWithDuration:0.5 animations:^{
       
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -1 / 500.0;
        transform = CATransform3DRotate(transform, - M_PI, 0, 1, 0);
        self.imv.layer.transform = transform;
    }];
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
