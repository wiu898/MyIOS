//
//  MyHeaderView.m
//  UIConllectionView练习
//
//  Created by 李超 on 15/11/19.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "MyHeaderView.h"

@interface MyHeaderView()

@property(strong,nonatomic) UILabel *label;

@end


@implementation MyHeaderView

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    
    if (self) {
       
        self.label = [[UILabel alloc] init];
        
        self.label.font = [UIFont systemFontOfSize:18];
        
        self.label.textAlignment = UIControlContentHorizontalAlignmentCenter;
        
        [self addSubview:self.label];
    }
    
    return self;

}


- (void) setLabelText:(NSString *)text
{
    self.label.text = text;
    [self.label sizeToFit];

}

- (void) setBackgroundImage:(NSString *)imageNames
{

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.frame];
    
    [imageView setImage:[UIImage imageNamed:imageNames]];
    
    [self addSubview:imageView];
    
}

@end
