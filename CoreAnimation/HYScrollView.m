//
//  HYScrollView.m
//  CoreAnimation
//
//  Created by XZM_XHY on 15/6/17.
//  Copyright (c) 2015年 HY. All rights reserved.
//

#import "HYScrollView.h"

@implementation HYScrollView

+ (Class)layerClass
{
    return [CAScrollLayer class];
}

- (void)setup
{
    self.layer.masksToBounds = YES;
    
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:recognizer];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)pan:(UIPanGestureRecognizer *)recofnizer
{
    CGPoint offset = self.bounds.origin;
    
    offset.x -= [recofnizer translationInView:self].x;
    offset.y -= [recofnizer translationInView:self].y;
    
    [(CAScrollLayer *)self.layer scrollPoint:offset];
    
    [recofnizer setTranslation:CGPointZero inView:self];
}

@end
