//
//  User.m
//  Appertized-iOS-Test
//
//  Created by Peter Hall on 13/09/2016.
//  Copyright © 2016 Peter Hall. All rights reserved.
//

#import "User.h"

@implementation User

// Insert code here to add functionality to your managed object subclass

-(NSNumber*)calculateAge
{
    NSDateComponents *currYear = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    NSDateComponents *dobYear = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self.dob];
    
    NSInteger year = [currYear year];
    NSInteger birthYear = [dobYear year];
    
    NSNumber *age = [NSNumber numberWithInteger:year - birthYear];
    
    return age;
}

-(NSString *)createFullName
{
    NSString *name = [[NSString alloc] initWithFormat:@"%@ %@ %@", self.title, self.firstName,self.lastName ];
    return name;
}

@end
