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
#import "MWPhotoBrowser.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NUSDataStore.h"
#import "NUSVideo.h"
#import "PBWebViewController.h"
#import "NUSEventMapViewController.h"

@interface NUSEventDetailViewController () <MWPhotoBrowserDelegate>

@end

@implementation NUSEventDetailViewController {
    NSMutableArray *cellArray;
    NSMutableArray *eventTimes;
    NSMutableArray *eventDetails;
    NSMutableArray *eventVideos;
    NSMutableArray *photosForBrowser;
    NSMutableArray *_eventArticles;
}

@synthesize eventYear, chosenEvent;

#pragma mark - UITableViewDataSource delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [cellArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1 && chosenEvent.isPastEvent == YES) {
        // Return 1 so gallery cell will show
        return 1;
    } else if (section == 2 && chosenEvent.isPastEvent == YES) {
        // Videos
        // Return number of videos
        return [eventVideos count];
    } else if (section == 3 && chosenEvent.isPastEvent == YES && [chosenEvent.eventArticles count] > 0) {
        // Articles
        // Return number of articles
        return [chosenEvent.eventArticles count];
    } else {
        NSArray *sectionContents = [cellArray objectAtIndex:section];
        
        return [sectionContents count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && chosenEvent.isPastEvent == YES) {
        // For Gallery cell
        return 170;
    } else if (indexPath.section == 1 && chosenEvent.isPastEvent == NO) {
        // For Time cell
        return 60;
    } else if (indexPath.section == 2 && chosenEvent.isPastEvent == YES) {
        // For Video cell
        return 120;
    } else if (indexPath.section == 3 && chosenEvent.isPastEvent == YES) {
        // For Article cell
        return 100;
    } else {
        // For all other cells (Details)
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    // If event image section ..
    if (section == 0) {
        return 150;
    } else {
        // For all other headers (which are text only)
        return 40;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *headerText;
    
    switch (section) {
            
        case 0:
            // Details section
            // TODO: delete this, we don't need it as we're using an image instead
            //headerText = NSLocalizedString(@"Details", nil);
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
            
        case 2:
            // Videos (only for past events)
            if (chosenEvent.isPastEvent == YES && [eventVideos count] > 0) {
                headerText = NSLocalizedString(@"Videos", nil);
            }
            break;
            
        case 3:
            // Articles (only for past events)
            if (chosenEvent.isPastEvent == YES && [chosenEvent.eventArticles count] > 0) {
                headerText = NSLocalizedString(@"Articles", nil);
            }
            break;
            
        default:
            headerText = nil;
            break;
    }
    
    // Init custom header view
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 20)];
    
    // Init image view for event photo
    UIView *headerImageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 150)];
    UIImageView *eventDetailImageView = [[UIImageView alloc] initWithFrame:headerImageView.frame];
    
    // Init header label
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:headerView.bounds];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.adjustsFontSizeToFitWidth = YES;
    headerLabel.textAlignment = NSTextAlignmentCenter;
    
    // Set header font colour
    // TODO: update to use categories
    // Dark Pastel Red
    headerLabel.textColor = [UIColor colorWithRed:0.75 green:0.22 blue:0.17 alpha:1];
    
    // Set header label font
    // TODO: update to use categories
    UIFont *headerLabelFont = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20];
    headerLabel.font = headerLabelFont;
    
    // Set header label text
    headerLabel.text = headerText;
    
    // If this is the event photo section, then add event photo image view ..
    if (section == 0) {
        // Fetch event image
        [eventDetailImageView setImageWithURL:[NSURL URLWithString:chosenEvent.eventImageUrl]
                      placeholderImage:nil
                             completed:^(UIImage *cellImage, NSError *error, SDImageCacheType cacheType) {
                                 if (cellImage && !error) {
                                     //DDLogVerbose(@"Fetched cell thumbnail image");
                                 } else {
                                     DDLogError(@"Event detail: error fetching event image: %@", [error localizedDescription]);
                                     // TODO: implement fallback
                                 }
                             }];
        
        // Add to headerImageView
        [headerImageView addSubview:eventDetailImageView];
        
        return headerImageView;
    } else {
        // For all other sections, add header text
        [headerView addSubview:headerLabel];
        
        return headerView;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        // Details section
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventDetailCell" forIndexPath:indexPath];
        
        // Set cell background colour
        [cell setBackgroundColor:[UIColor backgroundColorForMostViews]];
        
        // Disable tapping of cells
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        // Init date label
        UILabel *contentLabel = (UILabel *)[cell viewWithTag:101];
        [contentLabel setTextAlignment:NSTextAlignmentCenter];
        
        // Set content label font and colour
        [contentLabel setFont:[UIFont eventDetailDateFont]];
        // TODO: what to use for date font colour?
        //[contentLabel setTextColor:[UIColor headerTextColour]];
        [contentLabel setTextColor:[UIColor darkGrayColor]];
        
        // Init date formatter
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        // Use date format used in JSON
        [df setDateFormat:@"dd/MM/yyyy"];
        NSDate *date = [[NSDate alloc] init];
        date = [df dateFromString:chosenEvent.eventDate];
        
        // Init another date formatter for nicer output
        if (date != nil) {
            NSDateFormatter *userVisibleDF = [[NSDateFormatter alloc] init];
            [userVisibleDF setDateStyle:NSDateFormatterLongStyle];
            
            [contentLabel setText:[userVisibleDF stringFromDate:date]];
        }
        
        return cell;
        
    } else if (indexPath.section == 1) {
        // Times/Gallery section
        
        // Times (only for future events)
        if (chosenEvent.isPastEvent == NO) {
            
            // Times cell
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventTimeCell" forIndexPath:indexPath];
            
            // Set cell background colour
            [cell setBackgroundColor:[UIColor backgroundColorForMostViews]];
            
            // Disable tapping of cells
            //[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            NSArray *sectionContents = [cellArray objectAtIndex:indexPath.section];
            
            UILabel *locationLabel = (UILabel *)[cell viewWithTag:101];
            UILabel *timeLabel = (UILabel *)[cell viewWithTag:102];
            
            locationLabel.text = [[sectionContents objectAtIndex:indexPath.row] objectForKey:@"locationName"];
            timeLabel.text = [[sectionContents objectAtIndex:indexPath.row] objectForKey:@"startTime"];
            
            // Set label font
            // TODO: update to use categories
            UIFont *locationAndTimeLabelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
            [locationLabel setFont:locationAndTimeLabelFont];
            [timeLabel setFont:locationAndTimeLabelFont];
            
            return cell;
            
        } else if (chosenEvent.isPastEvent == YES) {
            
            // Gallery cell
            NUSContainerTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContainerTableCell" forIndexPath:indexPath];
            
            // Set cell background colour
            [cell setBackgroundColor:[UIColor backgroundColorForMostViews]];
            
            // Disable tapping of cells
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            [cell setCollectionData:chosenEvent.eventGalleryImageUrls];
            
            return cell;
        }
    } else if (indexPath.section == 2) {
        
        if (chosenEvent.isPastEvent == YES && [eventVideos count] > 0) {
            // Video cell
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoCell" forIndexPath:indexPath];
            
            // Set cell background colour
            [cell setBackgroundColor:[UIColor backgroundColorForMostViews]];
            
            NUSVideo *cellData = [eventVideos objectAtIndex:indexPath.row];
            
            // Init cell labels
            UILabel *titleLabel = (UILabel *)[cell viewWithTag:101];
            UILabel *durationLabel = (UILabel *)[cell viewWithTag:102];
            UIImageView *cellImageView = (UIImageView *)[cell viewWithTag:103];
            UILabel *authorLabel = (UILabel *)[cell viewWithTag:104];
            UILabel *yearLabel = (UILabel *)[cell viewWithTag:105];
            
            // Ensure things fit in labels
            titleLabel.adjustsFontSizeToFitWidth = YES;
            authorLabel.adjustsFontSizeToFitWidth = YES;
            
            // Set video title and duration
            titleLabel.text = cellData.title;
            durationLabel.text = cellData.duration;
            
            // Set video title font
            // TODO: update to use categories
            UIFont *titleFont = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18];
            titleLabel.font = titleFont;
            
            // Set video author font
            // TODO: update to use categories
            UIFont *authorFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
            authorLabel.font = authorFont;
            
            // Set year and duration font
            // TODO: update to use categories
            UIFont *sharedYearAndDurationFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
            yearLabel.font = sharedYearAndDurationFont;
            durationLabel.font = sharedYearAndDurationFont;
            
            // Set author and year
            NSString *byString = NSLocalizedString(@"By", nil);
            authorLabel.text = [NSString stringWithFormat:@"%@ %@", byString, cellData.author];
            yearLabel.text = cellData.year;
            
            // Set cell thumbnail using SDWebImage
            [cellImageView setImageWithURL:[NSURL URLWithString:cellData.thumbUrl]
                          placeholderImage:nil
                                 completed:^(UIImage *cellImage, NSError *error, SDImageCacheType cacheType) {
                                     if (cellImage && !error) {
                                         //DDLogVerbose(@"Fetched cell thumbnail image");
                                     } else {
                                         DDLogError(@"Events: error fetching video cell thumbnail image: %@", [error localizedDescription]);
                                         // TODO: implement fallback
                                     }
                                 }];
            
            return cell;
        }
    } else if (indexPath.section == 3) {
        
        if (chosenEvent.isPastEvent == YES && [chosenEvent.eventArticles count] > 0) {
            // Article cell
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArticleCell" forIndexPath:indexPath];
            
            // Cell data
            NSDictionary *cellData = [chosenEvent.eventArticles objectAtIndex:indexPath.row];
            
            // Set cell background colour
            [cell setBackgroundColor:[UIColor backgroundColorForMostViews]];
            
            // Init cell labels
            UILabel *titleLabel = (UILabel *)[cell viewWithTag:101];
            UILabel *authorLabel = (UILabel *)[cell viewWithTag:102];
            UILabel *dateLabel = (UILabel *)[cell viewWithTag:103];
            
            // Ensure things fit in labels
            [titleLabel setAdjustsFontSizeToFitWidth:YES];
            [dateLabel setAdjustsFontSizeToFitWidth:YES];
            
            // Set article title
            titleLabel.text = [cellData objectForKey:@"title"];
            
            // Set author and date text
            [authorLabel setText:[cellData objectForKey:@"author"]];
            [dateLabel setText:[cellData objectForKey:@"date"]];
            
            // Set title font
            [titleLabel setFont:[UIFont articleTitleFont]];
            
            // Set author and date fonts
            [authorLabel setFont:[UIFont articleAuthorFont]];
            [authorLabel setTextColor:[UIColor darkGrayColor]];
            [dateLabel setFont:[UIFont articleDateFont]];
            [dateLabel setTextColor:[UIColor lightGrayColor]];
            
            return cell;
        }
    }
    
    return nil;
}

