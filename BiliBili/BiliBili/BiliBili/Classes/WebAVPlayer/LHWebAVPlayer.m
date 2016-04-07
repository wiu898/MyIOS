//
//  LHWebAVPlayer.m
//  BiliBili
//
//  Created by 李超 on 16/3/29.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHWebAVPlayer.h"
#import "AFNetworking.h"
#import "DanMuModel.h"
#import "LHRequestDesc.h"
#import "LHSortAV.h"
#import "UIKit+AFNetworking.h"
#import "XML2Dic.h"

#define PATH [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"list.data"]

@interface LHWebAVPlayer()

@property (strong, nonatomic) NSMutableArray *arrDict;

@property (strong, nonatomic) LHRequestDesc *requestDesc;

@end

@implementation LHWebAVPlayer

- (NSMutableArray *)arrDict{
  
    if (_arrDict == nil) {
        _arrDict = [NSMutableArray array];
    }
    return _arrDict;
}

- (void)setParam:(NSString *)param{

    _param = param;
    
    NSFileManager *manager = [NSFileManager defaultManager];\
    
    if ([manager fileExistsAtPath:PATH]) {
        
        NSMutableArray *arrM = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH];
        
        for (LHRequestDesc *reDesc in arrM) {
            
            if ([reDesc.key isEqualToString:param]) {
                
                self.requestDesc = reDesc;
                break;
            }
        }
        
        if (self.requestDesc != nil) {
            
            NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",param]];
            
            NSURL *url = [[NSURL alloc] initFileURLWithPath:filePath];
            
            [self.arrDict addObject:url.absoluteString];
            
            [self.arrDict addObject:_requestDesc.danmuku];
            
            if (self.AVPlayer) {
                
                self.AVPlayer(self.arrDict);
            }
            
            return;
        }
    }
    
    NSURL* URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.bilibilijj.com/Api/AvToCid/%@", param]];

    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    UIWebView *web = [[UIWebView alloc] init];
    
    NSProgress *progress = nil;
    
    [web loadRequest:request progress:&progress success:^NSString * _Nonnull(NSHTTPURLResponse * _Nonnull response, NSString * _Nonnull HTML) {
        
        if (HTML != nil) {
            
            NSData *data = [HTML dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
            
            NSArray *arr01 = [NSArray arrayWithArray:[dict valueForKey:@"list"]];
            
            for (NSDictionary *dict in arr01) {
                
                [self getAVURL:[dict valueForKey:@"CID"]];
            }
        }
        
        return HTML;
        
    } failure:^(NSError * _Nonnull error) {
        
        
    }];
    
}

+ (void)getDownLoadURLToSortAV:(NSString *)param backBlock:(PlayerBlock)player{

    NSURL* URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.bilibilijj.com/Api/AvToCid/%@", param]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    UIWebView *web = [[UIWebView alloc] init];
    
    NSProgress *progress = nil;
    
    [web loadRequest:request progress:&progress success:^NSString * _Nonnull(NSHTTPURLResponse * _Nonnull response, NSString * _Nonnull HTML) {
        
        if (HTML != nil) {
            
            NSData *data = [HTML dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
            
            //描述
            NSString *desc = [dict valueForKey:@"desc"];
            
            //up主
            NSString *up = [dict valueForKey:@"up"];
            
            NSArray *arr01 = [NSArray arrayWithArray:[dict valueForKey:@"list"]];
            
            NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr01.count];
            
            for (NSDictionary *dict in arr01) {
                
                LHSortAV *sortAV = [LHSortAV sortAVWithDict:dict];
                
                [arrM addObject:sortAV];
            }
            
            if (player) {
                player(arrM, desc, up);
            }
        }
        
        return HTML;
        
    } failure:^(NSError * _Nonnull error) {
        
        
    }];
}

