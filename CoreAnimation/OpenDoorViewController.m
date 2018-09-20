//
//  OpenDoorViewController.m
//  CoreAnimation
//
//  Created by XZM_XHY on 15/6/23.
//  Copyright (c) 2015年 HY. All rights reserved.
//

#import "OpenDoorViewController.h"

NSString *const kRotationKye = @"kRotationKye";

@interface OpenDoorViewController ()
@property (nonatomic, weak) IBOutlet UIImageView *door;
@end

@implementation OpenDoorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.door.layer.anchorPoint = CGPointMake(0, 0.5);
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openDoor
{
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    self.door.layer.transform = perspective;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation.toValue = @(-M_PI_2);
    animation.duration = 2.0;
    animation.repeatDuration = 2;
    animation.autoreverses = YES;
    self.door.layer.speed = 1.0;
    [self.door.layer addAnimation:animation forKey:nil];
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    if (![self.door.layer animationForKey:kRotationKye]) {
        CATransform3D perspective = CATransform3DIdentity;
        perspective.m34 = -1.0 / 500.0;
        self.door.layer.transform = perspective;
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
        animation.toValue = @(-M_PI_2);
        animation.duration = 2.0;
        animation.repeatDuration = INFINITY;
        animation.autoreverses = YES;
        self.door.layer.speed = 0.0;
        [self.door.layer addAnimation:animation forKey:kRotationKye];
    }
    
    CGFloat x = [pan translationInView:self.view].x;
    x /= 200.0f;
    CFTimeInterval timeOffset = self.door.layer.timeOffset;
    timeOffset = MIN(0.999, MAX(0.0, timeOffset - x));
    self.door.layer.timeOffset = timeOffset;
    [pan setTranslation:CGPointZero inView:self.view];
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
