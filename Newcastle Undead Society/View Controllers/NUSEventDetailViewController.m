//
//  NUSEventDetailViewController.m
//  Newcastle Undead Society
//
//  Created by jl on 5/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSEventDetailViewController.h"
#import "NUSEvent.h"
#import "NUSContainerTableCell.h"

@interface NUSEventDetailViewController ()

@end

@implementation NUSEventDetailViewController {
    NSMutableArray *cellArray;
    NSMutableArray *eventTimes;
    NSMutableArray *eventDetails;
    NSMutableArray *eventGallery;
}

@synthesize eventYear, chosenEvent;

#pragma mark - UITableViewDataSource delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [cellArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionContents = [cellArray objectAtIndex:section];
    
    return [sectionContents count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && chosenEvent.isPastEvent == YES) {
        // For Gallery cell
        return 170;
    } else {
        // For all other cells
        return 200;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *headerText;
    
    switch (section) {
        case 0:
            // Details section
            headerText = NSLocalizedString(@"Details", nil);
            break;
            
        case 1:
            // Times (only for future events) or Gallery (for past events)
            if (chosenEvent.isPastEvent == NO) {
                // Times
                headerText = NSLocalizedString(@"Times", nil);
            } else if (chosenEvent.isPastEvent == YES) {
                // Gallery
                headerText = NSLocalizedString(@"Gallery", nil);
            }
            break;
            
        default:
            headerText = nil;
            break;
    }
    
    // Init custom header view
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 20)];
    
    // Init header label
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:headerView.bounds];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = [UIColor colorWithRed:0.46 green:0.19 blue:0.18 alpha:1];
    headerLabel.adjustsFontSizeToFitWidth = YES;
    headerLabel.textAlignment = NSTextAlignmentCenter;
    
    // Set header label font
    UIFont *headerLabelFont = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20];
    headerLabel.font = headerLabelFont;
    
    // Set header label text
    headerLabel.text = headerText;
    
    [headerView addSubview:headerLabel];
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        // Details section
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventDetailCell" forIndexPath:indexPath];
        
        // Disable tapping of cells
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        NSArray *sectionContents = [cellArray objectAtIndex:indexPath.section];
        
        UILabel *contentLabel = (UILabel *)[cell viewWithTag:101];
        
        contentLabel.numberOfLines = 0;
        
        contentLabel.text = [sectionContents objectAtIndex:indexPath.row];
        
        return cell;
        
    } else if (indexPath.section == 1) {
        // Times/Gallery section
        
        // Times (only for future events)
        if (chosenEvent.isPastEvent == NO) {
            
            // Times cell
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventDetailCell" forIndexPath:indexPath];
            
            // Disable tapping of cells
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            NSArray *sectionContents = [cellArray objectAtIndex:indexPath.section];
            
            UILabel *contentLabel = (UILabel *)[cell viewWithTag:101];
            
            contentLabel.numberOfLines = 0;
            
            contentLabel.text = [sectionContents objectAtIndex:indexPath.row];
            
            return cell;
            
        } else if (chosenEvent.isPastEvent == YES) {
            
            // Gallery cell
            NUSContainerTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContainerTableCell" forIndexPath:indexPath];
            
            // Disable tapping of cells
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            [cell setCollectionData:chosenEvent.eventGalleryImageUrls];
            
            return cell;
        }
    }
    return nil;
}

#pragma mark - Init methods

- (id)initWithChosenEventItem:(NUSEvent *)chosenEventValue
{
    self = [super init];
    
    if (self) {
        chosenEvent = chosenEventValue;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = chosenEvent.eventYear;
    
    // Init tableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Set tableView to have a bit of padding at the top & bottom so everything looks right
    [self.tableView setContentInset:UIEdgeInsetsMake(20, 0, 70, 0)];
    
    // Set tableView background colour
    [self.tableView setBackgroundColor:[UIColor colorWithRed:0.76 green:0.76 blue:0.76 alpha:1]];
    
    // Remove seperator insets from tableView
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    // Register cells with tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"NUSEventDetailCell" bundle:nil] forCellReuseIdentifier:@"EventDetailCell"];
    // Gallery cell
    [self.tableView registerClass:[NUSContainerTableCell class] forCellReuseIdentifier:@"ContainerTableCell"];
    
    // Add tableView to view
    [self.view addSubview:self.tableView];
    
    // Init cellArray data source
    [self initCellArrayDataSource];
}

#pragma mark - Init cellArray data source

- (void)initCellArrayDataSource
{
    cellArray = [[NSMutableArray alloc] init];
    eventDetails = [[NSMutableArray alloc] init];
    eventTimes = [[NSMutableArray alloc] init];
    eventGallery = [[NSMutableArray alloc] init];
    
    // TODO: add stuff to event details, times and gallery
    [eventDetails addObject:chosenEvent.eventContent];
    // TODO: add values from chosen event object
    [eventTimes addObject:@"event times"];
    [eventGallery addObject:@"gallery links"];
    
    [cellArray addObject:eventDetails];
    //[cellArray addObject:eventTimes];
    [cellArray addObject:eventGallery];
}

@end
