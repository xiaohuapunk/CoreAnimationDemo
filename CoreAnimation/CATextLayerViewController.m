//
//  CATextLayerViewController.m
//  CoreAnimation
//
//  Created by XZM_XHY on 15/6/15.
//  Copyright (c) 2015年 HY. All rights reserved.
//

#import "CATextLayerViewController.h"
#import <CoreText/CoreText.h>

@interface CATextLayerViewController ()

@end

@implementation CATextLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createSimpleTextLayer];
    
    [self richText];
}

- (void)createSimpleTextLayer
{
    //
    // 简易的用法
    //
    // create CATextLayer
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width - 20, 150);
    textLayer.backgroundColor = [UIColor whiteColor].CGColor;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.view.layer addSublayer:textLayer];
    
    // set text attributes
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    
    // choose a font
    UIFont *font = [UIFont systemFontOfSize:15];
    
    // set layer font
    CFStringRef fontName = (__bridge CFStringRef)(font.fontName);
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc elementum, libero ut porttitor dictum, diam odio congue lacus, vel fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet lobortis";
    
    // set text
    textLayer.string = text;
}

- (void)richText
{
    // 初始化 TextLayer
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = CGRectMake(10, 260, [UIScreen mainScreen].bounds.size.width - 20, 150);
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    textLayer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.view.layer addSublayer:textLayer];
    
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    
    // 设置字体
    UIFont *font = [UIFont systemFontOfSize:15];
    CFStringRef fontName = (__bridge CFStringRef)(font.fontName);
    CGFloat fontSize = font.pointSize;
    CTFontRef fontRef = CTFontCreateWithName(fontName, fontSize, NULL);
    
    // 创建 AttributedString
    NSDictionary *attribs = @{
                              (__bridge id)kCTForegroundColorAttributeName:(__bridge id)[UIColor blackColor].CGColor,
                              (__bridge id)kCTFontAttributeName:(__bridge id)fontRef
                              };
    
    NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc elementum, libero ut porttitor dictum, diam odio congue lacus, vel fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet lobortis";
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
    [string setAttributes:attribs range:NSMakeRange(0, [text length])];
    
    // 突出显示 下划线
    attribs = @{
                (__bridge id)kCTForegroundColorAttributeName: (__bridge id)[UIColor redColor].CGColor,
                (__bridge id)kCTUnderlineStyleAttributeName: @(kCTUnderlineStyleSingle),
                (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
                };
    [string setAttributes:attribs range:NSMakeRange(6, 5)];
    
    CFRelease(fontRef);
    
    textLayer.string = string;
    
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
