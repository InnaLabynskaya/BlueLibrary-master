//
//  AlbumView.m
//  BlueLibrary
//
//  Created by Inna Labuns'ka on 20.05.15.
//  Copyright (c) 2015 Eli Ganem. All rights reserved.
//

#import "AlbumView.h"

@interface AlbumView ()

@property (nonatomic, strong) UIImageView *coverImage;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@end

@implementation AlbumView


- (instancetype) initWithFrame:(CGRect)frame albumCover:(NSString *)albumCover
{
   self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.coverImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, frame.size.width - 10, frame.size.height - 10)];
        [self addSubview:self.coverImage];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BLDownloadImageNotification"
                                                            object:self
                                                          userInfo:@{@"coverUrl":albumCover,
                                                                     @"imageView":self.coverImage}];
        
        self.indicator = [[UIActivityIndicatorView alloc] init];
        self.indicator.center = self.center;
        self.indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [self.indicator startAnimating];
        [self addSubview:self.indicator];
        [self.coverImage addObserver:self forKeyPath:@"image" options:0 context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"image"])
    {
        [self.indicator stopAnimating];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
