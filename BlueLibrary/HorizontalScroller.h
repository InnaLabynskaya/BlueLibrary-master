//
//  HorizontalScroller.h
//  BlueLibrary
//
//  Created by Inna Labuns'ka on 20.05.15.
//  Copyright (c) 2015 Eli Ganem. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HorizontalScrollDelegate;

@interface HorizontalScroller : UIView

@property (weak,nonatomic)id<HorizontalScrollDelegate> delegate;
- (void)reload;

@end

@protocol HorizontalScrollDelegate <NSObject>

@required

- (NSInteger)numberOfViewsForHorizontalScroller:(HorizontalScroller *)scroller;
- (UIView *)horizontalScroller:(HorizontalScroller *)scroller viewAtIndex:(int)index;
- (void)horizontalScroller:(HorizontalScroller *)scroller clickedViewAtIndex:(int)index;

@optional
- (NSInteger)initialViewIndexForHorizontalScroller:(HorizontalScroller *)scroller;

@end