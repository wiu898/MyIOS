//
//  StudentCommentModel.h
//  PodTest
//
//  Created by 李超 on 16/1/2.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <MTLJSONAdapter.h>
#import "CommentModel.h"
#import "UserIdModel.h"

@interface StudentCommentModel : MTLModel<MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSString *infoId;
@property (strong, nonatomic, readonly) CommentModel *comment;
@property (strong, nonatomic, readonly) UserIdModel *userid;

@end
