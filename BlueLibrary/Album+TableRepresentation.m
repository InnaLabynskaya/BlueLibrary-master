//
//  Album+TableRepresentation.m
//  BlueLibrary
//
//  Created by Inna Labuns'ka on 20.05.15.
//  Copyright (c) 2015 Eli Ganem. All rights reserved.
//

#import "Album+TableRepresentation.h"

@implementation Album (TableRepresentation)

- (NSDictionary *)tr_tableRepresentation
{
    return @{@"titles":@[@"Исполнитель",@"Альбом",@"Жанр",@"Год"],
             @"values":@[self.artist,self.title,self.genre,self.year]};
}

@end
