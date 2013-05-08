//
//  DetailViewController.h
//  RetroPhoneHunter
//
//  Created by Paul Pilone on 5/5/13.
//  Copyright (c) 2013 Element 84, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PhoneBooth.h"

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate, UITextViewDelegate>

@property (strong, nonatomic) PhoneBooth * detailItem;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *cityField;
@property (weak, nonatomic) IBOutlet UITextView *notesView;
- (IBAction)nameFieldEditingChanged:(id)sender;
- (IBAction)cityFieldEditingChanged:(id)sender;

@end
