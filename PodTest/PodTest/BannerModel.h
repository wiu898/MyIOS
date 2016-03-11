//
//  BannerModel.h
//  PodTest
//
//  Created by 李超 on 15/12/7.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <MTLJSONAdapter.h>
#import "Logoimg.h"

@interface BannerModel : MTLModel<MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSString *infoId;
@property (copy, nonatomic, readonly) NSString *createtime;
@property (strong, nonatomic, readonly) Logoimg *headportrait;
@property (strong, nonatomic, readonly) NSNumber *is_using;
@property (copy, nonatomic, readonly) NSString *linkurl;
@property (copy, nonatomic, readonly) NSString *newsname;
@property (strong, nonatomic, readonly) NSNumber *newtype;

@end
