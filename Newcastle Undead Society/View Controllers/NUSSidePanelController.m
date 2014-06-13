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
    [self setLeftPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"leftViewController"]];
    [self setCenterPanel:[[UINavigationController alloc] initWithRootViewController:[[NUSNewsFeedViewController alloc] init]]];
    
    // Disable swipe to show menu
    self.allowLeftSwipe = NO;
    self.allowRightSwipe = NO;
}

- (void)stylePanel:(UIView *)panel {
    // Remove rounded corners that JASidePanels applies by default
    panel.layer.cornerRadius = 0;
    panel.clipsToBounds = YES;
}

@end
