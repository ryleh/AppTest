//
//  User.h
//  Appertized-iOS-Test
//
//  Created by Peter Hall on 13/09/2016.
//  Copyright © 2016 Peter Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

-(NSNumber*)calculateAge;
-(NSString*)createFullName;

@end

NS_ASSUME_NONNULL_END

#import "User+CoreDataProperties.h"
