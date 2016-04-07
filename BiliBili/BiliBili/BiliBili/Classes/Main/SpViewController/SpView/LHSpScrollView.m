//
//  LHSpScrollView.m
//  BiliBili
//
//  Created by 李超 on 16/3/29.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHSpScrollView.h"
#import "LHShop.h"
#import "LHSpModel.h"
#import "UIKit+AFNetworking.h"
#import "LHParam.h"
#import "LHBusTableView.h"     //承包商排行
#import "LHComSpTable.h"       //评论
#import "LHDescScroller.h"     //番剧详情
#import "UIKit+AFNetworking.h"

@interface LHSpScrollView()

@property (nonatomic, strong) NSArray *arrDict;

@end

@implementation LHSpScrollView

- (void)setCellM:(LHShop *)cellM{

    _cellM = cellM;
    
    self.showsHorizontalScrollIndicator = NO;
    
    self.showsVerticalScrollIndicator = NO;
    
    self.backgroundColor = [UIColor clearColor];
    
    self.bounces = NO;
    
    self.contentSize = CGSizeMake(3 *[UIScreen mainScreen].bounds.size.width, 0);
    
    self.pagingEnabled = YES;
    
    [self webDataRequest:[NSString
        stringWithFormat:@"%zd",cellM.season_id]];
}

- (void)webDataRequest:(NSString *)param{

    NSString* fan = [NSString stringWithFormat:@"http://bangumi.bilibili.com/jsonp/seasoninfo/%@.ver?callback=episodeJsonCallback&_=1446863930820", param];
    
    NSURL *URL = [NSURL URLWithString:fan];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSProgress *progress = nil;
    
    UIWebView *web = [[UIWebView alloc] init];
    
    [web loadRequest:request progress:&progress success:^NSString * _Nonnull(NSHTTPURLResponse * _Nonnull response, NSString * _Nonnull HTML) {
        
        if (HTML != nil) {
            
            NSMutableString *str = [NSMutableString stringWithString:HTML];
            
            [str deleteCharactersInRange:NSMakeRange(0, 20)];
            
            [str deleteCharactersInRange:NSMakeRange(str.length - 2, 2)];
            
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
            
            NSDictionary *dictM = [dict valueForKey:@"result"];
            
            LHSpModel *cellM = [LHSpModel spMWithDict:dictM];
            
            NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:cellM.episodes.count];
            
            for (NSDictionary *dict in cellM.episodes) {
                
                LHParam *param = [LHParam paramWithDict:dict];
                
                [arrM addObject:param];
            }
            
            self.arrDict = arrM;
            
            [self showTableView:cellM];
        }
        
        return HTML;
        
    } failure:^(NSError * _Nonnull error) {
        
        
    }];
}

//实现三块区域--承包商排行、番剧详情、评论
- (void)showTableView:(LHSpModel *)cellM{

    CGFloat vW = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat vH = [UIScreen mainScreen].bounds.size.height;
    
    for (NSInteger i = 0; i < 3; i++) {
        
        if (i == 2) {    //评论
            
            LHComSpTable *view = [[LHComSpTable alloc] initWithFrame:CGRectMake(vW * i, 0, vW, vH)];
            
            view.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
            
            view.cellM = [self.arrDict lastObject];
            
            view.arrSp = [NSArray arrayWithObjects:@"233",nil];
            
            [self addSubview:view];
        }
        else if (i == 0){  //承包商排行
        
            LHBusTableView *view = [[LHBusTableView alloc] initWithFrame:CGRectMake(vW * i, 0, vW, vH)];
            
            view.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
            
            view.cellM = [self.arrDict lastObject];
            
            [self addSubview:view];
        }
        else{    //番剧详情
        
            LHDescScroller *view = [[LHDescScroller alloc] initWithFrame:CGRectMake(vW * i , 0, vW, vH)];
            
            view.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
            
            view.arrDict = self.arrDict;
            
            view.cellM = cellM;
            
            [self addSubview:view];
        }
    }
}

@end
