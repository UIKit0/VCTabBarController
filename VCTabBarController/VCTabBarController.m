//
//  VCTabBarController.m
//  VCTabBarController
//
//  Created by vincent on 2014/07/01.
//  Copyright (c) 2014年 vc7. All rights reserved.
//

#import "VCTabBarController.h"
#import "VCTabBarView.h"
#import "VCTabBar.h"
#import "VCTab.h"

@interface VCTabBarController () <VCTabBarDelegate>

- (void)_loadTabs;

@property (nonatomic, readwrite) BOOL visible;

@end

@implementation VCTabBarController

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    
    if ( ! self.childViewControllers)
    {
        [self.selectedViewController viewWillAppear:animated];
    }
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
    
    if ( ! self.childViewControllers)
    {
        [self.selectedViewController viewDidAppear:animated];
    }
    
	self.visible = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
    
    if ( ! self.childViewControllers)
    {
        [self.selectedViewController viewWillDisappear:animated];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
    
    if ( ! [self respondsToSelector:@selector(addChildViewController:)])
    {
        [self.selectedViewController viewDidDisappear:animated];
    }
    
	self.visible = NO;
}

- (void)viewDidUnload
{
    self.tabBar = nil;
}

- (void)loadView
{
    self.tabBarView = [[VCTabBarView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	self.view = self.tabBarView;
    
	CGFloat tabBarHeight = 44;
	CGFloat adjust = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) ? 1 : 0;
    
	self.tabBar = [[VCTabBar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - tabBarHeight, self.view.bounds.size.width, tabBarHeight + adjust)];
	self.tabBar.delegate = self;
    
	self.tabBarView.backgroundColor = [UIColor clearColor];
	self.tabBarView.tabBar = self.tabBar;
    
	[self _loadTabs];
    
    [self _resetSelectedViewController];
}

#pragma mark - Accessors

- (NSUInteger)selectedIndex
{
    return [self.viewControllers indexOfObject:self.selectedViewController];
}

- (void)setSelectedViewController:(UIViewController *)selectedViewController
{
    UIViewController *originalViewController = self.selectedViewController;
    
	if (self.selectedViewController != selectedViewController) {
		
        self.selectedViewController = selectedViewController;
        
        if ( ! self.childViewControllers && self.visible)
        {
			[originalViewController viewWillDisappear:NO];
			[self.selectedViewController viewWillAppear:NO];
		}
        
		self.tabBarView.contentView = selectedViewController.view;
        
        if ( ! self.childViewControllers && self.visible)
        {
			[originalViewController viewDidDisappear:NO];
			[self.selectedViewController viewDidAppear:NO];
		}
        
		[self.tabBar setSelectedTab:[self.tabBar.tabs objectAtIndex:self.selectedIndex]];
	}
}

- (void)setViewControllers:(NSArray *)viewControllers
{
    if (viewControllers != self.viewControllers)
    {
		self.viewControllers = viewControllers;
        
		if (self.viewControllers != nil)
        {
			[self _loadTabs];
		}
	}
    
	self.selectedIndex = 0;
}

#pragma mark - VCTabBarDelegate

- (void)tabBar:(VCTabBar *)tabBar didSelectTabAtIndex:(NSInteger)index
{
    UIViewController *selectedViewController = [self.viewControllers objectAtIndex:index];
    
	if (self.selectedViewController == selectedViewController)
    {
		if ([self.selectedViewController isKindOfClass:[UINavigationController class]])
        {
			[(UINavigationController *)self.selectedViewController popToRootViewControllerAnimated:YES];
		}
	}
    else
    {
		self.selectedViewController = selectedViewController;
	}
}

#pragma mark - Private Methods

- (void)_loadTabs
{
    NSMutableArray *tabs = [NSMutableArray arrayWithCapacity:self.viewControllers.count];
    
	for (UIViewController *viewController in self.viewControllers)
    {
        // TODO: Implement initialization
        [tabs addObject:[[VCTab alloc] init]];
        
        // final use
		// [tabs addObject:[viewController tab]];
	}
    
	self.tabBar.tabs = tabs;
	[self.tabBar setSelectedTab:[self.tabBar.tabs objectAtIndex:self.selectedIndex]];
}

- (void)_resetSelectedViewController
{
	UIViewController *tmp = self.selectedViewController;
	self.selectedViewController = nil;
	[self setSelectedViewController:tmp];
}

#pragma mark - Manage Orientations

- (NSUInteger)supportedInterfaceOrientations
{
    return self.selectedViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return self.selectedViewController.preferredInterfaceOrientationForPresentation;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[self.selectedViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[self.selectedViewController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	[self.selectedViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

@end
