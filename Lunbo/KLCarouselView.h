//
//  KLCarouselView.h
//  Lunbo
//
//  Created by juwangkeji on 2018/7/10.
//  Copyright © 2018年 juwangkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLCarouselView : UIView
/**
 等待时间（默认2s）
 */
@property(nonatomic,assign) NSInteger waitTime;
/**
 小圆点底色（默认白色）
 */
@property(nonatomic,weak) UIColor * cos_pageIndicatorTintColor;
/**
 当前颜色（默认红色）
 */
@property(nonatomic,weak) UIColor * cos_currentPageIndicatorTintColor;

-(instancetype)initWithImgNameArray:(NSMutableArray *)nameArray frame:(CGRect)m_frame;
+(instancetype)cosViewImgNameArray:(NSMutableArray *)nameArray frame:(CGRect)m_frame;
@end
