//
//  CourseTimeModel.h
//  PodTest
//
//  Created by 李超 on 15/12/28.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <MTLJSONAdapter.h>

@interface CourseTimeModel : MTLModel<MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSString *begintime;
@property (copy, nonatomic, readonly) NSString *endtime;
@property (strong, nonatomic, readonly) NSNumber *timeid;
@property (copy, nonatomic, readonly) NSString *timespace;
@property (assign, nonatomic, readwrite) NSInteger numMark;

@end
