//
//  NoteAnnotation.h
//  MapDiaryDemo2
//
//  Created by Lion User on 11/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface NoteAnnotation : NSObject <MKAnnotation>
{
    CLLocationCoordinate2D coord;
}
+ (NoteAnnotation *)annotationForLocation:(CLLocationCoordinate2D)location;

@end
