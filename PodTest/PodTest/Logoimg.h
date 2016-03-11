//
//  Logoimg.h
//  PodTest
//
//  Created by 李超 on 15/12/7.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <MTLJSONAdapter.h>

@interface Logoimg : MTLModel<MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSString *height;
@property (copy, nonatomic,readonly)NSString *originalpic;
@property (copy, nonatomic,readonly)NSString *thumbnailpic;
@property (copy, nonatomic,readonly)NSString *width;
@end
