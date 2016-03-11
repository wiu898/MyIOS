//
//  NSString+DY_MD5.m
//  PodTest
//
//  Created by 李超 on 15/12/8.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "NSString+DY_MD5.h"

//用来计算MD5和SHA
#include <CommonCrypto/CommonDigest.h>

@implementation NSString (DY_MD5)

- (NSString *)DY_MD5{
    NSData *inputData = [self dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char outputData[CC_MD5_DIGEST_LENGTH];
    
    //MD5加密
    CC_MD5([inputData bytes],(unsigned int)[inputData length],outputData);
    
    NSMutableString *hashStr = [NSMutableString string];
    int i =0;
    for (i=0; i<CC_MD5_DIGEST_LENGTH; ++i) {
        [hashStr appendFormat:@"%02x",outputData[i]];
    }
     return hashStr;
}

@end
