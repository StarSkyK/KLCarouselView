//
//  myCell.m
//  Lunbo
//
//  Created by juwangkeji on 2018/7/6.
//  Copyright © 2018年 juwangkeji. All rights reserved.
//

#import "myCell.h"
#import "KLconst.h"
@interface myCell()
@property(nonatomic,strong) UIImageView * m_ImageView;
@end
@implementation myCell

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
