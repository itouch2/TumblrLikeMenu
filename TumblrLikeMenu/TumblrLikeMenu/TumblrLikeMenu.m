//
//  TumblrLikeMenu.m
//  TumblrLikeMenu
//
//  Created by Tu You on 12/16/13.
//  Copyright (c) 2013 Tu You. All rights reserved.
//

#import "TumblrLikeMenu.h"
#import "TumblrLikeMenuItem.h"

@interface TumblrLikeMenu()

@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIToolbar *magicBgImageView;
@property (nonatomic, retain) NSArray *delayArray;
@property (nonatomic, retain) NSArray *delayDisappearArray;

@end

@implementation TumblrLikeMenu

- (id)initWithFrame:(CGRect)frame subMenus:(NSArray *)menus
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.magicBgImageView = [[UIToolbar alloc] initWithFrame:frame];
        self.magicBgImageView.barStyle = UIBarStyleBlackTranslucent;
        [self addSubview:self.magicBgImageView];
        
        self.subMenus = menus;
        [self configTheSubMenus];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [self.magicBgImageView addGestureRecognizer:tapGestureRecognizer];
        
        self.delayArray = @[@(0.15), @(0.0), @(0.15), @(0.18), @(0.02), @(0.18)];
        self.delayDisappearArray = @[@(0.12), @(0.0), @(0.13), @(0.20), @(0.10), @(0.25)];

    }
    return self;
}

- (void)configTheSubMenus
{
    for (int i = 0; i < 2; ++i)
    {
        for (int j = 0; j < 3; ++j)
        {
            UIView *subMenu = self.subMenus[i * 3 + j];
            subMenu.center = CGPointMake(100 * j + 60, CGRectGetHeight(self.frame) + i * 110 + 40);
            [self addSubview:subMenu];
        }
    }
}

- (void)resetThePosition
{
    for (int i = 0; i < 2; ++i)
    {
        for (int j = 0; j < 3; ++j)
        {
            UIView *subMenu = self.subMenus[i * 3 + j];
            subMenu.center = CGPointMake(95 * j + 58, CGRectGetHeight(self.frame) + i * 100);
        }
    }
}

- (void)appear
{
    [self.magicBgImageView.layer addAnimation:[self fadeIn] forKey:@"fadeIn"];
    
    for (int i = 0; i < self.subMenus.count; ++i)
    {
        double delayInSeconds = [self.delayArray[i] doubleValue];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            TumblrLikeMenuItem *item = (TumblrLikeMenuItem *)self.subMenus[i];
            CAAnimation *animation = [self appearWithPoint:item.center];
            [item.layer addAnimation:animation forKey:@"kkk"];
        });
    }
}

- (void)disappear
{
    for (int i = 0; i < self.subMenus.count; ++i)
    {
        double delayInSeconds = [(NSNumber *)self.delayDisappearArray[i] doubleValue];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            TumblrLikeMenu *item = (TumblrLikeMenu *)self.subMenus[i];
            CGPoint point = CGPointMake(item.center.x, item.center.y - CGRectGetHeight(self.bounds) / 2 - 120 + 10);
            CAAnimation *animation = [self disappearWithPoint:point];
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            [item.layer addAnimation:animation forKey:@"kkk"];
        });
    }
    
    [UIView animateWithDuration:0.2 delay:0.32 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.magicBgImageView.alpha = 0.7;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (CAAnimation *)appearWithPoint:(CGPoint)point
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGPoint point0 = point;
    CGPoint point1 = CGPointMake(point.x, point.y - CGRectGetHeight(self.bounds) / 2 - 120);
    CGPoint point2 = CGPointMake(point1.x, point1.y + 10);
    animation.values = @[[NSValue valueWithCGPoint:point0], [NSValue valueWithCGPoint:point1], [NSValue valueWithCGPoint:point2]];
    animation.keyTimes = @[@(0), @(0.6), @(1)];
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithControlPoints:0.10 :0.87 :0.68 :1.0], [CAMediaTimingFunction functionWithControlPoints:0.66 :0.37 :0.70 :0.95]];
    animation.duration = 0.35;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    return animation;
}

- (CAAnimation *)disappearWithPoint:(CGPoint)point
{
    CABasicAnimation *disappear = [CABasicAnimation animationWithKeyPath:@"position"];
    CGPoint finalPoint = CGPointMake(point.x, point.y - CGRectGetHeight(self.bounds) / 2 - 120);
    disappear.duration = 0.3;
    disappear.fromValue = [NSValue valueWithCGPoint:point];
    disappear.toValue = [NSValue valueWithCGPoint:finalPoint];
    disappear.removedOnCompletion = NO;
    disappear.fillMode = kCAFillModeForwards;
    return disappear;
}

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

- (void)tapped:(UIGestureRecognizer *)gesture
{
    [self disappear];
}

- (void)show
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    [self appear];
}

@end
