TumblrLikeMenu

**************

### Tumblr Menu using CAAnimation

**How to:**

First, setup the submenus:
  
    TumblrLikeMenuItem *menuItem0 = [[TumblrLikeMenuItem alloc] initWithImage:[UIImage imageNamed:@"A"]
                                                             highlightedImage:[UIImage imageNamed:@"A"]
                                                                         text:@"Twitter"];
    TumblrLikeMenuItem *menuItem1 = [[TumblrLikeMenuItem alloc] initWithImage:[UIImage imageNamed:@"B"]
                                                             highlightedImage:[UIImage imageNamed:@"B"]
                                                                         text:@"Facebook"];
    TumblrLikeMenuItem *menuItem2 = [[TumblrLikeMenuItem alloc] initWithImage:[UIImage imageNamed:@"C"]
                                                             highlightedImage:[UIImage imageNamed:@"C"]
                                                                         text:@"Instagram"];
    TumblrLikeMenuItem *menuItem3 = [[TumblrLikeMenuItem alloc] initWithImage:[UIImage imageNamed:@"D"]
                                                             highlightedImage:[UIImage imageNamed:@"D"]
                                                                         text:@"Google+"];
    TumblrLikeMenuItem *menuItem4 = [[TumblrLikeMenuItem alloc] initWithImage:[UIImage imageNamed:@"E"] 
                                                             highlightedImage:[UIImage imageNamed:@"E"]
                                                                         text:@"Weibo"];
    TumblrLikeMenuItem *menuItem5 = [[TumblrLikeMenuItem alloc] initWithImage:[UIImage imageNamed:@"F"]
                                                             highlightedImage:[UIImage imageNamed:@"F"]
                                                                         text:@"Flicker"];
    
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

![screenshots](https://f.cloud.github.com/assets/4316898/1788619/a315383c-6934-11e3-9b86-c143f46d5376.gif)
