//
//  ExamCarModel.h
//  PodTest
//
//  Created by 李超 on 15/12/7.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>

#import <Mantle/MTLJSONAdapter.h>

@interface ExamCarModel : MTLModel<MTLJSONSerializing>

@property (copy, nonatomic) NSString *code;
@property (strong, nonatomic) NSNumber *modelsid;
@property (copy, nonatomic) NSString *name;

@end
