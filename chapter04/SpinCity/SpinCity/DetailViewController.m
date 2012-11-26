//
//  DetailViewController.m
//  SpinCity
//
//  Created by Dan Pilone on 11/11/12.
//  Copyright (c) 2012 Element 84, LLC. All rights reserved.
//

#import "DetailViewController.h"
#import "Album.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

  if (self.detailItem) {
      self.albumTitleLabel.text = self.detailItem.title;
      self.priceLabel.text = [NSString stringWithFormat:@"$%01.2f", self.detailItem.price];
      self.artistLabel.text = self.detailItem.artist;
      self.locationLabel.text = self.detailItem.locationInStore;
      self.descriptionTextView.text = self.detailItem.summary;
  }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
  [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
