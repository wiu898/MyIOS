//
//  UserIdModel.h
//  PodTest
//
//  Created by 李超 on 16/1/2.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "Logoimg.h"
#import <MTLJSONAdapter.h>

@interface UserIdModel : MTLModel<MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSString *userId;
@property (strong, nonatomic, readonly) Logoimg *headportrait;
@property (copy, nonatomic, readonly) NSString *name;

@end
