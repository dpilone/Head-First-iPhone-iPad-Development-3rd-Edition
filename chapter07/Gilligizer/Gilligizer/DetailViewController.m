//
//  DetailViewController.m
//  Gilligizer
//
//  Created by Paul Pilone on 4/22/13.
//  Copyright (c) 2013 Element 84, LLC. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (void)configureView;

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *episodeIDField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *firstRunSegmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *showTimeLabel;

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
        self.titleField.text = [self.detailItem valueForKey:@"title"];
        self.episodeIDField.text = [NSString stringWithFormat:@"%d", [[self.detailItem valueForKey:@"episodeID"] integerValue]];
        self.descriptionView.text = [self.detailItem valueForKey:@"desc"];
        self.firstRunSegmentedControl.selectedSegmentIndex = [[self.detailItem valueForKey:@"firstRun"] boolValue];
        self.showTimeLabel.text = [[self.detailItem valueForKey:@"showTime"] description];
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

#pragma mark - Editing

- (IBAction)textFieldEditingChanged:(id)sender
{
    if ([sender isEqual:self.titleField]) {
        [self.detailItem setValue:self.titleField.text forKey:@"title"];
    }
    else {
        [self.detailItem setValue:[NSNumber numberWithInteger:[self.episodeIDField.text integerValue]] forKey:@"episodeID"];
    }
}

- (IBAction)newEpisodeValueChanged:(id)sender
{
    [self.detailItem setValue:[NSNumber numberWithBool:self.firstRunSegmentedControl.selectedSegmentIndex] forKey:@"firstRun"];
}

#pragma mark - UITextFieldDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    [self.detailItem setValue:textView.text forKey:@"desc"];
}

@end
