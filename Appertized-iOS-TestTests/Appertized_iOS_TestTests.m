//
//  Appertized_iOS_TestTests.m
//  Appertized-iOS-TestTests
//
//  Created by Peter Hall on 13/09/2016.
//  Copyright © 2016 Peter Hall. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DataManager.h"
#import "JsonDataSource.h"
#import "User.h"

@interface Appertized_iOS_TestTests : XCTestCase

@property (nonatomic,retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,retain) DataManager *dManager;

@end

@implementation Appertized_iOS_TestTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Appertized_iOS_Test" withExtension:@"momd"];
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    XCTAssertTrue([psc addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:NULL] ? YES : NO, @"Should be able to add in-memory store");
    self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.managedObjectContext.persistentStoreCoordinator = psc;
    
    // datamanager setup
    JsonDataSource *testSource = [[JsonDataSource alloc] init];
    self.dManager = [[DataManager alloc] initWithDataSource:testSource andContext:self.managedObjectContext];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testDeaultDataManagerInitReturnsNil
{
    // arrange
    DataManager *testManager = [[DataManager alloc] init];
    
    // act
    
    // assert
    XCTAssert(testManager == nil, @"Data manager should be nil if initialising without a context");
}

-(void)testGetRandomUsersReturnsArrayWithCount1
{
    // arrange
    
    // act
    NSArray *users = [self.dManager getRandomUsers:1];
    
    // assert
    XCTAssertEqual([users count], 1, "count for users array should equal 1");
    
}

-(void)testGetRandomUsersHandlesTooLargeRequest
{
    // arrange
    
    // act
    NSArray *users = [self.dManager getRandomUsers:10000];
    
    // assert
    XCTAssertEqual([users count], 1, "users should return 1 if request is too big");
    
}

-(void)testUserDataContainsName
{
    // arrange
    __block NSString *title = nil;
    __block NSString *first = nil;
    __block NSString *last = nil;
    __block NSDictionary *name = nil;
    
    // act
    NSArray *users = [self.dManager getRandomUsers:1];
    [users enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    name = [obj objectForKey:@"name"];
    title = [name objectForKey:@"title"];
    first = [name objectForKey:@"first"];
    last = [name objectForKey:@"last"];
        
    }];
    
    // assert
    XCTAssertNotNil(name, @"returned array should contain a dictionary containing name data");
    XCTAssertNotNil(title, @"Title should not be nil");
    XCTAssertNotNil(first, @"first name should not be nil");
    XCTAssertNotNil(last, @"last name should not be nil");
}

-(void)testGetRandomUsersWithZeroReturnsNil
{
    // arrange
    
    // act
    NSArray *users = [self.dManager getRandomUsers:0];
    
    // assert
    XCTAssertNil(users, "users should be nil");

}
-(void)testNameCalculatedCorrectlyForUser
{
    // arrange
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    NSString *expectedName = @"mr peter hall";
    
    // act
    user.title = @"mr";
    user.firstName = @"peter";
    user.lastName = @"hall";
    NSString *actualName = [user getName];
    
    // assert
    XCTAssertEqualObjects(actualName, expectedName, @"names should match");
}

-(void)testAgeCalculatedCorrectlyForUser
{
    // arrange
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    NSNumber *expectedAge = [NSNumber numberWithLong:16];
    
    // act
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:01];
    [comps setMonth:01];
    [comps setYear:2000];
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:comps];
    user.dob = date;
    NSNumber *actualAge = [user getAge];
    
    // assert
    XCTAssertEqual(actualAge, expectedAge, @"age should be 16");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
