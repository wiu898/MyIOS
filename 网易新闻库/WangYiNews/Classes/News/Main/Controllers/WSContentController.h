//
//  WSContentController.h
//  WangYiNews
//
//  Created by 李超 on 16/2/26.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSContentController : UIViewController

/**新闻内容标识*/
@property (copy, nonatomic) NSString *docid;

+ (instancetype)contentControllerWithID:(NSString *)docID;

@end
