//
//  TumblrLikeMenu.h
//  TumblrLikeMenu
//
//  Created by Tu You on 12/16/13.
//  Copyright (c) 2013 Tu You. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TumblrLikeMenuItem.h"

typedef void (^TumblrLikeMenuSelectBlock)(NSUInteger index);

@interface TumblrLikeMenu : UIView

@property (nonatomic, strong) NSArray *submenus;
@property (nonatomic, copy) TumblrLikeMenuSelectBlock selectBlock;

- (id)initWithFrame:(CGRect)frame subMenus:(NSArray *)menus;
- (id)initWithFrame:(CGRect)frame subMenus:(NSArray *)menus tip:(NSString *)tip;

- (void)show;

@end
