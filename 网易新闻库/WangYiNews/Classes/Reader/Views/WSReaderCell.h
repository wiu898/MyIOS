//
//  WSReaderCell.h
//  WangYiNews
//
//  Created by 李超 on 16/2/29.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WSNews;

typedef enum {
    
    WSReaderCellTypeNormal,
    WSReaderCellTypeMulImage
    
}WSReaderCellType;

@interface WSReaderCell : UITableViewCell

@property (strong, nonatomic) WSNews *news;

+ (instancetype)readerCellWithTableView:(UITableView *)tableView cellType:(WSReaderCellType)type;


+ (CGFloat)rowHeightWithCellType:(WSReaderCellType)type;

@end
