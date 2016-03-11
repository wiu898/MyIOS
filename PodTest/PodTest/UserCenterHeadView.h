//
//  UserCenterHeadView.h
//  PodTest
//
//  Created by 李超 on 15/12/18.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserCenterHeadViewDelegate <NSObject>

- (void)userCenterClick;

@end

@interface UserCenterHeadView : UIView

@property ( strong, nonatomic) UIImageView *userPortrait;
@property ( strong, nonatomic) UILabel *userPhoneNum;
@property ( strong, nonatomic) UILabel *userIdNum;
@property ( weak, nonatomic) id<UserCenterHeadViewDelegate>delegate;
- (id)initWithFrame:(CGRect)frame withUserPortrait:(NSString *)image withUserPhoneNum:(NSString *)userPhoneNum withUserIdNum:(NSString *)userIdNum;

@end
