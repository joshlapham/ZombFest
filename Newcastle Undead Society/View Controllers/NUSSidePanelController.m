//
//  NUSSidePanelController.m
//  Newcastle Undead Society
//
//  Created by jl on 21/03/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSSidePanelController.h"
#import "NUSNewsFeedViewController.h"

@interface NUSSidePanelController ()

@end

@implementation NUSSidePanelController

- (void)awakeFromNib
{
    // TODO: subclass the sidemenu controller with a custom NIB for menu item cells; rather than using Storyboards
    [self setLeftPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"leftViewController"]];
    [self setCenterPanel:[[UINavigationController alloc] initWithRootViewController:[[NUSNewsFeedViewController alloc] init]]];
    
    // Disable swipe to show menu
    self.allowLeftSwipe = NO;
    self.allowRightSwipe = NO;
    
    // Set menu to be a little bit smaller than the default
    // NOTE - 160 is half the screen in portrait mode
    self.leftFixedWidth = 160;
}

- (void)stylePanel:(UIView *)panel {
    // Remove rounded corners that JASidePanels applies by default
    panel.layer.cornerRadius = 0;
    panel.clipsToBounds = YES;
}

@end
