//
//  JsonDataSource.m
//  Appertized-iOS-Test
//
//  Created by Peter Hall on 13/09/2016.
//  Copyright © 2016 Peter Hall. All rights reserved.
//

#import "JsonDataSource.h"

@implementation JsonDataSource

-(NSArray *)fetchDataEntries:(int)number
{
    
    NSError *error;
    NSString *url_string = [NSString stringWithFormat: @"http://api.randomuser.me/?results=%d", number];
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
    return [json objectForKey:@"results"];
}


@end

