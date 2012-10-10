//
//  ViewController.m
//  MarcoPollo
//
//  Created by Dan Pilone on 10/9/12.
//  Copyright (c) 2012 Element 84, LLC. All rights reserved.
//

#import "ViewController.h"
#import "Social/Social.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)postItButtonPressed:(id)sender {
  NSLog(@"Post It button was pressed: %@", self.tweetTextView.text);
  NSString *tweetText = [NSString stringWithFormat:@"%@ #MarcoPollo", self.tweetTextView.text];
  
  SLComposeViewController *composer = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
  [composer setInitialText:tweetText];
  [self presentViewController:composer animated:YES completion:nil];
}
@end
