//
//  StudentModel.h
//  PodTest
//
//  Created by 李超 on 16/1/22.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "MTLModel.h"
#import "UserIdModel.h"
#import <MTLJSONAdapter.h>

@interface StudentModel : MTLModel<MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSString *infoId;
@property (strong, nonatomic, readonly) UserIdModel *userid;


@end