+ (void)getPlayerURL:(LHSortAV *)sotr backBlock:(PlayerURLBlock)URLArr{

    NSFileManager *manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:PATH]) {
        
        NSMutableArray *arrM = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH];
        
        LHRequestDesc *requestDesc = nil;
        
        for (LHRequestDesc *reDesc in arrM) {
            
            if([reDesc.key isEqualToString:[NSString stringWithFormat:@"%@",sotr.CID]]){
                
                requestDesc = reDesc;
                
                break;
             
            }
        }
        if (requestDesc != nil) {
            
            NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4", [NSString stringWithFormat:@"%@", sotr.CID]]];
            
            NSURL *url = [[NSURL alloc] initFileURLWithPath:filePath];
            
            NSMutableArray *arrGo = [NSMutableArray arrayWithCapacity:2];
            
            [arrGo addObject:url.absoluteString];
            
            [arrGo addObject:sotr.CID];
            
            if (URLArr) {
                URLArr(arrGo);
            }
            return;
        }
    }
    
     NSString* vpath = [NSString stringWithFormat:@"http://interface.bilibili.com/playurl?platform=android&_device=android&_hwid=831fc7511fa9aff5&_tid=0&_p=1&_down=0&quality=3&otype=json&appkey=86385cdc024c0f6c&type=mp4&sign=7fed8a9b7b446de4369936b6c1c40c3f&_aid=%@&cid=%@", sotr.AV, sotr.CID];
    
    NSURL *URL = [NSURL URLWithString:vpath];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    UIWebView *web = [[UIWebView alloc] init];
    
    NSProgress *progress = nil;
    
    [web loadRequest:request progress:&progress success:^NSString * _Nonnull(NSHTTPURLResponse * _Nonnull response, NSString * _Nonnull HTML) {
        
        if (HTML.length >0 ) {
            
            NSData *data = [HTML dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
            
            NSArray *arr01 = [NSArray arrayWithArray:[dict valueForKey:@"durl"]];
            
            NSArray *arr02 = [NSArray arrayWithArray:[dict valueForKey:@"backup_url"]];
            
            NSString *url = [[arr01 firstObject] valueForKey:@"url"] ? [[arr01 firstObject] valueForKey:@"url"] : [arr02 firstObject];
            
            NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:2];
            
            [arrM addObject:url ? url : @""];
            
            [arrM addObject:sotr.CID ? sotr.CID : @""];
            
            if (URLArr) {
                
                URLArr(arrM);
            }
        }
        return HTML;
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)getAVURL:(NSString *)CID{

    NSString* vpath = [NSString stringWithFormat:@"http://interface.bilibili.com/playurl?platform=android&_device=android&_hwid=831fc7511fa9aff5&_tid=0&_p=1&_down=0&quality=3&otype=json&appkey=86385cdc024c0f6c&type=mp4&sign=7fed8a9b7b446de4369936b6c1c40c3f&_aid=%@&cid=%@", self.param, CID];
    
    NSURL *URL = [NSURL URLWithString:vpath];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    UIWebView *web = [[UIWebView alloc] init];
    
    NSProgress *progress = nil;
    
    [web loadRequest:request progress:&progress success:^NSString * _Nonnull(NSHTTPURLResponse * _Nonnull response, NSString * _Nonnull HTML) {
        
        if (HTML.length > 0) {
            
            NSData *data = [HTML dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
            
            NSArray* arr01 = [NSArray arrayWithArray:[dict valueForKey:@"durl"]];
            
            //            NSLog(@"%@",dict);
            
            NSArray* arr02 = [NSArray arrayWithArray:[dict valueForKey:@"backup_url"]];
            
            NSString* url = arr02.count ? [arr02 firstObject] : ([[arr01 firstObject] valueForKey:@"url"] ? [[arr01 firstObject] valueForKey:@"url"] : @"");
            
            [self.arrDict addObject:url];
            
            [self.arrDict addObject:CID];
            
            if (self.AVPlayer) {
                self.AVPlayer(self.arrDict);
            }

        }
        
        return HTML;
        
    } failure:^(NSError * _Nonnull error) {
        
        
    }];
  
}

@end
