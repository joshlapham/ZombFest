//
//  NUSEventDetailViewController.h
//  Newcastle Undead Society
//
//  Created by jl on 5/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NUSEvent;

@interface NUSEventDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *eventYear;
@property (nonatomic, strong) NUSEvent *chosenEvent;

- (id)initWithChosenEventItem:(NUSEvent *)chosenEventValue;

@end
