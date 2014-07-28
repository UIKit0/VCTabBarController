//
//  VCTab.m
//  VCTabBarController
//
//  Created by vincent on 2014/07/01.
//  Copyright (c) 2014年 vc7. All rights reserved.
//

#import "VCTab.h"

@interface VCTab ()

@end

@implementation VCTab

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        // Initialization code
        
        [self setImage:image forState:UIControlStateNormal];
        [self setImage:selectedImage forState:UIControlStateSelected];
        
        self.titleLabel.text = title;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = (CGRect){ {0, 0}, {30, 30} };
    self.titleLabel.frame = [self _generateTitleLabelFrame];
    
}

#pragma mark - Accessor

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
	[self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    [self _changeAppearanceBySelected:selected];
    
    [self setNeedsDisplay];
    
}

#pragma mark - Private Methods

- (void)_changeAppearanceBySelected:(BOOL)selected
{
    if (selected)
    {
        self.titleLabel.textColor = [UIColor blueColor];
    }
    else
    {
        self.titleLabel.textColor = [UIColor lightGrayColor];
    }
}

- (CGRect)_generateTitleLabelFrame
{
    return [self.titleLabel.text boundingRectWithSize:CGSizeZero
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{ NSFontAttributeName:self.titleLabel.font }
                                              context:nil];
}

@end
