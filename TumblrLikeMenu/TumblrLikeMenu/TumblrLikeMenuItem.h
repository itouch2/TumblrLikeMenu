//
//  TumblrLikeMenuItem.h
//  TumblrLikeMenu
//
//  Created by Tu You on 12/18/13.
//  Copyright (c) 2013 Tu You. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TumblrLikeMenuItem : UIView

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *highlightedImage;
@property (nonatomic, strong) NSString *text;

- (id)initWithImage:(UIImage *)image
   highlightedImage:(UIImage *)highlightedImage
               text:(NSString *)text;

@end
