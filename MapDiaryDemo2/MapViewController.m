//
//  MapViewController.m
//  MapDiaryDemo2
//
//  Created by Lion User on 11/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "NoteAnnotation.h"
#import "AddNoteViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize mapView = _mapView;
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.mapView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addLocation:)]];
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self saveLocation];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)addLocation:(UITapGestureRecognizer*) gesture
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    CLLocationCoordinate2D coord= [self.mapView convertPoint:[gesture locationInView:self.mapView] toCoordinateFromView:self.mapView];
    [self.mapView addAnnotation:[NoteAnnotation annotationForLocation:coord]];
    self->noteLocation = coord;
}

- (void)saveLocation
{
    [self.delegate didAddNewLocation:(self->noteLocation)];
}

@end
