//
//  LHDownCell.h
//  BiliBili
//
//  Created by 李超 on 16/4/6.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LHASIHTTPRequest;

@class LHRequestDesc;

@interface LHDownCell : UITableViewCell

@property (nonatomic,strong) LHRequestDesc *requestDesc;

@property (nonatomic,copy) void(^deleBlock)(LHRequestDesc *);

@property (nonatomic,copy) void(^palyBlock)(id,NSString*,NSString*);

@property (weak, nonatomic) IBOutlet UIButton* seleBtn;

@property (nonatomic, strong) LHASIHTTPRequest* request;

@property (nonatomic,assign) NSInteger index;

- (IBAction)seleAction:(UIButton *)sender ;

@end
