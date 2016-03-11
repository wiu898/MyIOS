//
//  VipserverModel.h
//  PodTest
//
//  Created by 李超 on 16/1/14.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <MTLModel.h>
#import <MTLJSONAdapter.h>

@interface VipserverModel : MTLModel<MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSString *infoId;
@property (strong, nonatomic, readonly) NSNumber *msgId;
@property (copy, nonatomic, readonly) NSString *color;
@property (copy, nonatomic, readonly) NSString *name;

@end
