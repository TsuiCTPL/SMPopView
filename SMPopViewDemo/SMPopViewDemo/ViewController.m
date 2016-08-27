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

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) NSArray *images;
@end

@implementation ViewController

-(NSArray *)titles
{
    if (_titles == nil) {
        _titles = @[@"简易案件",@"登登记登记记",@"登记",@"登登记登记记",@"登记"];
    }
    return _titles;
}

-(NSArray *)images
{
    if (_images == nil) {
        _images = @[@"zip", @"xls", @"zip", @"xls", @"zip"];
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SMPopView *popView = [SMPopView popViewForTitles:self.titles withImages:self.images];
    popView.delegate = self;
    popView.frame = [UIScreen mainScreen].bounds;
    popView.position = CGPointMake(200, 100);
    popView.imageName = @"popover_background_right@2x";
    self.popView = popView;
    [self.view addSubview:popView];
    
}

- (IBAction)popViewClick:(id)sender {
    
    self.popView.hidden = NO;
}

- (void)popView:(SMPopView *)popView didClickItemIndex:(NSInteger)index
{
    NSLog(@"%@", self.titles[index]);
}
@end
