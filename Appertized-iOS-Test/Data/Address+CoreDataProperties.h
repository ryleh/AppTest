//
//  Address+CoreDataProperties.h
//  Appertized-iOS-Test
//
//  Created by Peter Hall on 13/09/2016.
//  Copyright © 2016 Peter Hall. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Address.h"

NS_ASSUME_NONNULL_BEGIN

@interface Address (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *street;
@property (nullable, nonatomic, retain) NSString *city;
@property (nullable, nonatomic, retain) NSString *state;
@property (nullable, nonatomic, retain) NSString *postcode;
@property (nullable, nonatomic, retain) NSSet<User *> *user;

@end

@interface Address (CoreDataGeneratedAccessors)

- (void)addUserObject:(User *)value;
- (void)removeUserObject:(User *)value;
- (void)addUser:(NSSet<User *> *)values;
- (void)removeUser:(NSSet<User *> *)values;

@end

NS_ASSUME_NONNULL_END
