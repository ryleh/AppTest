//
//  Picture+CoreDataProperties.h
//  Appertized-iOS-Test
//
//  Created by Peter Hall on 13/09/2016.
//  Copyright © 2016 Peter Hall. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Picture.h"

NS_ASSUME_NONNULL_BEGIN

@interface Picture (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *small;
@property (nullable, nonatomic, retain) NSString *medium;
@property (nullable, nonatomic, retain) NSString *large;
@property (nullable, nonatomic, retain) NSSet<User *> *userPic;

@end

@interface Picture (CoreDataGeneratedAccessors)

- (void)addUserPicObject:(User *)value;
- (void)removeUserPicObject:(User *)value;
- (void)addUserPic:(NSSet<User *> *)values;
- (void)removeUserPic:(NSSet<User *> *)values;

@end

NS_ASSUME_NONNULL_END
