//
//  ApplycoachinfoModel.h
//  PodTest
//
//  Created by 李超 on 15/12/7.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <MTLJSONAdapter.h>

@interface ApplycoachinfoModel : MTLModel<MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSString *infoId;
@property (copy, nonatomic, readonly) NSString *name;

@end
