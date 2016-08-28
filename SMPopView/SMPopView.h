//
//  SMPopView.h
//  气泡弹窗
//
//  Created 2005，2016，by EVECOM Technology Co.,Ltd.
//  All rights reserved.

/**
 * Description:气泡view
 * @Author:Moris
 * @Date:16/8/9.
 */

#import <UIKit/UIKit.h>
@class SMPopView;

@protocol SMPopViewDelegate <NSObject>
/**
 *  点击item后，通过实现代理传回索引
 */
- (void)popView:(SMPopView *)popView didClickItemIndex:(NSInteger)index;

@end

@interface SMPopView : UIView

@property (nonatomic, weak) id<SMPopViewDelegate> delegate;

+ (instancetype)popViewForTitles:(NSArray *)titles withImages:(NSArray *)images;

/* 气泡的位置 */
@property (nonatomic, assign) CGPoint position;
/** 气泡的背景图片 */
@property (nonatomic, weak) NSString *imageName;
/** 按钮字体颜色 */
@property (nonatomic, weak) UIColor *fontColor;

@end
