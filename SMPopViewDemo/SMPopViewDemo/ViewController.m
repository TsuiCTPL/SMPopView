//
//  ViewController.m
//  SMPopViewDemo
//
//  Created by Tsui on 16/8/27.
//  Copyright © 2016年 net.evecom. All rights reserved.
//

#import "ViewController.h"
#import "SMPopView.h"

@interface ViewController ()<SMPopViewDelegate>

@property (nonatomic, weak) SMPopView *popView;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPopView];
}

- (void)initPopView
{
    SMPopView *popView = [SMPopView popViewForTitles:@[@"相册",@"文章列表", @"点赞", @"添加好友"] withImages:@[@"album", @"draft", @"like", @"new_friend"]];
    popView.delegate = self;
    self.popView = popView;
    [self.view addSubview:popView];
}

- (IBAction)popViewClick:(id)sender {
    
    self.popView.hidden = NO;
}

/**
 *  点击popView的item后的回调方法，传回Item的索引值
 */
- (void)popView:(SMPopView *)popView didClickItemIndex:(NSInteger)index
{
    NSLog(@"%zd", index);
}
@end
