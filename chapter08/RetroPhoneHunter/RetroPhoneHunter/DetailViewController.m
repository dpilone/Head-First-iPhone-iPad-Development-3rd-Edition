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
@property (strong, nonatomic) CLLocationManager *locationManager;

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
        
        if (self.detailItem.lat != nil && self.detailItem.lon != nil) {
            self.locationLabel.text = [NSString stringWithFormat:@"%.3f, %.3f",
                                       [self.detailItem.lat doubleValue],
                                       [self.detailItem.lon doubleValue]];

            // Add the annotation to the map and zoom to it.
            [self.mapView addAnnotation:self.detailItem];
            MKCoordinateRegion region;
            region.center.latitude = [self.detailItem.lat doubleValue];
            region.center.longitude = [self.detailItem.lon doubleValue];
            region.span.latitudeDelta = 0.5;
            region.span.longitudeDelta = 0.5;
            
            [self.mapView setRegion:region animated:YES];
        } else {
            self.locationLabel.text = @"No location.";
        }
    }
}

- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        _locationManager.delegate = self;
    }
    
    return _locationManager;
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
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"This device has a camera. Asking the user what they want to use.");
        UIActionSheet *photoSourceSheet = [[UIActionSheet alloc] initWithTitle:@"Select PhoneBooth Picture"
                                                                      delegate:self
                                                             cancelButtonTitle:nil
                                                        destructiveButtonTitle:nil
                                                             otherButtonTitles:@"Take New Photo",
                                                                               @"Choose Existing Photo", nil];
        // Show the action sheet near the add image button.
        [photoSourceSheet showFromRect:((UIButton *)sender).frame inView:self.view animated:YES];
    }
    else { // No camera. Just use the library.
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        picker.delegate = self;
        
        self.imagePickerPopoverController = [[UIPopoverController alloc] initWithContentViewController:picker];
        self.imagePickerPopoverController.delegate = self;
        [self.imagePickerPopoverController presentPopoverFromRect:((UIButton *)sender).frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    }
}

- (IBAction)locatePhoneboothButtonPressed:(id)sender
{
    [self.locationManager startUpdatingLocation];
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

#pragma mark -
#pragma mark UIActionSheetDelegate methods

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        NSLog(@"The user cancelled adding a image.");
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;

    switch (buttonIndex) {
        case 0:
            NSLog(@"User wants to take a new picture.");
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        default:
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
    }
    
    self.imagePickerPopoverController = [[UIPopoverController alloc] initWithContentViewController:picker];
    self.imagePickerPopoverController.delegate = self;
    [self.imagePickerPopoverController presentPopoverFromRect:self.takePictureButton.frame
                                                       inView:self.view
                                     permittedArrowDirections:UIPopoverArrowDirectionLeft
                                                     animated:YES];
}

#pragma mark -
#pragma mark CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"Core location claims to have a position.");
    CLLocation *location = [locations lastObject];
    
    // Update the phonebooth and view.
    self.detailItem.lat = [NSNumber numberWithDouble:location.coordinate.latitude];
    self.detailItem.lon = [NSNumber numberWithDouble:location.coordinate.longitude];
    
    [self configureView];
    
    // Stop monitoring locations. In a real application, you would probably to keep updating
    // the location to get the most accurate position.
    NSLog(@"Shutting down core location.");
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Core location can't get a fix!");
    
    // Update the view to alert the user that we can't get a location.
    self.locationLabel.text = @"Can't get a location.";
}

@end
