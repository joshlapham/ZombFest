//
//  NUSEventMapViewController.h
//  Newcastle Undead Society
//
//  Created by jl on 3/08/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class NUSEvent;

@interface NUSEventMapViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) NUSEvent *chosenEvent;
@property (nonatomic, strong) NSString *chosenLat;
@property (nonatomic, strong) NSString *chosenLong;
@property (nonatomic, strong) NSString *markerTitle;
@property (nonatomic, strong) NSString *markerSubtitle;

@end
