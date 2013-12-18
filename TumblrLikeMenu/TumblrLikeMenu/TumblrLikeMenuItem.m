//
//  TumblrLikeMenuItem.m
//  TumblrLikeMenu
//
//  Created by Tu You on 12/18/13.
//  Copyright (c) 2013 Tu You. All rights reserved.
//

#import "TumblrLikeMenuItem.h"

@interface TumblrLikeMenuItem ()

@property (nonatomic, retain) UIButton *menuButton;
@property (nonatomic, retain) UILabel *menuLabel;

@end

@implementation TumblrLikeMenuItem

- (id)initWithImage:(UIImage *)image
   highlightedImage:(UIImage *)highlightedImage
               text:(NSString *)text
{
    self = [super init];
    if (self)
    {
        self.image = image;
        self.highlightedImage = highlightedImage;
        self.text = text;
        
        self.frame = [self bounds];
        
        self.menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.image.size.width, self.image.size.height)];
        [self.menuButton setImage:image forState:UIControlStateNormal];
        [self.menuButton setImage:highlightedImage forState:UIControlStateHighlighted];
        
        self.menuLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.image.size.height + 5, self.frame.size.width, 18)];
        self.menuLabel.textColor = [UIColor whiteColor];
        self.menuLabel.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:13];
        self.menuLabel.textAlignment = NSTextAlignmentCenter;
        self.menuLabel.backgroundColor = [UIColor clearColor];
        self.menuLabel.text = text;
        
        [self addSubview:self.menuButton];
        [self addSubview:self.menuLabel];
    }
    return self;
}

- (CGRect)bounds
{
    CGRect rect = CGRectZero;
    rect.size.width = self.image.size.width;
    rect.size.height = self.image.size.height + 18;
    return rect;
}

@end
