//
//  NoteAnnotation.m
//  MapDiaryDemo2
//
//  Created by Lion User on 11/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NoteAnnotation.h"

@implementation NoteAnnotation

+ (NoteAnnotation *)annotationForLocation:(CLLocationCoordinate2D)location
{
    NoteAnnotation* annotation = [[NoteAnnotation alloc] init];
    annotation->coord = location;
    return annotation;
}

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coordinate;
    coordinate = coord;
    return coordinate;
}


@end
