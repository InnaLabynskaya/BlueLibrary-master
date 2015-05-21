//
//  ViewController.m
//  BlueLibrary
//
//  Created by Eli Ganem on 31/7/13.
//  Copyright (c) 2013 Eli Ganem. All rights reserved.
//

#import "ViewController.h"
#import "HorizontalScroller.h"
#import "AlbumView.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, HorizontalScrollDelegate>

@property (nonatomic,strong) UITableView *dataTable;
@property (nonatomic, strong) NSArray *allAlbums;
@property (nonatomic, strong) NSDictionary *currentAlbumData;
@property (nonatomic) NSUInteger currentAlbumIndex;
@property (nonatomic,strong) HorizontalScroller *scroller;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithRed:0.76f green:0.81f blue:0.87f alpha:1.f];
    self.currentAlbumIndex = 0;
    
    self.allAlbums = [[LibraryAPI sharedInstance]albums];
    CGRect frame = CGRectMake(0.f, 120.f, self.view.frame.size.width, self.view.frame.size.height - 120.f);
    self.dataTable = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    self.dataTable.delegate = self;
    self.dataTable.dataSource = self;
    self.dataTable.backgroundView = nil;
    [self.view addSubview:self.dataTable];
    
    self.scroller = [[HorizontalScroller alloc] initWithFrame:CGRectMake(0.f, 20.f, self.view.frame.size.width, 120.f)];
    self.scroller.backgroundColor = [UIColor colorWithRed:0.24f green:0.35f blue:0.49f alpha:1];
    self.scroller.delegate = self;
    [self.view addSubview:self.scroller];
    
    [self reloadScroller];
    [self showDataAlbumAtIndex:self.currentAlbumIndex];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showDataAlbumAtIndex:(NSUInteger)index
{
    if(index < self.allAlbums.count) {
        Album *album = self.allAlbums[index];
        self.currentAlbumData = [album tr_tableRepresentation];
    } else {
        self.currentAlbumData = nil;
    }
    [self.dataTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.currentAlbumData[@"titles"] count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.currentAlbumData[@"titles"][indexPath.row];
    cell.detailTextLabel.text = self.currentAlbumData[@"values"][indexPath.row];
    return cell;
}

- (void)horizontalScroller:(HorizontalScroller *)scroller clickedViewAtIndex:(int)index
{
    self.currentAlbumIndex = index;
    [self showDataAlbumAtIndex:index];
}

- (NSInteger)numberOfViewsForHorizontalScroller:(HorizontalScroller *)scroller
{
    return self.allAlbums.count;
}

- (UIView *)horizontalScroller:(HorizontalScroller *)scroller viewAtIndex:(int)index
{
    Album *album = self.allAlbums[index];
    return [[AlbumView alloc]initWithFrame:CGRectMake(0.f, 0.f, 100.f, 100.f) albumCover:album.coverURL];
}

- (void)reloadScroller
{
    self.allAlbums = [[LibraryAPI sharedInstance]albums];
    if (self.currentAlbumIndex < 0) {
        self.currentAlbumIndex = 0;
    } else if (self.currentAlbumIndex >= self.allAlbums.count) {
        self.currentAlbumIndex = self.allAlbums.count - 1;
        [self.scroller reload];
        [self showDataAlbumAtIndex:self.currentAlbumIndex];
    }
}
@end
