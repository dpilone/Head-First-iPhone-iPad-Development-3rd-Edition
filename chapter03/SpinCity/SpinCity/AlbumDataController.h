//
//  AlbumDataController.h
//  SpinCity
//
//  Created by Dan Pilone on 8/29/12.
//  Copyright (c) 2012 Dan Pilone. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Album;

@interface AlbumDataController : NSObject

- (NSUInteger)albumCount;
- (Album *)albumAtIndex:(NSUInteger)index;
- (void)addAlbumWithTitle:(NSString *)title artist:(NSString *)artist summary:(NSString *)summary price:(float)price locationInStore:(NSString*)locationInStore;

@end
