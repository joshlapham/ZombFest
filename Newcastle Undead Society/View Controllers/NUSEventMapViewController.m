//
//  NUSEventMapViewController.m
//  Newcastle Undead Society
//
//  Created by jl on 3/08/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NUSEventMapViewController.h"

@interface NUSEventMapViewController ()

@end

@implementation NUSEventMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Use markerTitle as title for view, as this is our location name
    self.title = self.markerTitle;
    
    // Init mapView
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    self.mapView.delegate = self;
    
    // Center on Newcastle
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(-32.929347, 151.778322), 3000.0, 3000.0) animated:YES];
    
    // Init lat and long
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake([self.chosenLat doubleValue], [self.chosenLong doubleValue]);
    
    MKPointAnnotation *eventLocation = [[MKPointAnnotation alloc] init];
    eventLocation.coordinate = location;
    eventLocation.title = self.markerTitle;
    eventLocation.subtitle = self.markerSubtitle;
    
    // Add marker to map
    [self.mapView addAnnotation:eventLocation];
    
    // Add mapView to view
    [self.view addSubview:self.mapView];
}

@end
