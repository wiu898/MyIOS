//
//  JLViewModel.h
//  JLWaterfallFlow
//
//  Created by 李超 on 16/3/16.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLViewModel : NSObject

@property (strong, nonatomic) NSArray *dataArray;

@property (strong, nonatomic) NSArray *nameArray;

- (void)getData;

@end
