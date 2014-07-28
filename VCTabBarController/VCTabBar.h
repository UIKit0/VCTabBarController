//
//  VCTabBar.h
//  VCTabBarController
//
//  Created by vincent on 2014/07/01.
//  Copyright (c) 2014年 vc7. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VCTab;

@protocol VCTabBarDelegate;

@interface VCTabBar : UIView

@property (nonatomic, weak) id <VCTabBarDelegate> delegate;

@property (nonatomic, strong) NSArray *tabs;
@property (nonatomic, strong) VCTab *selectedTab;

@end

@protocol VCTabBarDelegate <NSObject>

- (void)tabBar:(VCTabBar *)aTabBar didSelectTabAtIndex:(NSInteger)index;

@end