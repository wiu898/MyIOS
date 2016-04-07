//
//  LHSaCollectionViewCell.m
//  BiliBili
//
//  Created by 李超 on 16/4/6.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHSaCollectionViewCell.h"
#import "LHSaModel.h"

@interface LHSaCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *name;

@end

@implementation LHSaCollectionViewCell

- (void)setSaCellM:(LHSaModel *)saCellM{

    _saCellM = saCellM;
    
    self.icon.image = [UIImage imageNamed:saCellM.icon];
    
    self.name.text = saCellM.name;
}

@end
