//
//  User+CoreDataProperties.h
//  Appertized-iOS-Test
//
//  Created by Peter Hall on 14/09/2016.
//  Copyright © 2016 Peter Hall. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"
#import "Address.h"
#import "Picture.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *gender;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSDate *dob;
@property (nullable, nonatomic, retain) NSString *phone;
@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) Address *address;
@property (nullable, nonatomic, retain) Picture *picUser;

@end

NS_ASSUME_NONNULL_END
