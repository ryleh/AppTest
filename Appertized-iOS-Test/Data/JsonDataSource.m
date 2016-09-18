//
//  JsonDataSource.m
//  Appertized-iOS-Test
//
//  Created by Peter Hall on 13/09/2016.
//  Copyright © 2016 Peter Hall. All rights reserved.
//

#import "JsonDataSource.h"

@implementation JsonDataSource

/*
 Get an array of data from the randomuser api and return it
 */
-(NSArray *)fetchDataEntries:(int)number
{
    if (number > 0)
    {
        NSError *error;
        NSString *url_string = [NSString stringWithFormat: @"http://api.randomuser.me/?results=%d", number];
        NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
        
        if (data != nil)
        {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            if (!error)
            {
                return [json objectForKey:@"results"];
            }
        }
        
        
    }
    
    return nil;
    
}


@end

