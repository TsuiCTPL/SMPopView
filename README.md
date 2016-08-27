# SMPopView（气泡View）

> 简单易用，最快三行代码就可以集成。

## 实现效果
![自定义选择器效果图](/image/screenshot.png)  


## 快速集成

- 让控制器成为其代理

```
- (void)initPopView
{
    // 创建popView
    SMPopView *popView = [SMPopView popViewForTitles:@[@"相册",@"文章列表", @"点赞", @"添加好友"] withImages:@[@"album", @"draft", @"like", @"new_friend"]];
    popView.delegate = self;
    self.popView = popView;
    [self.view addSubview:popView];
}

```

## 代理方法

```
/**
 *  点击popView的item后的回调方法，传回Item的索引值
 */
- (void)popView:(SMPopView *)popView didClickItemIndex:(NSInteger)index
{
    NSLog(@"%zd", index);
}

```

## 个性定制

> 提供位置，背景图片，字体三个属性进行个性化需求
> 
> 其中框架中提供了三个背景图片，只是指向的箭头位置不同而已
>
- popover_background_left@2x  左上角
- popover_background@2x  中间
- popover_background_right@2x  右上角

```
/* 气泡的位置 */
@property (nonatomic, assign) CGPoint position;

/** 气泡的背景图片 */
@property (nonatomic, weak) NSString *imageName;

/** 按钮字体颜色 */
@property (nonatomic, weak) UIColor *fontColor;

```
