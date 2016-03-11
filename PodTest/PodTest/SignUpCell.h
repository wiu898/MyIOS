//
//  SignUpCell.h
//  PodTest
//
//  Created by 李超 on 16/1/14.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SIGNUPCOMPLETION)(NSString *completionString);

@interface SignUpCell : UITableViewCell

@property (copy, nonatomic) SIGNUPCOMPLETION signUpCompletion;

- (void)receiveTitile:(NSString *)titleString andSignUpBlock:(SIGNUPCOMPLETION)signUpCompletion;

- (void)receiveTextContent:(NSString *)content;

@end
