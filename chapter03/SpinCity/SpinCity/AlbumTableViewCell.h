//
//  AlbumTableViewCell.h
//  SpinCity
//
//  Created by Dan Pilone on 11/16/12.
//  Copyright (c) 2012 Element 84, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *albumTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumSummaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end
