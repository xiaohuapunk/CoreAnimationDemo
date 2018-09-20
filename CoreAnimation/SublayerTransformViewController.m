//
//  SublayerTransformViewController.m
//  CoreAnimation
//
//  Created by XZM_XHY on 15/6/9.
//  Copyright (c) 2015年 HY. All rights reserved.
//

#import "SublayerTransformViewController.h"

@interface SublayerTransformViewController ()

@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, weak) IBOutlet UIImageView *imvA;
@property (nonatomic, weak) IBOutlet UIImageView *imvB;

@end

@implementation SublayerTransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // 设置容器试图的sublayerTransform
    CATransform3D __transform4Perspective = CATransform3DIdentity;
    __transform4Perspective.m34 = -1.0 / 500.0;
    self.containerView.layer.sublayerTransform = __transform4Perspective;
    
    [self setTrasformViewINterFaceSizeClass:UIUserInterfaceSizeClassRegular];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTrasformViewINterFaceSizeClass:(UIUserInterfaceSizeClass)sizeClass
{
    // 横屏
    if (sizeClass == UIUserInterfaceSizeClassCompact) {
        
        CATransform3D transform4A = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
        self.imvA.layer.transform = transform4A;
        
        CATransform3D transform4B = CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
        self.imvB.layer.transform = transform4B;
        
    } else {
        
        CATransform3D transform4A = CATransform3DMakeRotation(-M_PI_4, 1, 0, 0);
        self.imvA.layer.transform = transform4A;
        
        CATransform3D transform4B = CATransform3DMakeRotation(M_PI_4, 1, 0, 0);
        self.imvB.layer.transform = transform4B;
        
    }
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super willTransitionToTraitCollection:newCollection
                 withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        [self setTrasformViewINterFaceSizeClass:newCollection.verticalSizeClass];
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
    }];
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
