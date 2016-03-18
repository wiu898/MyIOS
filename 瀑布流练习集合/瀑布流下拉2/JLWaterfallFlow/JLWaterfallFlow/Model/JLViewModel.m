//
//  JLViewModel.m
//  JLWaterfallFlow
//
//  Created by 李超 on 16/3/16.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "JLViewModel.h"
#import "MJExtension.h"
#import "DataModel.h"

@implementation JLViewModel

- (instancetype)init{

    self = [super init];
    
    if (self) {
        self.dataArray = [NSArray array];
        self.nameArray = [NSArray array];
    }
    
    return self;
}

- (void)getData{

    NSArray *plistOneArray = [DataModel objectArrayWithFilename:@"1.plist"];
    NSArray *plistTwoArray = [DataModel objectArrayWithFilename:@"2.plist"];
    NSArray *plistThreeArray = [DataModel objectArrayWithFilename:@"3.plist"];
    
    self.dataArray = @[plistOneArray, plistTwoArray, plistThreeArray];
    self.nameArray = @[@"1.plist", @"2.plist", @"3.plist"];
}

@end
