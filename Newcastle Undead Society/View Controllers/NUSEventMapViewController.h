//
//  NUSEventMapViewController.h
//  Newcastle Undead Society
//
//  Created by jl on 3/08/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface NUSEventMapViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) NSDictionary *chosenEventDataDict;

@end
