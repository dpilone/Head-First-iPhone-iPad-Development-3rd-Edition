//
//  ViewController.h
//  MarcoPollo
//
//  Created by Dan Pilone on 10/9/12.
//  Copyright (c) 2012 Element 84, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;

- (IBAction)postItButtonPressed:(id)sender;

@end
