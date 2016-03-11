//
//  AVPlayModel.h
//  PodTest
//
//  Created by 李超 on 15/12/24.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "SubjectModel.h"
#import <MTLJSONAdapter.h>
#import "MTLModel.h"

@interface AVPlayModel : MTLModel<MTLJSONSerializing>

@property (copy, readonly, nonatomic) NSString *infoId;
@property (copy, readonly, nonatomic) NSString *name;
@property (copy, readonly, nonatomic) NSString *pictures;
@property (strong, readonly, nonatomic) NSNumber *seqindex;
@property (strong, readonly, nonatomic) SubjectModel *subject;
@property (copy, readonly, nonatomic) NSString *videourl;


@end
