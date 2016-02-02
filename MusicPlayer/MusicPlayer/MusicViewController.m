//
//  MusicViewController.m
//  MusicPlayer
//
//  Created by 李超 on 16/1/29.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "MusicViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <Masonry.h>

@interface MusicViewController()<AVAudioPlayerDelegate,
   UITableViewDataSource,UITableViewDelegate>

//记忆标识
@property (assign, nonatomic) BOOL isPlay;
@property (strong, nonatomic) UIView *backGroundView;   //背景
@property (strong, nonatomic) UIButton *playButton; //播放按钮
@property (strong, nonatomic) UIButton *next;  //下一首
@property (strong, nonatomic) UIButton *previous;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer; //播放器
@property (strong, nonatomic) UISlider *progressSlider; //进度条
@property (strong, nonatomic) NSTimer *progressUpdateTimer; // 计时器
@property (strong, nonatomic) UILabel *currentTimeLabel; //当前时间
@property (strong, nonatomic) UILabel *totalTimeLabel;  //总时间显示

@property (strong, nonatomic) NSMutableArray *lrcTimeAry; //存储字典的key值
@property (strong, nonatomic) NSMutableDictionary *lrcDic;  //存储歌词
@property (strong, nonatomic) NSArray *dataArray;

@property (strong, nonatomic) UITableView *lrcTableView;   //歌词显示

@property (assign, nonatomic) NSInteger line;   //进度条显示下划线


@end

@implementation MusicViewController

- (UIView *)backGroundView{
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] init];
        _backGroundView.backgroundColor = [UIColor lightGrayColor];
        _backGroundView.alpha = 0.5;
    }
    return _backGroundView;
}

- (UISlider *)progressSlider{
    if (_progressSlider == nil) {
        _progressSlider = [[UISlider alloc] init];
        [_progressSlider addTarget:self action:@selector(slide:)
            forControlEvents:UIControlEventValueChanged];
    }
    return _progressSlider;
}

- (UIButton *)playButton{
    if (_playButton == nil) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _playButton.showsTouchWhenHighlighted = YES;
//        UIImageView *image = [[UIImageView alloc]
//           initWithImage:[UIImage imageNamed:@"play.png"]];
//        [_playButton addSubview:image];
        
        [_playButton setBackgroundImage:[UIImage imageNamed:@"play.png"]
            forState:UIControlStateNormal];

        [_playButton addTarget:self action:@selector(clickPlay:)
           forControlEvents:UIControlEventTouchUpInside];
                              
    }
    return _playButton;
}

- (UIButton *)next{
    if (_next == nil) {
        _next = [UIButton buttonWithType:UIButtonTypeCustom];
        _next.showsTouchWhenHighlighted = YES;
        UIImageView *image = [[UIImageView alloc]
           initWithImage:[UIImage imageNamed:@"down.png"]];
        [_next addSubview:image];
        [_next addTarget:self action:@selector(next:)
            forControlEvents:UIControlEventTouchUpInside];
    }
    return _next;
}

- (UIButton *)previous{
    if (_previous == nil) {
        _previous = [UIButton buttonWithType:UIButtonTypeCustom];
        _previous.showsTouchWhenHighlighted = YES;
        UIImageView *image = [[UIImageView alloc]
           initWithImage:[UIImage imageNamed:@"up.png"]];
        [_previous addSubview:image];
        [_previous addTarget:self action:@selector(previous:)
            forControlEvents:UIControlEventTouchUpInside];
    }
    return _previous;
}

- (UILabel *)currentTimeLabel{
    if (_currentTimeLabel == nil) {
        _currentTimeLabel = [[UILabel alloc] init];
        _currentTimeLabel.textColor = [UIColor whiteColor];
    }
    return _currentTimeLabel;
}

- (UILabel *)totalTimeLabel{
    if (_totalTimeLabel == nil) {
        _totalTimeLabel = [[UILabel alloc] init];
        _totalTimeLabel.textColor = [UIColor whiteColor];
    }
    return _totalTimeLabel;
}

