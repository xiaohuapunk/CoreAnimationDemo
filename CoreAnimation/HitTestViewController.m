//
//  HitTestViewController.m
//  CoreAnimation
//
//  Created by XZM_XHY on 15/5/25.
//  Copyright (c) 2015年 HY. All rights reserved.
//

#import "HitTestViewController.h"

@interface HitTestViewController ()

@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UIView *blueView;

@end

@implementation HitTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    CGPoint __pt = [[touches anyObject] locationInView:self.view];
    
    // 获取点击的layer
    CALayer *__layer = [self.view.layer hitTest:__pt];
    
    NSString *__message = @"点击外围";
    if (__layer == self.whiteView.layer) {
        __message = @"点击白色试图";
    } else if (__layer == self.blueView.layer) {
        __message = @"点击蓝色试图";
    }
    UIAlertView *__alert = [[UIAlertView alloc] initWithTitle:@"提示" message:__message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [__alert show];
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
