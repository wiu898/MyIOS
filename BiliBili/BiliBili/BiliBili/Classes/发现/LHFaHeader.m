//
//  LHFaHeader.m
//  BiliBili
//
//  Created by 李超 on 16/4/6.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "LHFaHeader.h"
#import "LHFaheadModel.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"

@interface LHFaHeader ()

@property (weak, nonatomic) IBOutlet UIImageView* image1;

@property (weak, nonatomic) IBOutlet UIImageView* image2;

@property (weak, nonatomic) IBOutlet UILabel* title1;

@property (weak, nonatomic) IBOutlet UILabel* title2;

@property (nonatomic, strong) NSArray* arrDict;

@end

@implementation LHFaHeader

- (void)reload:(id)sender{

    [LHFaheadModel globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        
        if (!error) {
            
            self.arrDict = posts;
            
            [self showSubView];
        }
    }];
}

- (void)showSubView{

    LHFaheadModel *faM1 = [self.arrDict firstObject];
    
    LHFaheadModel *faM2 = [self.arrDict lastObject];
    
    [self.image1 sd_setImageWithURL:[NSURL URLWithString:faM1.cover]];
    
    self.title1.text = [NSString stringWithFormat:@"  %@", faM2.keyword];
    
    [self.image2 sd_setImageWithURL:[NSURL URLWithString:faM2.cover]];
    
    self.title2.text = [NSString stringWithFormat:@"  %@", faM1.keyword];
}

- (void)awakeFromNib
{
    // Initialization code
    
    [self reload:nil];
}

+ (instancetype)faHeadWith
{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"LHFaHeader" owner:nil options:nil] lastObject];
}

@end
