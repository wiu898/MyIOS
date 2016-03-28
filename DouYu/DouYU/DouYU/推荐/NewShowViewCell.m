//
//  NewShowViewCell.m
//  DouYU
//
//  Created by 李超 on 16/3/22.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "NewShowViewCell.h"
#import "Public.h"
#import "NewShow.h"
#import "NewShowData.h"
#import "URL.h"
#import "NSString+Times.h"
#import "UIImageView+WebCache.h"

#define NewCell_H 150

@interface NewShowViewCell()
{
    UIScrollView *_backScrollView;
}
@end

@implementation NewShowViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        [self addContentView];
    }
    
    return self;
}

- (void)addContentView{

    _backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_width, NewCell_H)];
    
    _backScrollView.contentSize = CGSizeMake(2*screen_width, 0);
    _backScrollView.userInteractionEnabled = YES;
    _backScrollView.directionalLockEnabled = YES;
    _backScrollView.pagingEnabled = NO;
    _backScrollView.bounces = NO;
    _backScrollView.showsHorizontalScrollIndicator = NO;
    _backScrollView.showsVerticalScrollIndicator = NO;
    
    [self addSubview:_backScrollView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, NewCell_H-6, screen_width, 1)];
    
    //该区域底部分割线
    lineView.backgroundColor = RGBA(230, 230, 230, 1.0);
    
    [self addSubview:lineView];
}

- (void)setContentView:(NSArray *)array{

    for (int i = 0; i<array.count; i++) {
        
        NewShowData *newData = array[i];
        
        CGRect fram = CGRectMake((i+1)*5+i*90, 5, 90, 135);
        
        //View
        
        NewShow *_newShowView = [[NewShow alloc] init];
        _newShowView.tag = i;
        _newShowView.frame = fram;
        
        [_newShowView.HeadView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%@",NEW_Image_URl,[self countNumAndChangeformat:newData.owner_uid],NEW_Time_URl,[NSString GetNowTimes]]] placeholderImage:[UIImage imageNamed:@"Img_default"]];
         
         _newShowView.Name.text = newData.nickname;
         _newShowView.Game.text = newData.game_name;
         
         [_backScrollView addSubview:_newShowView];
         
         UITapGestureRecognizer *tapNewView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOneNewView:)];
        
        [_newShowView addGestureRecognizer:tapNewView];
    }
    
    _backScrollView.contentSize = CGSizeMake(10*95, 0);
}

- (void)tapOneNewView:(UIGestureRecognizer *)sender{

    NSLog(@"%ld",sender.view.tag);
}

- (NSString *)countNumAndChangeformat:(NSString *)str{

    NSMutableString *num = [NSMutableString stringWithString:str];
    
    int temp = 9 - (int)num.length;
    
    if(temp){
    
        for(int i = 0; i<temp; i++){
        
            [num insertString:@"0" atIndex:0];
        }
    }
    
    int count = 0;
    long long int a = num.longLongValue;
  
    while(a != 0){
       
        count++;
        a /= 10;
    }
    
    NSMutableString *string = [NSMutableString stringWithString:num];
    
    NSMutableString *newString = [NSMutableString string];
    
    while(count > 2){
        count -= 2;
        NSRange range = NSMakeRange(string.length - 2, 2);
        NSString *str = [string substringWithRange:range];
        [newString insertString:str atIndex:0];
        [newString insertString:@"/" atIndex:0];
        [string deleteCharactersInRange:range];
    }
    
    [newString insertString:string atIndex:0];
    
    [newString insertString:@"/" atIndex:3];
    
    [newString insertString:@"/" atIndex:0];
    
    [newString stringByReplacingOccurrencesOfString:@"//" withString:@"/"];
    
    return newString;
}

@end
