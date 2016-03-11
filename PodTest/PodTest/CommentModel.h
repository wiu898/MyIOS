//
//  CommentModel.h
//  PodTest
//
//  Created by 李超 on 16/1/2.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <MTLJSONAdapter.h>

@interface CommentModel : MTLModel<MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSString *commentcontent;
@property (strong, nonatomic, readonly) NSNumber *starlevel;

@end
