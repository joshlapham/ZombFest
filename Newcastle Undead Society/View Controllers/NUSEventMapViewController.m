//
//  NUSEventMapViewController.m
//  Newcastle Undead Society
//
//  Created by jl on 3/08/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSEventMapViewController.h"

@interface NUSEventMapViewController () {
    MKPointAnnotation *_eventLocation;
    MKAnnotationView *_eventLocationAnnotationView;
}

@property (strong, nonatomic) IBOutlet UIView *mapCalloutView;

@end

@implementation NUSEventMapViewController

#pragma mark - MKMapView delegate methods

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    DDLogVerbose(@"Event map: did select pin");
    
    // Init this so that we can keep track of it
    _eventLocationAnnotationView = view;
    
    // Init .xib
    [[NSBundle mainBundle] loadNibNamed:@"NUSMapCallout" owner:self options:nil];
    
    // Init labels
    UILabel *titleLabel = (UILabel *)[self.mapCalloutView viewWithTag:101];
    UILabel *subtitleLabel = (UILabel *)[self.mapCalloutView viewWithTag:102];
    
    // TODO: update categories so this VC has specific fonts and font colours
    [titleLabel setFont:[UIFont navbarFont]];
    [titleLabel setTextColor:[UIColor newsFeedItemTitleColour]];
    [subtitleLabel setFont:[UIFont navbarButtonFont]];
    [titleLabel setText:self.markerTitle];
    [subtitleLabel setText:self.markerSubtitle];
    
    // Set frame of custom callout
    [self.mapCalloutView setFrame:CGRectMake(CGRectGetMidX(view.frame)-100, view.frame.origin.y-75, 200, 72)];

    // Add callout to view
    [self.view addSubview:self.mapCalloutView];
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    // Remove the custom callout view
    if (self.mapCalloutView) {
        [self.mapCalloutView removeFromSuperview];
    }
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    DDLogVerbose(@"MAP - region WILL change");
    
    // NOTE - we're just hiding the annotation for now
    [self.mapView deselectAnnotation:_eventLocation animated:NO];
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    DDLogVerbose(@"MAP - region did change");
    
    // Update callout's frame
    [self.mapCalloutView setFrame:CGRectMake(CGRectGetMidX(_eventLocationAnnotationView.frame)-100, _eventLocationAnnotationView.frame.origin.y-75, 200, 72)];
    
    // Show annotation
    [self.mapView selectAnnotation:_eventLocation animated:NO];
}

#pragma mark - Init method

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set title
    self.title = @"Map";
    // Use markerTitle as title for view, as this is our location name
    //self.title = self.markerTitle;
    
    // Init mapView
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    self.mapView.delegate = self;
    
    // Center on Newcastle
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(-32.929347, 151.778322), 3000.0, 3000.0) animated:YES];
    
    // Init lat and long
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake([self.chosenLat doubleValue], [self.chosenLong doubleValue]);
    
    // Init marker
    _eventLocation = [[MKPointAnnotation alloc] init];
    _eventLocation.coordinate = location;
    
    // Add marker to map
    [self.mapView addAnnotation:_eventLocation];
    
    // Add mapView to view
    [self.view addSubview:self.mapView];
    
    // Zoom to marker on map
    [self.mapView setCenterCoordinate:_eventLocation.coordinate animated:NO];
    
    // Automatically show annotation callout
    [self.mapView selectAnnotation:_eventLocation animated:YES];
}

@end
