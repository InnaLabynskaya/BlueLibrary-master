//
//  Album+TableRepresentation.h
//  BlueLibrary
//
//  Created by Inna Labuns'ka on 20.05.15.
//  Copyright (c) 2015 Eli Ganem. All rights reserved.
//

#import "Album.h"

@interface Album (TableRepresentation)

- (NSDictionary *)tr_tableRepresentation;

@end
