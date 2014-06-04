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
}

@end
