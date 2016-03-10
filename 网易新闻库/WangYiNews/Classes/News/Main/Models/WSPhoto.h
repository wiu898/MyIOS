//
//  WSPhoto.h
//  WangYiNews
//
//  Created by 李超 on 16/2/24.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSPhoto : NSObject

/**图片大图url*/
@property (copy, nonatomic) NSString *imgurl;
/**来源*/
@property (copy, nonatomic) NSString *note;
/**图片标识*/
@property (copy, nonatomic) NSString *photoid;
/**图片小图*/
@property (copy, nonatomic) NSString *timgurl;
/**图片小图一半*/
@property (copy, nonatomic) NSString *simgurl;
/**图片标题*/
@property (copy, nonatomic) NSString *imgtitle;
/**图片新闻url*/
@property (copy, nonatomic) NSString *newsurl;
/**图片网易新闻的url*/
@property (copy, nonatomic) NSString *photohtml;
/**方形图片*/
@property (copy, nonatomic) NSString *squareimgurl;

@property (copy, nonatomic) NSString *cimgurl;

+ (instancetype)imageWithDict:(NSDictionary *)dict;

@end
