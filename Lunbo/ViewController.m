//
//  ViewController.m
//  Lunbo
//
//  Created by juwangkeji on 2018/7/6.
//  Copyright © 2018年 juwangkeji. All rights reserved.
//

#import "ViewController.h"
#import "KLCarouselView.h"
@interface ViewController()

@end

@implementation ViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    NSMutableArray * imageNameArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7", nil];
    KLCarouselView * myview = [[KLCarouselView alloc] initWithImgNameArray:imageNameArray frame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    [self.view addSubview:myview];
}
@end
