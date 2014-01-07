TumblrLikeMenu

**************

### Tumblr Menu using CAAnimation

**How to:**

First, setup the submenus:
  
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

Second, create the menu:

    TumblrLikeMenu *menu = [[TumblrLikeMenu alloc] initWithFrame:self.view.bounds
                                                        subMenus:subMenus
                                                             tip:@"Nevermind"];
    menu.selectBlock = ^(NSUInteger index) {
        NSLog(@"item %ld index selected", index);
    };

Last, show:

    [menu show];

  

**A Quick Peek**

![screenshots](https://f.cloud.github.com/assets/4316898/1861424/2ae670e6-77c2-11e3-8438-06c660954d51.gif)
