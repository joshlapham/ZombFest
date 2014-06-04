//
//  NUSSocialLinkListViewController.m
//  Newcastle Undead Society
//
//  Created by jl on 11/03/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSSocialLinkListViewController.h"
#import "PBWebViewController.h"

@interface NUSSocialLinkListViewController ()

@end

@implementation NUSSocialLinkListViewController {
    NSArray *socialListItems;
    NSArray *eventsListItems;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    socialListItems = [NSArray arrayWithObjects:@"Facebook", @"Twitter", @"Tumblr", nil];
    eventsListItems = [NSArray arrayWithObjects:@"2014", @"2013", @"2012", @"2011", @"2010", @"2009", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return [socialListItems count];
    } else if (section == 1) {
        return [eventsListItems count];
    }
    // return nil
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SocialLinkCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (indexPath.section == 0) {
        cell.textLabel.text = [socialListItems objectAtIndex:indexPath.row];
    } else if (indexPath.section == 1) {
        cell.textLabel.text = [eventsListItems objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Check to see what link was clicked
    // REVIEW: cause this code kinda sucks
    NSURL *url = [[NSURL alloc] init];
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                url = [NSURL URLWithString:@"https://www.facebook.com/NewcastleUndeadSociety"];
                //NSLog(@"URL IS: %@", url);
                break;
                
            case 1:
                url = [NSURL URLWithString:@"https://twitter.com/UndeadSociety"];
                //NSLog(@"URL IS: %@", url);
                break;
                
            case 2:
                url = [NSURL URLWithString:@"http://newcastleundeadsociety.tumblr.com/"];
                //NSLog(@"URL IS: %@", url);
                break;
                
            default:
                NSLog(@"NO URL");
                break;
        }
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        
        // Initialize the web view controller and set it's URL
        PBWebViewController *webViewController = [[PBWebViewController alloc] init];
        webViewController.URL = url;
        
        // These are custom UIActivity subclasses that will show up in the UIActivityViewController
        // when the action button is clicked
        //PBSafariActivity *activity = [[PBSafariActivity alloc] init];
        //webViewController.applicationActivities = @[activity];
        
        // This property also corresponds to the same one on UIActivityViewController
        // Both properties do not need to be set unless you want custom actions
        //webViewController.excludedActivityTypes = @[UIActivityTypeMail, UIActivityTypeMessage, UIActivityTypePostToWeibo];
        
        // Hide tabbar on detail view
        //webViewController.hidesBottomBarWhenPushed = YES;
        
        // Push it
        [self.navigationController pushViewController:webViewController animated:YES];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return [NSString stringWithFormat:@"Social Media"];
    } else if (section == 1) {
        return [NSString stringWithFormat:@"Events"];
    }
    // return nil
    return nil;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
