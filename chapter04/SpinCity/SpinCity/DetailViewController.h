//
//  DetailViewController.h
//  SpinCity
//
//  Created by Dan Pilone on 11/11/12.
//  Copyright (c) 2012 Element 84, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Album;

@interface DetailViewController : UITableViewController

@property (strong, nonatomic) Album *detailItem;

@end
