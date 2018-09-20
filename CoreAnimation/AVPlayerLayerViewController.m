//
//  AVPlayerLayerViewController.m
//  CoreAnimation
//
//  Created by XZM_XHY on 15/6/17.
//  Copyright (c) 2015年 HY. All rights reserved.
//

#import "AVPlayerLayerViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AVPlayerLayerViewController ()
@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *indicatorView;
@property (nonatomic, assign) BOOL isPlaying;
@end

@implementation AVPlayerLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"viewDidLoad");
    
    // 初始化不自动播放
    self.isPlaying = NO;
    
    // 视频连接
    NSURL *URL = [NSURL URLWithString:@"http://video.xinzhimei.com/order/video/2015/d8dd9df51dd2190be7dca3c25ecc2981.mp4"];
    
    // 初始化player
    AVPlayer *player = [AVPlayer playerWithURL:URL];
    // 初始化playerLayer
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    _playerLayer.backgroundColor = [UIColor blackColor].CGColor;
    [self.containerView.layer addSublayer:_playerLayer];
    
    // 添加一个矩阵变换
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / 500.0;
    transform = CATransform3DRotate(transform, M_PI_4 / 2, 1, 0, 0);
    transform = CATransform3DTranslate(transform, 0, -20, 0);
    _playerLayer.transform = transform;
    
    _playerLayer.masksToBounds = YES;
    _playerLayer.cornerRadius = 30;
    _playerLayer.borderColor = [UIColor redColor].CGColor;
    _playerLayer.borderWidth = 5;
    
    // kvo监听播放状态
    [self.playerLayer.player addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    // 通知中心监听播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    UIBarButtonItem *playItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(play:)];
    self.navigationItem.rightBarButtonItem = playItem;
    playItem.enabled = NO;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayer *player = (AVPlayer *)object;
        if (player.status == AVPlayerStatusReadyToPlay) {
            [self.indicatorView stopAnimating];
            UIBarButtonItem *item = self.navigationItem.rightBarButtonItem;
            item.enabled = YES;
        }
    }
}

- (void)playEnd
{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  layout 后 更新播放器图层frame
 */
- (void)viewDidLayoutSubviews
{
    NSLog(@"viewDidLayoutSubviews");
    CGRect rect4Layer = self.containerView.bounds;
    _playerLayer.frame = rect4Layer;
}

- (void)play:(UIBarButtonItem *)sender
{
    if (self.isPlaying) {
        [self.playerLayer.player pause];
        UIBarButtonItem *playItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(play:)];
        self.navigationItem.rightBarButtonItem = playItem;
    } else {
        if (self.playerLayer.player.status != AVPlayerStatusReadyToPlay) {
            [self.indicatorView startAnimating];
        }
        
        [self.playerLayer.player play];
        UIBarButtonItem *playItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPause target:self action:@selector(play:)];
        self.navigationItem.rightBarButtonItem = playItem;
    }
    
    self.isPlaying = !self.isPlaying;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (_playerLayer) {
        [_playerLayer.player removeObserver:self forKeyPath:@"status"];
    }
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
