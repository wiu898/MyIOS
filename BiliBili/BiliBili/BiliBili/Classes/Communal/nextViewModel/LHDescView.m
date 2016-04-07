//
//  LHDescView.m
//  BiliBili
//
//  Created by 李超 on 16/3/28.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHDescView.h"
#import "LHDescModel.h"
#import "NSString+Tools.h"
#import "UIImageView+WebCache.h"

@interface LHDescView()

@property (weak, nonatomic) IBOutlet UIImageView* iconView;

@property (weak, nonatomic) IBOutlet UILabel* titelView;

@property (weak, nonatomic) IBOutlet UILabel* numLbl;

@property (weak, nonatomic) IBOutlet UILabel* talkLbl;

@property (weak, nonatomic) IBOutlet UIButton* btnV;

@end

@implementation LHDescView

- (void)setTestM:(LHDescModel *)testM{
  
    _testM = testM;
    
    self.titelView.text = testM.title;
    
    self.numLbl.text = [NSString exchangeStr:testM.play];
    
    self.talkLbl.text = [NSString exchangeStr:testM.danmaku];
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:testM.cover]];
    
    [self.btnV addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClick{

    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushController" object:self.testM];
}

//加载Nib文件
+ (instancetype)viewWithNib{

    return [[[NSBundle mainBundle] loadNibNamed:@"LHDescView" owner:nil options:nil] lastObject];
}

@end