- (UITableView *)lrcTableView{
    if (_lrcTableView == nil) {
        _lrcTableView = [[UITableView alloc] initWithFrame:
            CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height-110-43)
            style:UITableViewStylePlain];
        _lrcTableView.backgroundColor = [UIColor clearColor];
        _lrcTableView.dataSource = self;
        _lrcTableView.delegate = self;
        _lrcTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
       // _lrcTableView.alpha = 0;

    }
    return _lrcTableView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageView = [[UIImageView alloc]
        initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"1.jpeg"];
    
    [self.view addSubview:imageView];
    
    //自动布局
    
    [self.view addSubview:self.backGroundView];
    
    [self.view addSubview:self.lrcTableView];
    
    [self.view addSubview:self.progressSlider];
    
    [self.backGroundView addSubview:self.playButton];
    
    [self.backGroundView addSubview:self.next];
    
    [self.backGroundView addSubview:self.previous];
    
    [self.backGroundView addSubview:self.currentTimeLabel];
    
    [self.backGroundView addSubview:self.totalTimeLabel];
    
    
    [self.backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
        make.right.mas_equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(@110);
    }];
    
    [self.progressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(0);
        make.bottom.mas_equalTo(self.backGroundView.mas_top).offset(0);
        make.right.mas_equalTo(self.backGroundView.mas_right).offset(0);
        make.height.mas_equalTo(@2);
    }];
    
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backGroundView.mas_top).offset(22.5);
        make.centerX.mas_equalTo(self.backGroundView.mas_centerX);
      //  make.centerY.mas_equalTo(self.backGroundView.mas_centerY);
        make.width.mas_equalTo(@75);
        make.height.mas_equalTo(@75);
    }];
    
    [self.next mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backGroundView.mas_top).offset(20);
        make.right.mas_equalTo(self.backGroundView.mas_right).offset(-15);
        make.width.mas_equalTo(@75);
        make.height.mas_equalTo(@75);
    }];
    
    [self.previous mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backGroundView.mas_top).offset(20);
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.width.mas_equalTo(@75);
        make.height.mas_equalTo(@75);
    }];
    
    [self.currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backGroundView.mas_top).offset(5);
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(2);
        make.width.mas_equalTo(@48);
        make.height.mas_equalTo(@21);
    }];
    
    [self.totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backGroundView.mas_top).offset(5);
        make.right.mas_equalTo(self.backGroundView.mas_right).offset(-2);
        make.width.mas_equalTo(@48);
        make.height.mas_equalTo(@21);
    }];
    
    
    self.dataArray =@[@"情非得已",@"情非得已",@"情非得已"];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:
        [NSString stringWithFormat:@"%@",_dataArray[0]] ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    NSError *error = nil;
    
    //初始化一个播放器
    self.audioPlayer = [[AVAudioPlayer alloc]
        initWithContentsOfURL:url error:&error];
    
    if (error == nil) {
        NSLog(@"正常播放");
    }else{
        NSLog(@"播放失败%@",error);
    }
    
    self.audioPlayer.delegate = self;
    
    
    [self.lrcTableView reloadData];
    //加载歌词
    [self parserLrc];
}

