//
//  SMPopView.m
//  气泡弹窗
//
//  Created 2005，2016，by EVECOM Technology Co.,Ltd.
//  All rights reserved.

/**
 * Description:气泡view
 * @Author:Moris
 * @Date:16/8/9.
 */

#import "SMPopView.h"
#import "SMItemButton.h"

// 屏幕宽度
# define SMScreenW [UIScreen mainScreen].bounds.size.width
// 屏幕高度
# define SMScreenH [UIScreen mainScreen].bounds.size.height
// 水平间距
# define SMHoriMargin 10
// 按钮高度
# define SMButtonHeight 30

@interface SMPopView()

/** 气泡view */
@property (nonatomic, weak) UIView *popView;

/** 气泡背景图片 */
@property (nonatomic, weak) UIImageView *bgImageView;

/** 存放气泡上的按钮数组 */
@property (nonatomic, strong) NSMutableArray *buttonArray;

/** 是否显示按钮图片 */
@property (nonatomic, assign) BOOL isShowingImage;

@end

@implementation SMPopView



-(NSArray *)buttonArray
{
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}


+ (instancetype)popViewForTitles: (NSArray *)titles withImages: (NSArray *)images
{
    
    SMPopView *popView = [[SMPopView alloc] init];
    [popView initView: titles withImages:images];
    popView.hidden = YES;
    return popView;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self maskClick];
}

- (void)initView: (NSArray *)titles withImages: (NSArray *)images
{

    // 背景颜色
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    
    CGFloat maxWidth = -100;
    for (int i=0; i<titles.count; i++) {
        NSString *str = titles[i];
        CGFloat strWidth = [self string:str sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
        if (strWidth > maxWidth) {
            maxWidth = strWidth;
        }
    }
    
    CGFloat imageWidth = 0;
    if (images.count == titles.count) {  // 图片和文字数量一致，显示图片
        self.isShowingImage = YES;
        imageWidth = 25;
    }else{
        NSLog(@"图片为空或者图片和文字数量不一致，不显示图片");
        
    }
    
    // popView
    UIView *popView = [[UIView alloc] init];
    CGFloat popViewWidth = maxWidth + 2 * SMHoriMargin + imageWidth;
    CGFloat popViewHeight = (SMButtonHeight) * titles.count + 15;
    CGRect frame = popView.frame;
    frame.size = CGSizeMake(popViewWidth, popViewHeight);
    popView.frame = frame;
    [self addSubview:popView];
    self.popView = popView;
    
    
    UIImageView *bgImageView = [[UIImageView alloc] init];
    
    UIImage *image = [UIImage imageNamed:@"SMPopView.bundle/popover_background"];
    // 设置左边端盖宽度
    NSInteger leftCapWidth = image.size.width * 0.5;
    // 设置上边端盖高度
    NSInteger topCapHeight = image.size.height * 0.5;
    UIImage *newImage = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    bgImageView.image = newImage;
    bgImageView.frame = popView.bounds;
    [popView addSubview:bgImageView];
    self.bgImageView = bgImageView;
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, popViewWidth, popViewHeight-15)];
    [popView addSubview:containerView];
    
    
    // 按钮
    for (int i=0; i<titles.count; i++) {
        
        UIButton *btn;
        if (self.isShowingImage) {
            btn = [[SMItemButton alloc] init];
        }else{
            btn = [[UIButton alloc] init];
        }
        btn.frame = CGRectMake(0, (SMButtonHeight) * i, popViewWidth, SMButtonHeight);
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        
        if (self.isShowingImage) {  // 有图片要显示
            [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        }
        btn.tag = i;
        [btn addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [containerView addSubview:btn];
        [self.buttonArray addObject:btn];
        
        if (i != (titles.count -1)) {
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
            lineView.frame = CGRectMake(3, CGRectGetMaxY(btn.frame)-1, popViewWidth-6, 1);
            [containerView addSubview:lineView];
        }
        
    }
    
}


-(CGSize)string:(NSString *)string sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


#pragma mark - 点击事件
- (void)maskClick
{
    self.hidden = YES;
}

- (void)itemClick: (UIButton *)button
{
    [self maskClick];
    if ([self.delegate respondsToSelector:@selector(popView:didClickItemIndex:)]) {
        [self.delegate popView:self didClickItemIndex:button.tag];
    }
}

#pragma mark - 个性化
-(void)setPosition:(CGPoint )position
{
    CGRect frame = self.popView.frame;
    frame.origin = position;
    self.popView.frame = frame;
}


-(void)setImageName:(NSString *)imageName
{
    _imageName = [NSString stringWithFormat:@"SMPopView.bundle/%@", imageName];
    UIImage *image = [UIImage imageNamed:self.imageName];
    NSInteger leftCapWidth = image.size.width * 0.5;
    NSInteger topCapHeight = image.size.height * 0.5;
    UIImage *newImage = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    self.bgImageView.image = newImage;
}

-(void)setFontColor:(UIColor *)fontColor
{
    for (UIButton *btn in self.buttonArray) {
        [btn setTitleColor:fontColor forState:UIControlStateNormal];
    }
}

@end
