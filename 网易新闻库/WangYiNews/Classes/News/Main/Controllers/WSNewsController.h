//
//  WSNewsController.h
//  WangYiNews
//
//  Created by 李超 on 16/2/29.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSNewsController : UITableViewController

///**新闻链接标识*/
@property (copy, nonatomic) NSString *channelID;

/**频道的url*/
@property (copy, nonatomic) NSString *channelUrl;

+ (instancetype)newsController;

@end
