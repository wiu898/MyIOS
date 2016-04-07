//
//  DanMuModel.m
//  BiliBili
//
//  Created by 李超 on 16/3/30.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "DanMuModel.h"

@implementation DanMuModel

+ (instancetype)modelWithParameter:(NSString*)parameter text:(NSString*)text{
    
    NSArray* strArr = [parameter componentsSeparatedByString:@","];
    
    DanMuModel* model = [[DanMuModel alloc] init];
    
    model.sendTime = @([strArr[0] doubleValue]);
    
    model.style = @([strArr[1] intValue]);
    
    model.fontSize = @([strArr[2] floatValue]/1.5);
    
    model.textColor = @([strArr[3] doubleValue]);
    
    model.text = text;
    
    return model;
}

@end
