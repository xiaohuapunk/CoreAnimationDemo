//
//  BallDropAnimationViewController.m
//  CoreAnimation
//
//  Created by XZM_XHY on 15/6/24.
//  Copyright (c) 2015年 HY. All rights reserved.
//

#import "BallDropAnimationViewController.h"

@interface BallDropAnimationViewController ()
@property (nonatomic, weak) IBOutlet UIImageView *ball;
@property (nonatomic, weak) IBOutlet UIView *floor;
@property (nonatomic, assign) CGSize size4Ball;
@property (nonatomic, assign) CGPoint center4Ball;
@property (nonatomic, assign) CGPoint center4Floor;
@property (nonatomic, assign) CGFloat fallHeight;
@property (nonatomic, assign) CGFloat endPositionY;
@property (nonatomic, assign) CGFloat currFallHeight;

//@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) CADisplayLink *timer;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) NSTimeInterval timeOffset;
@property (nonatomic, assign) NSTimeInterval lastStep;
@property (nonatomic, strong) id fromValue;
@property (nonatomic, strong) id toValue;

@end

@implementation BallDropAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    self.size4Ball = self.ball.frame.size;
    self.center4Ball = self.ball.center;
    self.center4Floor = self.floor.center;
    self.endPositionY = self.center4Floor.y - self.size4Ball.height / 2 + 10;
    self.fallHeight = self.endPositionY - self.center4Ball.y;
    self.currFallHeight = self.center4Ball.y;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    [self animation];
}

//- (void)animation
//{
//    [CATransaction begin];
//    [CATransaction setDisableActions:YES];
//    [CATransaction setCompletionBlock:^{
//        self.ball.center = CGPointMake(self.center4Ball.x, self.center4Floor.y - self.size4Ball.height / 2 + 10);
//    }];
//    
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    animation.duration = 4.0;
//    animation.delegate = self;
//    animation.values = @[
//                         [NSValue valueWithCGPoint:self.center4Ball],
//                         [NSValue valueWithCGPoint:CGPointMake(self.center4Ball.x, self.endPositionY)],
//                         [NSValue valueWithCGPoint:CGPointMake(self.center4Ball.x, [self getCurrFallHeight])],
//                         [NSValue valueWithCGPoint:CGPointMake(self.center4Ball.x, self.endPositionY)],
//                         [NSValue valueWithCGPoint:CGPointMake(self.center4Ball.x, [self getCurrFallHeight])],
//                         [NSValue valueWithCGPoint:CGPointMake(self.center4Ball.x, self.endPositionY)],
//                         [NSValue valueWithCGPoint:CGPointMake(self.center4Ball.x, [self getCurrFallHeight])],
//                         [NSValue valueWithCGPoint:CGPointMake(self.center4Ball.x, self.endPositionY)]
//                         ];
//    animation.timingFunctions = @[
//                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
//                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
//                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
//                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
//                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
//                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
//                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn]
//                                  ];
//    animation.keyTimes = @[@0.0, @0.25, @0.45, @0.65, @0.75, @0.85, @0.9, @0.99];
//    [self.ball.layer addAnimation:animation forKey:nil];
//    
//    [CATransaction commit];
//}


//- (void)animation
//{
//    
//    [CATransaction begin];
//    [CATransaction setCompletionBlock:^{
//        self.ball.center = CGPointMake(self.center4Ball.x, self.center4Floor.y - self.size4Ball.height / 2 + 10);
//    }];
//    
//    NSValue *fromValue = [NSValue valueWithCGPoint:self.center4Ball];
//    NSValue *toValue = [NSValue valueWithCGPoint:CGPointMake(self.center4Ball.x, self.endPositionY)];
//    
//    CFTimeInterval duration = 2;
//    NSInteger numFrames = duration * 30;
//    NSMutableArray *frames = [NSMutableArray array];
//    for (int i = 0; i < numFrames; i++) {
//        float time = 1 / (float)numFrames * i;
//        time = bounceEaseOut(time);
//        [frames addObject:[self interpolateFromValue:fromValue toValue:toValue time:time]];
//    }
//    
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
//    animation.keyPath = @"position";
//    animation.duration = duration;
//    animation.values = frames;
//    animation.delegate = self;
//    [self.ball.layer addAnimation:animation forKey:nil];
//    
//    [CATransaction commit];
//}

