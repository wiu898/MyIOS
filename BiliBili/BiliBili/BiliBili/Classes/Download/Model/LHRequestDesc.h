//
//  LHRequestDesc.h
//  BiliBili
//
//  Created by 李超 on 16/3/29.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHCoderObject.h"

@interface LHRequestDesc : YHCoderObject

@property (nonatomic,copy) NSString *key;

@property (nonatomic,copy) NSString *URL;

@property (nonatomic,copy) NSString *titel;

@property (nonatomic,strong) NSNumber *tag_Btn;

@property (nonatomic,strong) id cellM;

@property (nonatomic,copy) NSString *danmuku;

@property (nonatomic,copy) NSString *destPath;

@property (nonatomic,copy) NSString *tempPath;

@property (nonatomic,strong) NSNumber *progressNum;

@end
