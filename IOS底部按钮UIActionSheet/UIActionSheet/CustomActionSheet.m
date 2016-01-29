//
//  CustomActionSheet.m
//  UIActionSheet
//
//  Created by 李超 on 15/12/21.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "CustomActionSheet.h"

@implementation CustomActionSheet


- (id)initwithHeight:(float)height WithSheetTitle:(NSString *)title{
    if (self == [super init]) {
        int theight = height -40;
        int btnum = theight/50;
        for (int i=0; i<btnum; i++) {
            [self addButtonWithTitle:@"1"];
        }
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,44,320,44)];
        _toolBar.barStyle = UIBarStyleBlack;
        _toolBar.backgroundColor = [UIColor blackColor];
        UIBarButtonItem *titleButton = [[UIBarButtonItem alloc] initWithTitle:title
            style:UIBarButtonItemStylePlain
            target:nil
            action:nil];
        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
            initWithTitle:@"确定"
            style:UIBarButtonItemStyleDone
            target:self
            action:@selector(done)];
        
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]
            initWithTitle:@"取消"
            style:UIBarButtonItemStylePlain
            target:self
            action:@selector(docancel)];
        
        UIBarButtonItem *fixedButton = [[UIBarButtonItem alloc]
            initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
            target:nil
            action:nil];
        
        NSArray *array = [[NSArray alloc] initWithObjects:
            leftButton,fixedButton,titleButton,fixedButton,rightButton,nil];
        
        [_toolBar setItems:array];
        [self addSubview:_toolBar];
//        view = [[UIView alloc] initWithFrame:CGRectMake(0, 44,
//            320, height-44)];
//        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
//        [self addSubview:view];
    }
    return self;
}

- (void)done{
    [self dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)docancel{
    [self dismissWithClickedButtonIndex:0 animated:YES];
}

@end
