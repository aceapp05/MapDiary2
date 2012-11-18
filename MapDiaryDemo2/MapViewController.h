//
//  MapViewController.h
//  MapDiaryDemo2
//
//  Created by Lion User on 11/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol MapViewControllerDelegate <NSObject>

- (void) didAddNewLocation:(CLLocationCoordinate2D) location;

@end

@interface MapViewController : UIViewController <MKMapViewDelegate>
{
    CLLocationCoordinate2D noteLocation;
}
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) id<MapViewControllerDelegate> delegate;

- (void)saveLocation;

@end
