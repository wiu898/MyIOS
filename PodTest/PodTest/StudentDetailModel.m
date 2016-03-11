//
//  StudentDetailModel.m
//  PodTest
//
//  Created by 李超 on 16/1/22.
//  Copyright © 2016年 cn.com.李超. All rights reserved.
//

#import "StudentDetailModel.h"

@implementation StudentDetailModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"address":@"address",@"applyclasstypeinfo":@"applyclasstypeinfo",@"applycoachinfo":@"applycoachinfo",@"applyschoolinfo":@"applyschoolinfo",@"applystate":@"applystate",@"carmodel":@"carmodel",@"createtime":@"createtime",@"displaymobile":@"displaymobile",@"displayuserid":@"displayuserid",@"email":@"email",@"gender":@"gender",@"headportrait":@"headportrait",@"invitationcode":@"invitationcode",@"is_lock":@"is_lock",@"logintime":@"logintime",@"mobile":@"mobile",@"name":@"name",@"nickname":@"nickname",@"signature":@"signature",@"subject":@"subject",@"subjectthree":@"subjectthree",@"subjecttwo":@"subjecttwo",@"telephone":@"telephone",@"userid":@"userid"};

}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue
    error:(NSError *__autoreleasing *)error{
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) {
        return nil;
    }
    return self;
}

@end
