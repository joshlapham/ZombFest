//
//  NUSSidePanelController.m
//  Newcastle Undead Society
//
//  Created by jl on 21/03/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSSidePanelController.h"

@interface NUSSidePanelController ()

@end

@implementation NUSSidePanelController

- (void)awakeFromNib
{
    [self setLeftPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"leftViewController"]];
    [self setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"centerViewController"]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

@end