// For Video selection (past events) and event times (future events)
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // If Videos section ..
    if (indexPath.section == 2 && chosenEvent.isPastEvent == YES) {
        
        NUSVideo *cellData = [eventVideos objectAtIndex:indexPath.row];
        
        // Init string with title of social link
        NSString *videoLinkTitle = cellData.title;
        
        // Init NSURL with video link URL from cellArray
        NSURL *videoLinkUrl = [NSURL URLWithString:cellData.videoUrl];
        
        // Initialize the web view controller and set its' URL
        PBWebViewController *webViewController = [[PBWebViewController alloc] init];
        webViewController.URL = videoLinkUrl;
        // TODO: localize this title?
        webViewController.title = videoLinkTitle;
        
        // Set back button text to be chosen event year
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:chosenEvent.eventYear style:UIBarButtonItemStylePlain target:nil action:nil];
        
        // Show web view controller with video link
        [self.navigationController pushViewController:webViewController animated:YES];
        
    } else if (indexPath.section == 1 && chosenEvent.isPastEvent == NO) {
        // Times section (for future event only)
        NSDictionary *cellData = [self.chosenEvent.eventTimes objectAtIndex:indexPath.row];
        
        // Init map view controller
        NUSEventMapViewController *destViewController = [[NUSEventMapViewController alloc] init];
        destViewController.chosenEvent = self.chosenEvent;
        destViewController.chosenLat = [cellData objectForKey:@"lat"];
        destViewController.chosenLong = [cellData objectForKey:@"long"];
        destViewController.markerTitle = [cellData objectForKey:@"locationName"];
        destViewController.markerSubtitle = [cellData objectForKey:@"startTime"];
        
        // Set back button of navbar to chosen event year
        // TODO: localize title, as we're using a year?
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:chosenEvent.eventYear style:UIBarButtonItemStylePlain target:nil action:nil];
        
        // Show map view controller
        [self.navigationController pushViewController:destViewController animated:YES];
        
    } else if (indexPath.section == 3 && chosenEvent.isPastEvent == YES && [chosenEvent.eventArticles count] > 0) {
        // Articles section (for past events only)
        NSDictionary *cellData = [chosenEvent.eventArticles objectAtIndex:indexPath.row];
        
        // Init string with title of social link
        NSString *articleLinkTitle = [cellData objectForKey:@"title"];
        
        // Init NSURL with video link URL from cellArray
        NSURL *articleLinkUrl = [NSURL URLWithString:[cellData objectForKey:@"url"]];
        
        // Initialize the web view controller and set its' URL
        PBWebViewController *webViewController = [[PBWebViewController alloc] init];
        webViewController.URL = articleLinkUrl;
        webViewController.title = articleLinkTitle;
        
        // Set back button text to be chosen event year
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:chosenEvent.eventYear style:UIBarButtonItemStylePlain target:nil action:nil];
        
        // Show web view controller with video link
        [self.navigationController pushViewController:webViewController animated:YES];

    }
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
    
    // Set tableView to have a bit of padding at the bottom so everything looks right
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 70, 0)];
    
    // Set tableView background colour
    // White (Gallery)
    [self.tableView setBackgroundColor:[UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1]];
    
    // Make tableView seperator insets extend to edges
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    
    // Register cells with tableView
    // Event Detail cell
    [self.tableView registerNib:[UINib nibWithNibName:@"NUSEventDetailCell" bundle:nil] forCellReuseIdentifier:@"EventDetailCell"];
    
    // Event Time cell
    [self.tableView registerNib:[UINib nibWithNibName:@"NUSEventTimeCell" bundle:nil] forCellReuseIdentifier:@"EventTimeCell"];
    
    // Gallery cell
    [self.tableView registerClass:[NUSContainerTableCell class] forCellReuseIdentifier:@"ContainerTableCell"];
    
    // Video cell
    [self.tableView registerNib:[UINib nibWithNibName:@"NUSVideoCell" bundle:nil] forCellReuseIdentifier:@"VideoCell"];
    
    // Article cell
    // TODO: make this cell
    [self.tableView registerNib:[UINib nibWithNibName:@"NUSArticleCell" bundle:nil] forCellReuseIdentifier:@"ArticleCell"];
    
    // Add tableView to view
    [self.view addSubview:self.tableView];
    
    // Init cellArray data source
    [self initCellArrayDataSource];
    
    // Add observer that will allow the nested collection cell to trigger the view controller select row at index path
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didSelectItemFromCollectionView:)
                                                 name:@"didSelectItemFromCollectionView"
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    // Clear tableView selection (for videos)
    NSIndexPath *selectedRowIndexPath = self.tableView.indexPathForSelectedRow;
    
    if (selectedRowIndexPath) {
        [self.tableView deselectRowAtIndexPath:selectedRowIndexPath animated:YES];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"didSelectItemFromCollectionView" object:nil];
}