//- (void)animation
//{
//    self.duration = 1.0;
//    self.timeOffset = 0.0;
//    self.fromValue = [NSValue valueWithCGPoint:self.center4Ball];
//    self.toValue = [NSValue valueWithCGPoint:CGPointMake(self.center4Ball.x, self.endPositionY)];
//    
//    [self.timer invalidate];
//    
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1/60.0
//                                                  target:self
//                                                selector:@selector(step:)
//                                                userInfo:nil
//                                                 repeats:YES];
//}


//- (void)step:(NSTimer *)step
//{
//    self.timeOffset = MIN(self.timeOffset + 1/60.0, self.duration);
//    float time = self.timeOffset / self.duration;
//    time = bounceEaseOut(time);
//    id position = [self interpolateFromValue:self.fromValue
//                                     toValue:self.toValue
//                                        time:time];
//    self.ball.center = [position CGPointValue];
//    
//    if (self.timeOffset >= self.duration) {
//        [self.timer invalidate];
//        self.timer = nil;
//    }
//}

- (void)animation
{
    self.duration = 1.0;
    self.timeOffset = 0.0;
    self.fromValue = [NSValue valueWithCGPoint:self.center4Ball];
    self.toValue = [NSValue valueWithCGPoint:CGPointMake(self.center4Ball.x, self.endPositionY)];
    
    [self.timer invalidate];
    
    self.lastStep = CACurrentMediaTime();
    
    self.timer = [CADisplayLink displayLinkWithTarget:self
                                             selector:@selector(step:)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)step:(CADisplayLink *)timer
{
    CFTimeInterval thisStep = CACurrentMediaTime();
    CFTimeInterval stepDuration = thisStep - self.lastStep;
    self.lastStep = thisStep;
    self.timeOffset = MIN(self.timeOffset + stepDuration, self.duration);
    float time = self.timeOffset / self.duration;
    time = bounceEaseOut(time);
    id position = [self interpolateFromValue:self.fromValue toValue:self.toValue time:time];
    self.ball.center = [position CGPointValue];
    if (self.timeOffset >= self.duration) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.ball.center = CGPointMake(self.center4Ball.x, self.center4Floor.y - self.size4Ball.height / 2 + 10);
}

- (CGFloat)getCurrFallHeight
{
    self.fallHeight /= 2;
    self.currFallHeight += self.fallHeight;
    return self.currFallHeight;
}

float interpolate(float from, float to, float time)
{
    return (to - from) * time + from;
}

- (id)interpolateFromValue:(id)fromValue toValue:(id)toValue time:(float)time
{
    if ([fromValue isKindOfClass:[NSValue class]]) {
        const char *type = [fromValue objCType];
        if (strcmp(type, @encode(CGPoint)) == 0) {
            CGPoint from = [fromValue CGPointValue];
            CGPoint to = [toValue CGPointValue];
            CGPoint result = CGPointMake(interpolate(from.x, to.x, time), interpolate(from.y, to.y, time));
            return [NSValue valueWithCGPoint:result];
        }
    }
    return (time < 0.5) ? fromValue : toValue;
}

float bounceEaseOut(float t)
{
    if (t < 4/11.0) {
        return (121 * t * t)/16.0;
    } else if (t < 8/11.0) {
        return (363/40.0 * t * t) - (99/10.0 * t) + 17/5.0;
    } else if (t < 9/10.0) {
        return (4356/361.0 * t * t) - (35442/1805.0 * t) + 16061/1805.0;
    }
    return (54/5.0 * t * t) - (513/25.0 * t) + 268/25.0;
}

float quadraticEaseInOut(float t)
{
    return (t < 0.5)? (2 * t * t): (-2 * t * t) + (4 * t) - 1;
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
