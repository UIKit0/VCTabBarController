//
//  VCTabBarView.m
//  VCTabBarController
//
//  Created by vincent on 2014/07/01.
//  Copyright (c) 2014年 vc7. All rights reserved.
//

#import "VCTabBarView.h"
#import "VCTabBar.h"

@implementation VCTabBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = self.contentView.frame;
    frame.size.height = self.tabBar.frame.origin.y;
    self.contentView.frame = frame;
    
    [self.contentView layoutIfNeeded];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor colorWithWhite:1 alpha:1] set];
    CGContextFillRect(context, self.bounds);
}

#pragma mark - Accessors

- (void)setTabBar:(VCTabBar *)tabBar
{
    if (_tabBar != tabBar)
    {
        [_tabBar removeFromSuperview];
        
        _tabBar = tabBar;
        
        [self addSubview:_tabBar];
    }
}

- (void)setContentView:(UIView *)contentView
{
    [_contentView removeFromSuperview];
	_contentView = contentView;
	_contentView.frame = (CGRect){ {0, 0}, {self.bounds.size.width, self.tabBar.frame.origin.y} };
    
	[self addSubview:_contentView];
	[self sendSubviewToBack:_contentView];
}

@end
