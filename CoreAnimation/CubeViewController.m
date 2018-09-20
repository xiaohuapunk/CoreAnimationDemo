//
//  CubeViewController.m
//  CoreAnimation
//
//  Created by XZM_XHY on 15/6/12.
//  Copyright (c) 2015年 HY. All rights reserved.
//

#import "CubeViewController.h"
#import <GLKit/GLKit.h>

#define LIGHT_DIRECTION 0, 1, -0.5
#define AMBIENT_LIGHT 0.5

@interface CubeViewController ()

@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *faces;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat angle;

@end

@implementation CubeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.angle = 1.0;
    
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
    self.containerView.layer.sublayerTransform = perspective;
    
    // face1
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 75);
    [self addFace:0 withTransform:transform];
    
    // face2
    transform = CATransform3DMakeTranslation(75, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFace:1 withTransform:transform];
    
    // face3
    transform = CATransform3DMakeTranslation(0, -75, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:2 withTransform:transform];
    
    // face4
    transform = CATransform3DMakeTranslation(0, 75, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addFace:3 withTransform:transform];
    
    // face5
    transform = CATransform3DMakeTranslation(-75, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [self addFace:4 withTransform:transform];
    
    // face6
    transform = CATransform3DMakeTranslation(0, 0, -75);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addFace:5 withTransform:transform];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(rotateTheCube) userInfo:nil repeats:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

/**
 *  计算正太向量 设置阴影
 *
 */
- (void)applyLightingToFace:(CALayer *)face
{
    //add lighting layer
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 150, 150);
    [face addSublayer:layer];
    //convert the face transform to matrix
    //(GLKMatrix4 has the same structure as CATransform3D)
    CATransform3D transform = face.transform;
    GLKMatrix4 matrix4 = *(GLKMatrix4 *)&transform;
    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
    //get face normal
    GLKVector3 normal = GLKVector3Make(0, 0, 1);
    normal = GLKMatrix3MultiplyVector3(matrix3, normal);
    normal = GLKVector3Normalize(normal);
    //get dot product with light direction
    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION));
    float dotProduct = GLKVector3DotProduct(light, normal);
    //set lighting layer opacity
    CGFloat shadow = 1 + dotProduct - AMBIENT_LIGHT;
    UIColor *color = [UIColor colorWithWhite:0 alpha:shadow];
    layer.backgroundColor = color.CGColor;
}

/**
 *  view设置transform
 *
 *  @param index     view的下标
 *  @param transform 矩阵变化
 */
- (void)addFace:(NSInteger)index withTransform:(CATransform3D)transform
{
    UIView *face = self.faces[index];
    face.layer.transform = transform;
    face.layer.doubleSided = NO;
    face.layer.borderColor = [UIColor lightGrayColor].CGColor;
    face.layer.borderWidth = 0.5;
    
    if (index != 2) {
        face.userInteractionEnabled = NO;
    }
    
//    [self applyLightingToFace:face.layer];
}

/**
 *  timer 动画
 */
- (void)rotateTheCube
{
    self.angle++;
    CGFloat __angle = self.angle * M_PI / 180;
  
    CATransform3D perspective = self.containerView.layer.transform;
//    perspective.m34 = -1.0 / 500.0;
    perspective = CATransform3DRotate(perspective, __angle, 0, 1, 0);
    perspective = CATransform3DRotate(perspective, -35*M_PI/180, 1, 0, 0);
    self.containerView.layer.sublayerTransform = perspective;
}

- (IBAction)btnClicked:(id)sender
{
    NSLog(@"点击了........");
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
