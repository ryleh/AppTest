//
//  DataSource.h
//  Appertized-iOS-Test
//
//  Created by Peter Hall on 13/09/2016.
//  Copyright © 2016 Peter Hall. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataSource <NSObject>

-(NSArray*)fetchDataEntries:(int)number;

@end
