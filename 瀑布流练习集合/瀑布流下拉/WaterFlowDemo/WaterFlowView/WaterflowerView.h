//
//  WaterflowerView.h
//  WaterFlowDemo
//
//  Created by 李超 on 16/3/15.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
   
    WaterflowerViewMarginTypeTop,
    WaterflowerViewMarginTypeBottom,
    WaterflowerViewMarginTypeLeft,
    WaterflowerViewMarginTypeRight,
    WaterflowerViewMarginTypeCulomn,
    WaterflowerViewMarginTypeRow,
    
}WaterflowerViewMarginType;

@class WaterflowerViewCell,WaterflowerView;

#pragma mark - dataSource代理方法

@protocol WaterflowerViewDataSource <NSObject>

@required

/**
 * 返回多少组数据
 */
- (NSUInteger)numberOfCellsInWaterflowerView:(WaterflowerView *)waterflowerView;

/**
 * 返回的cell
 */
- (WaterflowerViewCell *)waterflowerView:(WaterflowerView *)
     waterflowView cellAtIndex:(NSUInteger)index;

@optional

/**
 * 返回多少列
 */

- (NSUInteger)numberOfColumnsInWaterflowerView:(WaterflowerView *)waterflowerView;

@end

#pragma mark - waterflowerView的代理方法
@protocol WaterflowerViewDelegate <UIScrollViewDelegate>

@optional

/**
 * 返回对应index的cell的高度
 */
- (CGFloat)waterflowerView:(WaterflowerView *)waterflowerView heightAtIndex:(NSUInteger)index;

/**
 * 返回对应间距类型的高度
 */
- (CGFloat)waterflowerView:(WaterflowerView *)waterflowerView marginForType:(WaterflowerViewMarginType)type;


/**
 * 点击index对应的cell
 */
- (void)waterflowerView:(WaterflowerView *)waterflowerView didSelectedAtIndex:(NSUInteger)index;


@end


@interface WaterflowerView : UIScrollView<WaterflowerViewDelegate>

@property (nonatomic ,weak) id<WaterflowerViewDataSource> dataSource;

@property (nonatomic, weak) id<WaterflowerViewDelegate> delegate;

/**
 *  cell的宽度
 */
- (CGFloat)cellWidth;

/**
 * 刷新方法
 */
- (void)reloadData;

/**
 * 根据表示去缓存池查找可循环利用的cell
 */
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;

@end
