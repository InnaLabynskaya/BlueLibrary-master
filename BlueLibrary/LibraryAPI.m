//
//  LibraryAPI.m
//  BlueLibrary
//
//  Created by Inna Labuns'ka on 20.05.15.
//  Copyright (c) 2015 Eli Ganem. All rights reserved.
//

#import "LibraryAPI.h"
#import "PersistencyManager.h"
#import "HTTPClient.h"

@interface LibraryAPI()

@property(nonatomic, strong) PersistencyManager *persistencyManager;
@property(nonatomic, strong) HTTPClient *httpclient;
@property(nonatomic) BOOL isOnline;

@end
@implementation LibraryAPI

+ (LibraryAPI *)sharedInstance
{
    static LibraryAPI *_sharedInstance = nil;
    static dispatch_once_t oncePradicate;
    
    dispatch_once(&oncePradicate, ^{
        _sharedInstance = [[LibraryAPI alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.persistencyManager = [[PersistencyManager alloc]init];
        self.httpclient = [[HTTPClient alloc]init];
        self.isOnline = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(downloadImage:)
                                                     name:@"BLDownloadImageNotification"
                                                   object:nil];

    }
    return self;
}

- (NSMutableArray *)albums
{
    return [self.persistencyManager albums];
}

- (void)addAlbum:(Album *)album atIndex:(NSUInteger)index
{
    [self.persistencyManager addAlbum:album atIndex:index];
    if (self.isOnline) {
        [self.httpclient postRequest:@"/api/addAlbum" body:[album description]];
    }
}

- (void)deleteAlbumAtIndex:(NSUInteger)index
{
    [self.persistencyManager deleteAlbumAtIndex:index];
    if (self.isOnline) {
        [self.httpclient postRequest:@"/api/deleteAlbum" body:[@(index) description]];
    }
}

- (void)downloadImage:(NSNotification *)notification
{
    NSString *coverURL = notification.userInfo[@"coverUrl"];
    UIImageView *imageView = notification.userInfo[@"imageView"];
    
    imageView.image = [self.persistencyManager getImage:[coverURL lastPathComponent]];
    if (imageView.image == nil) {
       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
           UIImage *image = [self.httpclient downloadImage:coverURL];
           dispatch_sync(dispatch_get_main_queue(), ^{
               imageView.image = image;
               [self.persistencyManager saveImage:image filename:[coverURL lastPathComponent]];
           });
       });
    }
}

@end
