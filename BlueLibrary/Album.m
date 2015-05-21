//
//  Album.m
//  BlueLibrary
//
//  Created by Inna Labuns'ka on 20.05.15.
//  Copyright (c) 2015 Eli Ganem. All rights reserved.
//

#import "Album.h"

@implementation Album

- (instancetype) initWithTitle:(NSString *)title
                         artist:(NSString *)artist
                      coverUrl:(NSString *)coverURL
                          year:(NSString *)year
{
    self = [super init];
    if (self) {
        _title = title;
        _artist = artist;
        _coverURL = coverURL;
        _year = year;
        _genre = @"POP";
        
    }
    return self;
}
@end
