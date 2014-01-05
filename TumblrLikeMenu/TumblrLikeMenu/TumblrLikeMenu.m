//
//  TumblrLikeMenu.m
//  TumblrLikeMenu
//
//  Created by Tu You on 12/16/13.
//  Copyright (c) 2013 Tu You. All rights reserved.
//

#import "TumblrLikeMenu.h"
#import "TumblrLikeMenuItem.h"
#import "UIView+CommonAnimation.h"

#define kStringMenuItemAppearKey         @"kStringMenuItemAppearKey"
#define kFloatMenuItemAppearDuration     (0.35f)
#define kFloatTipLabelAppearDuration     (0.45f)
#define kFloatTipLabelHeight             (50.0f)

@interface TumblrLikeMenu()

@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIView *magicBgImageView;
@property (nonatomic, strong) NSArray *delayArray;
@property (nonatomic, strong) NSArray *delayDisappearArray;

@end

@implementation TumblrLikeMenu

- (id)initWithFrame:(CGRect)frame subMenus:(NSArray *)menus
{
    return [self initWithFrame:frame subMenus:menus tip:nil];
}

- (id)initWithFrame:(CGRect)frame subMenus:(NSArray *)menus tip:(NSString *)tip
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)
        {
            self.magicBgImageView = [[UIImageView alloc] initWithFrame:frame];
            self.magicBgImageView.userInteractionEnabled = YES;
            self.magicBgImageView.backgroundColor = [UIColor colorWithWhite:0.22 alpha:0.9];
        }
        else
        {
            // use tool bar in iOS 7 to blur the backgroud
            self.magicBgImageView = [[UIToolbar alloc] initWithFrame:frame];
            ((UIToolbar *)self.magicBgImageView).barStyle = UIBarStyleBlackTranslucent;
        }
        
        [self addSubview:self.magicBgImageView];
        
        if (tip)
        {
            self.tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(frame), CGRectGetWidth(frame), kFloatTipLabelHeight)];
            self.tipLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
            self.tipLabel.text = tip;
            self.tipLabel.backgroundColor = [UIColor clearColor];
            self.tipLabel.textAlignment = NSTextAlignmentCenter;
            self.tipLabel.textColor = [UIColor whiteColor];
            [self addSubview:self.tipLabel];
        }
        
        self.submenus = menus;
        
        [self setupSubmenus];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [self.magicBgImageView addGestureRecognizer:tapGestureRecognizer];
        
        self.delayArray = @[@(0.15), @(0.0), @(0.15), @(0.18), @(0.02), @(0.18)];
        self.delayDisappearArray = @[@(0.12), @(0.0), @(0.13), @(0.20), @(0.10), @(0.25)];
    }
    return self;
}

- (void)setupSubmenus
{
    for (int i = 0; i < 2; ++i)
    {
        for (int j = 0; j < 3; ++j)
        {
            TumblrLikeMenuItem *subMenu = self.submenus[i * 3 + j];
            subMenu.center = CGPointMake(100 * j + 62, CGRectGetHeight(self.frame) + i * 125 + 40);
            if (NULL == subMenu.selectBlock)
            {
                __weak TumblrLikeMenu *weakSelf = self;
                subMenu.selectBlock = ^(TumblrLikeMenuItem *item)
                {
                    NSUInteger index = [weakSelf.submenus indexOfObject:item];
                    if (index != NSNotFound) {
                        [weakSelf handleSelectAtIndex:index];
                    }
                };
            }
            [self addSubview:subMenu];
        }
    }
}

- (void)handleSelectAtIndex:(NSUInteger)index
{
    if (self.selectBlock)
    {
        self.selectBlock(index);
    }
    [self disappear];
}

- (void)resetThePosition
{
    for (int i = 0; i < 2; ++i)
    {
        for (int j = 0; j < 3; ++j)
        {
            UIView *subMenu = self.submenus[i * 3 + j];
            subMenu.center = CGPointMake(95 * j + 58, CGRectGetHeight(self.frame) + i * 100);
        }
    }
}

- (void)appear
{
    [self.magicBgImageView.layer addAnimation:[self fadeIn] forKey:@"fadeIn"];
    
    for (int i = 0; i < self.submenus.count; ++i)
    {
        double delayInSeconds = [self.delayArray[i] doubleValue];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            TumblrLikeMenuItem *item = (TumblrLikeMenuItem *)self.submenus[i];
            [self appearMenuItem:item animated:YES];
        });
    }
    
    if (self.tipLabel)
    {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        animation.beginTime = CACurrentMediaTime() + 0.3;
        animation.duration = kFloatTipLabelAppearDuration;
        animation.toValue = @(-kFloatTipLabelHeight);
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.35 :1.0 :0.53 :1.0];
        [self.tipLabel.layer addAnimation:animation forKey:@"ShowTip"];
    }
}

- (void)disappear
{
    for (int i = 0; i < self.submenus.count; ++i)
    {
        double delayInSeconds = [(NSNumber *)self.delayDisappearArray[i] doubleValue];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            TumblrLikeMenuItem *item = (TumblrLikeMenuItem *)self.submenus[i];
            [self disappearMenuItem:item animated:YES];
        });
    }
    
    [UIView animateWithDuration:0.2 delay:0.32 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.magicBgImageView.alpha = 0.7;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    [UIView animateWithDuration:0.15 animations:^{
        self.tipLabel.center = CGPointMake(self.tipLabel.center.x, self.tipLabel.center.y + kFloatTipLabelHeight);
    }];
}

- (void)disappearMenuItem:(TumblrLikeMenuItem *)item animated:(BOOL )animted
{
    CGPoint point = item.center;
    CGPoint finalPoint = CGPointMake(point.x, point.y - CGRectGetHeight(self.bounds) / 2 - 80);
    if (animted) {
        CABasicAnimation *disappear = [CABasicAnimation animationWithKeyPath:@"position"];
        disappear.duration = 0.3;
        disappear.fromValue = [NSValue valueWithCGPoint:point];
        disappear.toValue = [NSValue valueWithCGPoint:finalPoint];
        disappear.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        [item.layer addAnimation:disappear forKey:kStringMenuItemAppearKey];
    }
    item.layer.position = finalPoint;
}

- (void)appearMenuItem:(TumblrLikeMenuItem *)item animated:(BOOL )animated
{
    CGPoint point0 = item.center;
    CGPoint point1 = CGPointMake(point0.x, point0.y - CGRectGetHeight(self.bounds) / 2 - 120);
    CGPoint point2 = CGPointMake(point1.x, point1.y + 10);
    
    if (animated)
    {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        animation.values = @[[NSValue valueWithCGPoint:point0], [NSValue valueWithCGPoint:point1], [NSValue valueWithCGPoint:point2]];
        animation.keyTimes = @[@(0), @(0.6), @(1)];
        animation.timingFunctions = @[[CAMediaTimingFunction functionWithControlPoints:0.10 :0.87 :0.68 :1.0], [CAMediaTimingFunction functionWithControlPoints:0.66 :0.37 :0.70 :0.95]];
        animation.duration = kFloatMenuItemAppearDuration;
        [item.layer addAnimation:animation forKey:kStringMenuItemAppearKey];
    }
    item.layer.position = point2;
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
