//
//  KLCarouselCell.m
//  Lunbo
//
//  Created by juwangkeji on 2018/7/10.
//  Copyright © 2018年 juwangkeji. All rights reserved.
//

#import "KLCarouselCell.h"
#import "KLconst.h"
@interface KLCarouselCell()
@property(nonatomic,strong) UIImageView * m_ImageView;
@end

@implementation KLCarouselCell
-(UIImageView *)m_ImageView{
    if (!_m_ImageView) {
        _m_ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, __KLVIEWWIDTH__, __KLVIEWHEIGHT__)];
    }
    return _m_ImageView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.m_ImageView];
    }
    return self;
}

-(void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    self.m_ImageView.image = [UIImage imageNamed:imageName];
}
@end
