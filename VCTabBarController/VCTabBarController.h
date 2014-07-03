//
//  VCTabBarController.h
//  VCTabBarController
//
//  Created by vincent on 2014/07/01.
//  Copyright (c) 2014年 vc7. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VCTabBarView;
@class VCTabBar;

@interface VCTabBarController : UIViewController

@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, strong) UIViewController *selectedViewController;
@property (nonatomic) NSUInteger selectedIndex;

@property (nonatomic, strong) VCTabBarView *tabBarView;
@property (nonatomic, strong) VCTabBar *tabBar;

@property (nonatomic, readonly) BOOL visible;

@end
