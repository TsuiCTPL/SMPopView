//
//  SMItemButton.m
//  气泡弹窗
//
//  Created 2005，2016，by EVECOM Technology Co.,Ltd.
//  All rights reserved.

/**
 * Description:
 * @Author:Moris
 * @Date:16/8/10.
 */

#import "SMItemButton.h"
#import "UIView+SMExtention.h"

@implementation SMItemButton

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.x = 10;
    self.imageView.width = 20;
    self.imageView.height = 20;
    self.titleLabel.x = 35;
    self.titleLabel.width = self.width - 35 - 10;
    self.imageView.y = self.titleLabel.y;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    
}

@end
