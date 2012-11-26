//
//  MasterViewController.m
//  SpinCity
//
//  Created by Dan Pilone on 11/11/12.
//  Copyright (c) 2012 Element 84, LLC. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "AlbumDataController.h"
#import "Album.h"
#import "AlbumTableViewCell.h"

@interface MasterViewController ()
  @property (nonatomic, strong) AlbumDataController *albumDataController;
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.albumDataController = [[AlbumDataController alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.albumDataController albumCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlbumCell" forIndexPath:indexPath];

    Album *album = [self.albumDataController albumAtIndex:indexPath.row];
    cell.albumTitleLabel.text = album.title;
    cell.albumSummaryLabel.text = album.summary;
    cell.priceLabel.text = [NSString stringWithFormat:@"$%01.2f", album.price];

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowAlbumDetails"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Album *album = [self.albumDataController albumAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailItem:album];
    }
}

@end
