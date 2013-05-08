//
//  PhoneBooth.h
//  RetroPhoneHunter
//
//  Created by Paul Pilone on 5/8/13.
//  Copyright (c) 2013 Element 84, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PhoneBooth : NSManagedObject

@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * imagePath;
@property (nonatomic, retain) NSNumber * lat;
@property (nonatomic, retain) NSNumber * lon;

@end
