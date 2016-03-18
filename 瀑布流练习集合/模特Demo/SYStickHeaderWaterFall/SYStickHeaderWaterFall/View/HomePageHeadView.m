//
//  HomePageHeadView.m
//  SYStickHeaderWaterFall
//
//  Created by 李超 on 16/3/16.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "HomePageHeadView.h"

#define kDeviceWidth  [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height

@interface HomePageHeadView()

@property (nonatomic, strong) UIView *styleView;

@property (nonatomic, strong) UIView *typeView;

@property (nonatomic, strong) UIView *moreView;

@property (nonatomic, strong) CALayer *lineLayer;

@property (nonatomic, strong) CALayer *typeLineLayer;

@property (nonatomic, strong) CALayer *moreLineLayer;

@end

@implementation HomePageHeadView

- (UIView *)styleView{
   
    if (_styleView == nil) {
        _styleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth/3, 38)];
    }
    return _styleView;
}

- (UIView *)typeView{
   
    if (_typeView == nil) {
        _typeView = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/3, 0, kDeviceWidth/3, 38)];
    }
    return _typeView;
}

- (UIView *)moreView{
   
    if (_moreView == nil) {
        _moreView = [[UIView alloc] initWithFrame:CGRectMake(2*kDeviceWidth/3, 0, kDeviceWidth/3, 38)];
    }
    return _moreView;
}

- (UIButton *)styleBtn{
  
    if (_styleBtn == nil) {
        _styleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _styleBtn.frame = CGRectMake(0, 0, kDeviceWidth/4, 38);
        _styleBtn.center = CGPointMake(kDeviceWidth/6, 38/2);
        
        [_styleBtn setTitle:@"风格" forState:UIControlStateNormal];
        [_styleBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_styleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        UIImageView *styleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/8 + 35, 17, 9, 5)];
        styleImageView.image = [UIImage imageNamed:@"home_re_arrow_down.pdf"];
        
        [_styleBtn addSubview:styleImageView];
    }
    return _styleBtn;
}

- (UIButton *)typeBtn{
  
    if (_typeBtn == nil) {
        _typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _typeBtn.frame = CGRectMake(0, 0, kDeviceWidth/4, 38);
        _typeBtn.center = CGPointMake(kDeviceWidth/6, 38/2);
        
        [_typeBtn setTitle:@"类型" forState:UIControlStateNormal];
        [_typeBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_typeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        UIImageView *typeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/8 + 35, 16, 9, 5)];
        typeImageView.image = [UIImage imageNamed:@"home_re_arrow_down.pdf"];
        
        [_typeBtn addSubview:typeImageView];
    }
    return _typeBtn;
}

- (UIButton *)moreBtn{
  
    if (_moreBtn == nil) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreBtn.frame = CGRectMake(0, 0, kDeviceWidth/4, 38);
        _moreBtn.center = CGPointMake(kDeviceWidth/6 + 13, 38/2);
        
        [_moreBtn setTitle:@"筛选" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_moreBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        
        UIImageView *moreImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 11, 16, 16)];
        moreImageView.image = [UIImage imageNamed:@"home_refine.pdf"];
        
        [_moreBtn addSubview:moreImageView];
    }
    return _moreBtn;
}

- (CALayer *)lineLayer{
  
    if (_lineLayer == nil) {
        _lineLayer = [[CALayer alloc] init];
        _lineLayer.backgroundColor = [[UIColor blackColor] CGColor];
        _lineLayer.frame = CGRectMake(kDeviceWidth/3-1, 10, 1, 18);
    }
    return _lineLayer;
}

- (CALayer *)typeLineLayer{
  
    if (_typeLineLayer == nil) {
        _typeLineLayer = [[CALayer alloc] init];
        _typeLineLayer.frame = CGRectMake(kDeviceWidth/3-1, 10, 1, 18);
        _typeLineLayer.backgroundColor = [[UIColor blackColor] CGColor];
    }
    return _typeLineLayer;
}

- (CALayer *)moreLineLayer{
  
    if (_moreLineLayer == nil) {
        _moreLineLayer = [[CALayer alloc] init];
        _moreLineLayer.frame = CGRectMake(kDeviceWidth/3-1, 10, 1, 18);
        _moreLineLayer.backgroundColor = [[UIColor blackColor] CGColor];
    }
    return _moreLineLayer;
}

- (instancetype)initWithFrame:(CGRect)frame{
  
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.styleView];
    [self addSubview:self.typeView];
    [self addSubview:self.moreView];
    
    [self.styleView.layer addSublayer:self.lineLayer];
    [self.typeView.layer addSublayer:self.typeLineLayer];
    [self.moreView.layer addSublayer:self.moreLineLayer];
    
    [self.styleView addSubview:self.styleBtn];
    [self.typeView addSubview:self.typeBtn];
    [self.moreView addSubview:self.moreBtn];
    
  
}

@end
