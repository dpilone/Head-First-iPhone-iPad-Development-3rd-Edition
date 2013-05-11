//
//  PhoneBooth.m
//  RetroPhoneHunter
//
//  Created by Paul Pilone on 5/8/13.
//  Copyright (c) 2013 Element 84, LLC. All rights reserved.
//

#import "PhoneBooth.h"


@implementation PhoneBooth

@dynamic city;
@dynamic name;
@dynamic notes;
@dynamic imagePath;
@dynamic lat;
@dynamic lon;

@dynamic coordinate;

- (CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake([self.lat doubleValue],
                                      [self.lon doubleValue]);
}

- (NSString *)title
{
    return self.name;
}

- (NSString *)subtitle
{
    return self.notes;
}

@end
