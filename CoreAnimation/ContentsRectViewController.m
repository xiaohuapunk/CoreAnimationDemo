//
//  ContentsRectViewController.m
//  CoreAnimation
//
//  Created by XZM_XHY on 15/5/25.
//  Copyright (c) 2015年 HY. All rights reserved.
//

#import "ContentsRectViewController.h"

@interface ContentsRectViewController ()

@property (weak, nonatomic) IBOutlet UIView *layerView1;
@property (weak, nonatomic) IBOutlet UIView *layerView2;
@property (weak, nonatomic) IBOutlet UIView *layerView3;
@property (weak, nonatomic) IBOutlet UIView *layerView4;

@end

@implementation ContentsRectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        CGFloat scale = [UIScreen mainScreen].scale;
        self.layerView1.layer.contentsScale = scale;
        self.layerView1.layer.contentsGravity = kCAGravityCenter;
        
        self.layerView2.layer.contentsScale = scale;
        self.layerView2.layer.contentsGravity = kCAGravityCenter;
        
        self.layerView3.layer.contentsScale = scale;
        self.layerView3.layer.contentsGravity = kCAGravityCenter;
        
        self.layerView4.layer.contentsScale = scale;
        self.layerView4.layer.contentsGravity = kCAGravityCenter;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *image = [UIImage imageNamed:@"monkey"];

    self.layerView1.layer.contents = (__bridge id)(image.CGImage);
    self.layerView1.layer.contentsRect = CGRectMake(0, 0, 0.5, 0.5);
    
    self.layerView2.layer.contents = (__bridge id)(image.CGImage);
    self.layerView2.layer.contentsRect = CGRectMake(0.5, 0, 0.5, 0.5);
    
    self.layerView3.layer.contents = (__bridge id)(image.CGImage);
    self.layerView3.layer.contentsRect = CGRectMake(0, 0.5, 0.5, 0.5);
    
    self.layerView4.layer.contents = (__bridge id)(image.CGImage);
    self.layerView4.layer.contentsRect = CGRectMake(0.5, 0.5, 0.5, 0.5);
    
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
