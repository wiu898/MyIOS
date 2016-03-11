//
//  SubjectModel.h
//  PodTest
//
//  Created by 李超 on 15/12/7.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <MTLJSONAdapter.h>

@interface SubjectModel : MTLModel<MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSString *calcelId;
@property (copy, nonatomic, readonly) NSString *name;
@property (strong, nonatomic, readonly) NSString *subjectId;

@end
