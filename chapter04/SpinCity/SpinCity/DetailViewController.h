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
@property (weak, nonatomic) IBOutlet UILabel *albumTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@end
