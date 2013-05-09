//
//  DetailViewController.m
//  RetroPhoneHunter
//
//  Created by Paul Pilone on 5/5/13.
//  Copyright (c) 2013 Element 84, LLC. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (strong, nonatomic) UIPopoverController *imagePickerPopoverController;

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

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.nameField.text = self.detailItem.name;
        self.cityField.text = self.detailItem.city;
        self.notesView.text = self.detailItem.notes;
        self.imageView.image = [UIImage imageWithContentsOfFile:self.detailItem.imagePath];
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

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

- (IBAction)nameFieldEditingChanged:(id)sender
{
    self.detailItem.name = self.nameField.text;
}

- (IBAction)cityFieldEditingChanged:(id)sender
{
    self.detailItem.city = self.cityField.text;
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.detailItem.notes = self.notesView.text;
}

- (IBAction)takePictureButtonPressed:(id)sender
{
    NSLog(@"Taking a picture...");
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera | UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = YES;
    picker.delegate = self;
    
    self.imagePickerPopoverController = [[UIPopoverController alloc] initWithContentViewController:picker];
    self.imagePickerPopoverController.delegate = self;
    [self.imagePickerPopoverController presentPopoverFromRect:((UIButton *)sender).frame
                                                       inView:self.view
                                     permittedArrowDirections:UIPopoverArrowDirectionLeft
                                                     animated:YES];
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Construct the path to the file in our Documents Directory.
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *uniqueFilename = [[NSUUID UUID] UUIDString];
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:uniqueFilename];
    
    // Get the image from the picker and write it to disk.
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
    
    // Save the path to the image in our model so that it can be retrieved later.
    self.detailItem.imagePath = imagePath;
    
    // Update the image view.
    self.imageView.image = image;
    
    // Dismiss the picker by dismissing our popover controller.
    [self.imagePickerPopoverController dismissPopoverAnimated:YES];
    self.imagePickerPopoverController = nil;
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    // Dismiss the picker by dismissing our popover controller.
    [self.imagePickerPopoverController dismissPopoverAnimated:YES];
    self.imagePickerPopoverController = nil;
}

#pragma mark -
#pragma mark UIPopoverControllerDelegate methods

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.imagePickerPopoverController = nil;
}

@end
