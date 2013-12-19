//
//  UIView+CommonAnimation.m
//  TumblrLikeMenu
//
//  Created by xjz on 13-12-19.
//  Copyright (c) 2013年 Tu You. All rights reserved.
//

#import "UIView+CommonAnimation.h"

@implementation UIView (CommonAnimation)


- (CABasicAnimation *)fadeIn
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = 0.35;
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat:0.8f];
    return animation;
}

- (CABasicAnimation *)fadeOut
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = 0.2;
    animation.fromValue = [NSNumber numberWithFloat:0.8f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];
    return animation;
}


@end
