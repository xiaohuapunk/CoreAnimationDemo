//
//  kCAFilterViewController.m
//  CoreAnimation
//
//  Created by XZM_XHY on 15/6/9.
//  Copyright (c) 2015年 HY. All rights reserved.
//

#import "kCAFilterViewController.h"

@interface kCAFilterViewController ()

@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *digitViews;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation kCAFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *__digits = [UIImage imageNamed:@"digits"];
    
    for (UIView *__view in self.digitViews) {
        __view.layer.magnificationFilter = kCAFilterNearest;
        __view.layer.contents = (__bridge id)(__digits.CGImage);
        __view.layer.contentsRect = CGRectMake(0, 0, 0.1, 1.0);
        __view.layer.contentsGravity = kCAGravityResizeAspect;
    }
    
    // start timer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    [self tick];
}

- (void)setDigit:(NSInteger)digit forView:(UIView *)view
{
    view.layer.contentsRect = CGRectMake(digit * 0.1, 0, 0.1, 1.0);
}

- (void)tick
{
    NSLog(@"tick");
    
    NSCalendar *__calendar = [NSCalendar currentCalendar];
    NSUInteger __units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *__components = [__calendar components:__units fromDate:[NSDate date]];
    
    // 时钟
    [self setDigit:__components.hour / 10 forView:self.digitViews[0]];
    [self setDigit:__components.hour % 10 forView:self.digitViews[1]];
    // 分钟
    [self setDigit:__components.minute / 10 forView:self.digitViews[2]];
    [self setDigit:__components.minute % 10 forView:self.digitViews[3]];
    // 秒
    [self setDigit:__components.second / 10 forView:self.digitViews[4]];
    [self setDigit:__components.second % 10 forView:self.digitViews[5]];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)dealloc
{
    NSLog(@"dealloc");
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
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
