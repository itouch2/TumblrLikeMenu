//
//  ViewController.m
//  TumblrLikeMenu
//
//  Created by Tu You on 12/13/13.
//  Copyright (c) 2013 Tu You. All rights reserved.
//

#import "ViewController.h"
#import "TumblrLikeMenu.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *startButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.startButton setTitle:@"Share..." forState:UIControlStateNormal];
    self.startButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.startButton addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    self.startButton.frame = CGRectMake(0, 0, 80, 20);
    self.startButton.center = CGPointMake(CGRectGetWidth(self.view.bounds) / 2, CGRectGetHeight(self.view.bounds) / 2);
    [self.view addSubview:self.startButton];
}

- (void)start:(id)sender
{
    [self subtle];
}

- (void)subtle
{
    TumblrLikeMenuItem *menuItem0 = [[TumblrLikeMenuItem alloc] initWithImage:[UIImage imageNamed:@"Twitter"]
                                                             highlightedImage:[UIImage imageNamed:@"Twitter"]
                                                                         text:@"Twitter"];
    TumblrLikeMenuItem *menuItem1 = [[TumblrLikeMenuItem alloc] initWithImage:[UIImage imageNamed:@"Facebook"]
                                                             highlightedImage:[UIImage imageNamed:@"Facebook"]
                                                                         text:@"Facebook"];
    TumblrLikeMenuItem *menuItem2 = [[TumblrLikeMenuItem alloc] initWithImage:[UIImage imageNamed:@"Youtube"]
                                                             highlightedImage:[UIImage imageNamed:@"Youtube"]
                                                                         text:@"Youtube"];
    TumblrLikeMenuItem *menuItem3 = [[TumblrLikeMenuItem alloc] initWithImage:[UIImage imageNamed:@"Google+"]
                                                             highlightedImage:[UIImage imageNamed:@"Google+"]
                                                                         text:@"Google+"];
    TumblrLikeMenuItem *menuItem4 = [[TumblrLikeMenuItem alloc] initWithImage:[UIImage imageNamed:@"Tumblr"]
                                                             highlightedImage:[UIImage imageNamed:@"Tumblr"]
                                                                         text:@"Tumblr"];
    TumblrLikeMenuItem *menuItem5 = [[TumblrLikeMenuItem alloc] initWithImage:[UIImage imageNamed:@"LinkedIn"]
                                                             highlightedImage:[UIImage imageNamed:@"LinkedIn"]
                                                                         text:@"LinkedIn"];
    
    NSArray *subMenus = @[menuItem0, menuItem1, menuItem2, menuItem3, menuItem4, menuItem5];
    
    TumblrLikeMenu *menu = [[TumblrLikeMenu alloc] initWithFrame:self.view.bounds
                                                        subMenus:subMenus
                                                             tip:@"Nevermind"];
    menu.selectBlock = ^(NSUInteger index) {
        NSLog(@"item %ld index selected", index);
    };
    [menu show];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resourcesadfsfs that can be recreated.
}

@end