#pragma mark - Init cellArray data source

- (void)initCellArrayDataSource
{
    cellArray = [[NSMutableArray alloc] init];
    eventDetails = [[NSMutableArray alloc] init];
    eventTimes = [[NSMutableArray alloc] init];
    _eventArticles = [[NSMutableArray alloc] init];
    
    // TODO: implement this whole method better
    
    // Event details
    // TODO: review this, not needed as we're using event date for this
    // Although, the date could still be added here rather than accessing
    // chosenEvent.eventDate in cellForRow method
    [eventDetails addObject:chosenEvent.eventContent];
    
    // Event times (future event)
    for (NSString *eventTime in chosenEvent.eventTimes) {
        [eventTimes addObject:eventTime];
    }
    
    [cellArray addObject:eventDetails];
    [cellArray addObject:eventTimes];
    
    // Event videos (past event)
    eventVideos = [NSMutableArray arrayWithArray:[NUSDataStore returnAllVideosFromCacheForYear:chosenEvent.eventYear]];
    
    // Add videos to cellArray if it isn't empty, so that Videos section won't appear if not needed
    if ([eventVideos count] > 0) {
        [cellArray addObject:eventVideos];
        DDLogVerbose(@"Events: event %@ has video count: %d", chosenEvent.eventYear, [eventVideos count]);
    }
    
    // Add articles to cellArray if it isn't empty, so that Articles section won't appear if not needed
    if ([chosenEvent.eventArticles count] > 0) {
        [cellArray addObject:chosenEvent.eventArticles];
    }
    
    // MWPhotoBrowser
    photosForBrowser = [[NSMutableArray alloc] init];
    
    // Loop over our chosenEvent's gallery URLs
    for (NSString *imageUrl in chosenEvent.eventGalleryImageUrls) {
        [photosForBrowser addObject:[MWPhoto photoWithURL:[NSURL URLWithString:imageUrl]]];
    }
    DDLogVerbose(@"Photos for browser count: %d", [photosForBrowser count]);
}

#pragma mark - MWPhotoBrowser delegate methods

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return [photosForBrowser count];
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index < [photosForBrowser count]) {
        return [photosForBrowser objectAtIndex:index];
    }
    return nil;
}

#pragma mark - NSNotification to select table cell

- (void)didSelectItemFromCollectionView:(NSNotification *)notification
{
    // Index path for chosen photo
    NSIndexPath *chosenPhotoIndex = [notification object];
    
    // Init MWPhotoBrowser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    // Start on chosen photo
    [browser setCurrentPhotoIndex:chosenPhotoIndex.row];
    
    // Use chosen event year for back button text
    // TODO: localize this, as we're using a year?
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:chosenEvent.eventYear style:UIBarButtonItemStylePlain target:nil action:nil];
    
    // Present photo browser (push)
    [self.navigationController pushViewController:browser animated:YES];
    
    // Present photo browser (modal)
    //UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
    //nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //[self presentViewController:nc animated:YES completion:nil];
}

@end
