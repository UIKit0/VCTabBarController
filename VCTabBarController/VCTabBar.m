//
//  VCTabBar.m
//  VCTabBarController
//
//  Created by vincent on 2014/07/01.
//  Copyright (c) 2014年 vc7. All rights reserved.
//

#import "VCTabBar.h"
#import "VCTab.h"

@implementation VCTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.userInteractionEnabled = YES;
        self.autoresizesSubviews = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect tabFrame = self.bounds;
    
	tabFrame.size.width /= self.tabs.count;
    
	for (VCTab *tab in self.tabs)
    {
		tab.frame = (CGRect){ {floorf(CGRectGetMinX(tabFrame)), CGRectGetMinY(tabFrame)}, {floorf(CGRectGetWidth(tabFrame)), CGRectGetHeight(tabFrame)} };
		tabFrame.origin.x += tabFrame.size.width;
        
		[self addSubview:tab];
	}
    
}

- (void)drawRect:(CGRect)rect
{
    
}

#pragma mark - Accessor

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self setNeedsDisplay];
}

- (void)setTabs:(NSArray *)tabs
{
    if (_tabs != tabs)
    {
        [self _removeTabs];
        
        _tabs = tabs;
        
        [self _configureTabs];
        
        [self setNeedsLayout];
        
    }
}

- (void)setSelectedTab:(VCTab *)selectedTab
{
    if (_selectedTab != selectedTab)
    {
        _selectedTab = selectedTab;
        _selectedTab.selected = YES;
        
        for (VCTab *tab in self.tabs)
        {
            if (tab == _selectedTab)
            {
                continue;
            }
            
            tab.selected = NO;
        }
    }
}

#pragma mark - Button Actions

- (void)tabSelected:(VCTab *)sender
{
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectTabAtIndex:)])
    {
        [self.delegate tabBar:self didSelectTabAtIndex:[self.tabs indexOfObject:sender]];    
    }
}

#pragma mark - Private Methods

- (void)_removeTabs
{
    for (VCTab *tab in self.tabs)
    {
        [tab removeFromSuperview];
    }
}

- (void)_configureTabs
{
    for (VCTab *tab in self.tabs)
    {
        tab.userInteractionEnabled = YES;
        [tab addTarget:self action:@selector(tabSelected:) forControlEvents:UIControlEventTouchDown];
    }
}

@end
