//
//  DataManager.h
//  Appertized-iOS-Test
//
//  Created by Peter Hall on 13/09/2016.
//  Copyright © 2016 Peter Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataSource.h"
#import "AppDelegate.h"

@interface DataManager : NSObject


-(instancetype)initWithDataSource:(id<DataSource>)dataSource andContext:(NSManagedObjectContext*)context;

-(void)checkData;
-(NSArray*)getRandomUsers:(int)amount;
-(void)saveData:(NSArray*)data;

@end
