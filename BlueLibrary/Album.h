//
//  Album.h
//  BlueLibrary
//
//  Created by Inna Labuns'ka on 20.05.15.
//  Copyright (c) 2015 Eli Ganem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Album : NSObject

@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *artist;
@property (nonatomic, readonly, copy) NSString *genre;
@property (nonatomic, readonly, copy) NSString *coverURL;
@property (nonatomic, readonly, copy) NSString *year;

- (instancetype) initWithTitle:(NSString *)title
                         artist:(NSString *)artist
                      coverUrl:(NSString *)coverURL
                          year:(NSString *)year;

@end
