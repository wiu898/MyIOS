//
//  LHSortCell.m
//  BiliBili
//
//  Created by 李超 on 16/3/30.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHSortCell.h"
#import "LHSortAV.h"
#import "LHDescModel.h"

@interface LHSortCell()

@property (weak, nonatomic) IBOutlet UILabel *descLbl;

@property (weak, nonatomic) IBOutlet UIScrollView *sortView;

@end

@implementation LHSortCell

- (void)setArrDict:(NSArray *)arrDict{

    _arrDict = arrDict;
    
    CGFloat btnM = 20;
    CGFloat btnW = ([UIScreen mainScreen].bounds.size.width - 4 * btnM)/2.5;
    
    self.descLbl.text = [NSString
       stringWithFormat:@"播放列表(%zd)",arrDict.count];
    
    self.sortView.contentSize =
       CGSizeMake((12 + btnW) * arrDict.count + 20, 0);
    
    self.sortView.showsHorizontalScrollIndicator = NO;
    
    for (NSInteger i = 0; i < arrDict.count; i++) {
        
        //视频详情ScrollView部分展示的其实是按钮组合而来的
        
        UIButton *btn = [[UIButton alloc] init];
        
        [self.sortView addSubview:btn];
        
        btn.frame = CGRectMake(20 + (12+btnW) * i, 0, btnW, 38);
        
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 8);
        
        [btn setTitle:[arrDict[i] Title] forState:UIControlStateNormal];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:10.0];
        
        btn.backgroundColor = [UIColor whiteColor];
        
        btn.titleLabel.numberOfLines = 2;
        
        [btn setTitleColor:[UIColor colorWithRed:240 / 255.0 green:102 / 255.0 blue:144 / 255.0 alpha:1] forState:UIControlStateNormal];
        
        btn.layer.cornerRadius = 3;
        
        btn.clipsToBounds = YES;
        
        btn.tag = i;
        
        //点击按钮播放视频
        [btn addTarget:self action:@selector(playAV:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)playAV:(UIButton *)btn{

    //通过通知中心发送消息播放视频
    
    [[NSNotificationCenter defaultCenter]
         postNotificationName:[NSString stringWithFormat:@"playerSortAV%@%zd",[self.arrDict[btn.tag] AV],[self.cellM rand]]
         object:self.arrDict[btn.tag]];
}

+ (instancetype)cellWithTableV:(UITableView *)table{

   static NSString *ID = @"sortCell";
    
    LHSortCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LHSortCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{

    [super setSelected:selected animated:animated];
}

@end
