//
//  TumblrLikeMenu.h
//  TumblrLikeMenu
//
//  Created by Tu You on 12/16/13.
//  Copyright (c) 2013 Tu You. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TumblrLikeMenuItem.h"

@interface TumblrLikeMenu : UIView

@property (nonatomic, strong) NSArray *subMenus;

- (id)initWithFrame:(CGRect)frame subMenus:(NSArray *)menus;
- (void)show;

@end
