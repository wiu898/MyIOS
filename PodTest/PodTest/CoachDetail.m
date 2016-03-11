//
//  CoachDetail.m
//  PodTest
//
//  Created by 李超 on 16/1/2.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "CoachDetail.h"

@implementation CoachDetail

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"seniority":@"Seniority",@"address":@"address",@"carmodel":@"carmodel",@"coachid":@"coachid",@"commentcount":@"commentcount",@"createtime":@"createtime",@"displaycoachid":@"displaycoachid",@"driveschoolinfo":@"driveschoolinfo",@"email":@"email",@"headportrait":@"headportrait",@"introduction":@"introduction",@"invitationcode":@"invitationcode",@"is_lock":@"is_lock",@"is_shuttle":@"is_shuttle",@"is_validation":@"is_validation",@"logintime":@"logintime",@"mobile":@"mobile",@"name":@"name",@"passrate":@"passrate",@"platenumber":@"platenumber",@"shuttlemsg":@"shuttlemsg",@"starlevel":@"starlevel",@"studentcoount":@"studentcoount",@"subject":@"subject",@"trainFieldInfo":@"trainfieldlinfo",@"validationstate":@"validationstate",@"worktimedesc":@"worktimedesc"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}
+ (NSValueTransformer *)subjectJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *value, BOOL *success, NSError *__autoreleasing *error) {
        
        NSMutableArray *mubArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in value) {
            NSError *error = nil;
            SubjectModel *model = [MTLJSONAdapter modelOfClass: SubjectModel.class fromJSONDictionary:dic error:&error];
            [mubArray addObject:model];
        }
        
        return mubArray;
    }];
}


@end
