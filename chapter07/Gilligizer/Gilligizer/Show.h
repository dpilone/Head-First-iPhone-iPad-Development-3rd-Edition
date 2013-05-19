//
//  Show.h
//  Gilligizer
//
//  Created by Paul Pilone on 4/23/13.
//  Copyright (c) 2013 Element 84, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Show : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSDate * showTime;
@property (nonatomic, retain) NSNumber * episodeID;
@property (nonatomic, retain) NSNumber * firstRun;

@end