#pragma mark - 解析歌词
- (void)parserLrc{
    //读取歌词内容
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",_dataArray[0]] ofType:@"lrc"];
    NSString *contentStr = [NSString stringWithContentsOfFile:path
        encoding:NSUTF8StringEncoding error:nil];
    
    self.lrcDic = [NSMutableDictionary dictionaryWithCapacity:0];
    self.lrcTimeAry = [NSMutableArray arrayWithCapacity:0];
    
    //换行进行分割,获取每一行的歌词
    NSArray *linArr = [contentStr componentsSeparatedByString:@"\n"];
    
    //遍历歌词
    for (NSString *string in linArr) {
        if(string.length >7 ){
            NSString *str1 = [string substringWithRange:NSMakeRange(3, 1)];
            NSString *str2 = [string substringWithRange:NSMakeRange(6, 1)];
            if ([str1 isEqualToString:@":"] && [str2 isEqualToString:@"."]) {
                //截取歌词和时间
                NSString *timeStr = [string substringWithRange:
                    NSMakeRange(1, 5)];
                NSString *lrcStr = [string substringFromIndex:10];
                //放入集合中
                [self.lrcTimeAry addObject:timeStr];
                [self.lrcDic setObject:lrcStr forKey:timeStr];
            }
        }
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   // NSLog(@"count = %lu",self.lrcTimeAry.count);
    return self.lrcTimeAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
  //  NSLog(@"reload = %lu",self.lrcTimeAry.count);

    
    static NSString *cellId = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
            reuseIdentifier:cellId];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }

    NSString *key = self.lrcTimeAry[indexPath.row];

    cell.textLabel.text = self.lrcDic[key];
    
    //改变tableLabel样式
    if (indexPath.row == self.line) {
        cell.textLabel.font = [UIFont systemFontOfSize:20.0];
        cell.textLabel.textColor = [UIColor blueColor];
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:15.0];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    return cell;
}

//远程控制
- (void)remoteControlReceivedWithEvent:(UIEvent *)event{
    switch (event.subtype) {
        case UIEventSubtypeRemoteControlPlay:
            NSLog(@"播放");
            break;
        case UIEventSubtypeRemoteControlStop:
            NSLog(@"停止播放");
            break;
        case UIEventSubtypeRemoteControlPause:
            NSLog(@"暂停");
            break;
        case UIEventSubtypeRemoteControlNextTrack:
            NSLog(@"下一曲");
            break;
        case UIEventSubtypeRemoteControlPreviousTrack:
            NSLog(@"上一曲");
            break;
        default:
            break;
    }
}

#pragma mark - AVAudioPlayerDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player
    successfully:(BOOL)flag{
    [self.progressUpdateTimer invalidate];
    [self.audioPlayer play];
}

#pragma mark - ButtonAction

//拖动滑块
- (void)slide:(UISlider *)sender{
    self.audioPlayer.currentTime = sender.value;
}

//暂停播放
- (void)clickPlay:(UIButton *)sender{
    if (!self.isPlay) {
        //播放
    //    [sender setImage:nil forState:UIControlStateNormal];
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"pause" ]
            forState:UIControlStateNormal];

        self.isPlay = !self.isPlay;
        //播放
        [self.audioPlayer play];
        //修改slider的最大值
        self.progressSlider.maximumValue = self.audioPlayer.duration;
        
        //通过计时器观测当前时间
        self.progressUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
            target:self selector:@selector(changeTime) userInfo:nil repeats:YES];
        //显示总时间
        self.totalTimeLabel.text = [self timeStringFromSecond:self.audioPlayer.duration];
    }else{
       //暂停
        [self.audioPlayer pause];
       // [sender setImage:nil forState:UIControlStateNormal];
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"play" ]
            forState:UIControlStateNormal];
        self.isPlay = !self.isPlay;
    }
}

- (void)next:(UIButton *)sender{
    [self.progressUpdateTimer invalidate];
    return;
}

- (void)previous:(UIButton *)sender{
   [self.progressUpdateTimer invalidate];
    return;
}

#pragma mark - Time

//计时器关联的方法
- (void)changeTime{
    
    NSString *currentString = [self timeStringFromSecond:
        self.audioPlayer.currentTime];
    self.progressSlider.value = self.audioPlayer.currentTime;
    self.currentTimeLabel.text = currentString;
    
    //判断数组是否包含某个元素
    if ([self.lrcTimeAry containsObject:currentString]) {
        self.line = [self.lrcTimeAry indexOfObject:currentString];
        [self.lrcTableView reloadData];
        
        //选中tableView的这一行
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.line inSection:0];
        [self.lrcTableView selectRowAtIndexPath:indexPath animated:YES
            scrollPosition:UITableViewScrollPositionMiddle];
    }
}

- (NSString *)timeStringFromSecond:(NSInteger)second{
    return [NSString stringWithFormat:@"%02ld:%02ld",second/60,second%60];
}

@end
