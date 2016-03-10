//
//  WSNewsCell.h
//  WangYiNews
//
//  Created by 李超 on 16/2/25.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WSNews;

typedef enum{
    
    WSNewsCellTypeNormal,   //正常显示
    WSNewsCellTypeBigImage,  //大图显示
    WSNewsCellTypeThreeImage   //三张图片显示
    
}WSNewsCellType;

@interface WSNewsCell : UITableViewCell

@property (strong, nonatomic) WSNews *news;

+ (instancetype)newsCellWithTableView:(UITableView *)tableview cellNews:(WSNews *)news;

+ (CGFloat)rowHeighWithCellType:(WSNewsCellType)type;

@end
