//
//  LibraryAPI.h
//  BlueLibrary
//
//  Created by Inna Labuns'ka on 20.05.15.
//  Copyright (c) 2015 Eli Ganem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Album.h"

@interface LibraryAPI : NSObject

+ (LibraryAPI *)sharedInstance;

- (NSMutableArray *)albums;
- (void)addAlbum:(Album *)album atIndex:(NSUInteger)index;
- (void)deleteAlbumAtIndex:(NSUInteger)index;

@end
