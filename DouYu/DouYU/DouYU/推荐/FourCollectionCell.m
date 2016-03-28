//
//  FourCollectionCell.m
//  DouYU
//
//  Created by 李超 on 16/3/22.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "FourCollectionCell.h"
#import "UIImageView+WebCache.h"

@interface FourCollectionCell()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UILabel *Name;

@property (strong, nonatomic) IBOutlet UILabel *onlinePeople;

@property (strong, nonatomic) IBOutlet UILabel *Title;

@end

@implementation FourCollectionCell

- (void)setOnlineData:(OnlineModel *)onlineData{
    
    //9.0之前Stirng转UTF-8用法
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[onlineData.room_src stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"Img_default.png"]];
   
     [self.imageView sd_setImageWithURL:[NSURL URLWithString:[onlineData.room_src stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:@"Img_default.png"]];
    
    self.Name.text = onlineData.nickname;
    
    self.onlinePeople.text = [NSString stringWithFormat:@"%0.1f万",[onlineData.online doubleValue]/10000];
    
    self.Title.text = onlineData.room_name;
}



-(void)setChaneldata:(ChanelData *)chaneldata
{
    
    NSLog(@"============= %@",chaneldata);
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[chaneldata.room_src stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"Img_default.png"]];
    
    self.Name.text=chaneldata.nickname;
    
    self.onlinePeople.text=[NSString stringWithFormat:@"%0.1f万",[chaneldata.online doubleValue]/10000];
    
    self.Title.text=chaneldata.room_name;
    
}

- (void)reciveChanelData:(ChanelData *)chaneldata {
//    NSLog(@"recive data = %@",chanelData);

    self.imageView.image = nil;
    self.Name.text = nil;
    self.onlinePeople.text = nil;
    self.Title.text = nil;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[chaneldata.room_src stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"Img_default.png"]];
    
    self.Name.text=chaneldata.nickname;
    
    self.onlinePeople.text=[NSString stringWithFormat:@"%0.1f万",[chaneldata.online doubleValue]/10000];
    
    self.Title.text=chaneldata.room_name;
}

- (void)reciveOnlineDataWith:(OnlineModel *)onlineData{

    self.imageView.image = nil;
    self.Name.text = nil;
    self.onlinePeople.text = nil;
    self.Title.text = nil;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[onlineData.room_src stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:@"Img_default.png"]];
    
    self.Name.text = onlineData.nickname;
    
    self.onlinePeople.text = [NSString stringWithFormat:@"%0.1f万",[onlineData.online doubleValue]/10000];
    
    self.Title.text = onlineData.room_name;
}


@end
