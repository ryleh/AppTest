//
//  DataManager.m
//  Appertized-iOS-Test
//
//  Created by Peter Hall on 13/09/2016.
//  Copyright © 2016 Peter Hall. All rights reserved.
//

#import "DataManager.h"
#import "DataSource.h"
#import "JsonDataSource.h"
#import "AppDelegate.h"
#import "User.h"
#import "Address.h"
#import "Picture.h"

@interface DataManager()
{
    id<DataSource> _dataSource;
    NSManagedObjectContext* _context;
}
@end

@implementation DataManager

// Should use the init with datasource and context
-(instancetype)init
{
    
    return nil;
}

// initialise with a data source injected
-(instancetype)initWithDataSource:(id<DataSource>)dataSource andContext:(NSManagedObjectContext*)context
{
    if (self = [super init]) {
        _dataSource = dataSource;
        _context = context;
    }
    
    return self;
}

// init with just a context
-(instancetype)initWithContext:(NSManagedObjectContext*)context
{
    if (self = [super init]) {
        _context = context;
    }
    
    return self;
}

// checks the context to see if user records already exist and if not it fetches some from the data source
-(void)checkData
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:_context];
    [request setEntity:entity];
    
    NSError *error;
    NSArray *users = [_context executeFetchRequest:request error:&error];
    
    if([users count] == 0)
    {
        // we need to add some users from the data source
        [self saveData:[self getRandomUsers:100]];
    }
    else
    {
        NSLog(@"we already have %lu users :)", (unsigned long)[users count]);
    }

}

// get some random users from the data source
-(NSArray*)getRandomUsers:(int)amount
{
    return [_dataSource fetchDataEntries:amount];
}

// enumerates through the fethced data and saves to a persistant store
-(void)saveData:(NSArray*)data
{
    if (data != nil)
    {
        [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            User *userInfo = [NSEntityDescription
                              insertNewObjectForEntityForName:@"User"
                              inManagedObjectContext:_context];
            NSDictionary *name = [obj objectForKey:@"name"];
            userInfo.title = [name objectForKey:@"title"];
            userInfo.firstName = [name objectForKey:@"first"];
            userInfo.lastName = [name objectForKey:@"last"];
            userInfo.name = [userInfo getName];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            userInfo.dob = [formatter dateFromString:[obj objectForKey:@"dob"]];
            userInfo.email = [obj objectForKey:@"email"];
            userInfo.phone = [obj objectForKey:@"phone"];
            userInfo.gender = [obj objectForKey:@"gender"];
            
            Address *addressInfo = [NSEntityDescription
                                    insertNewObjectForEntityForName:@"Address"
                                    inManagedObjectContext:_context];
                         NSDictionary *address = [obj objectForKey:@"location"];
                        addressInfo.street = [address objectForKey:@"street"];
                        addressInfo.state = [address objectForKey:@"state"];
                        addressInfo.postcode =[[NSString alloc] initWithFormat:@"%@", [address objectForKey:@"postcode"]];
                        addressInfo.city = [address objectForKey:@"city"];
            userInfo.address = addressInfo;
            
            Picture *picInfo = [NSEntityDescription
                                insertNewObjectForEntityForName:@"Picture"
                                inManagedObjectContext:_context];
            NSDictionary *pic = [obj objectForKey:@"picture"];
            picInfo.small = [pic objectForKey:@"thumbnail"];
            picInfo.medium = [pic objectForKey:@"medium"];
            picInfo.large = [pic objectForKey:@"large"];
            userInfo.picUser = picInfo;
            userInfo.age = [userInfo getAge];
            
            NSError *error;
            if (![_context save:&error]) {
                NSLog(@"couldn't save: %@", [error localizedDescription]);
            }
        }];
    }
    
}

-(void)deleteUser:(NSManagedObject*)user
{
    [_context deleteObject:user];
    NSError *error;
    if (![_context save:&error]) {
        NSLog(@"couldn't save: %@", [error localizedDescription]);
    }
}


@end
