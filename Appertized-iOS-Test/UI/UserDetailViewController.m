//
//  UserDetailViewController.m
//  Appertized-iOS-Test
//
//  Created by Peter Hall on 17/09/2016.
//  Copyright © 2016 Peter Hall. All rights reserved.
//

#import "UserDetailViewController.h"

@interface UserDetailViewController ()

@end

@implementation UserDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"user name %@", [self.user valueForKey:@"name"]);
    [self showUserDetails];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showUserDetails
{
    
    Picture *pic = [self.user valueForKey:@"picUser"];
    NSURL *url = [NSURL URLWithString:pic.large];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    [self.profileImage setImage:img];
    self.name.text = [self.name.text stringByAppendingString:[self.user valueForKey:@"name"]];
    self.gender.text = [self.gender.text stringByAppendingString:[self.user valueForKey:@"gender"]];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    NSDate *dob = [self.user valueForKey:@"dob"];
    NSString *dobString = [dateFormat stringFromDate:dob];
    self.dateOfBirth.text = [self.dateOfBirth.text stringByAppendingString:dobString];
    self.email.text = [self.email.text stringByAppendingString:[self.user valueForKey:@"email"]];
    self.phone.text = [self.phone.text stringByAppendingString:[self.user valueForKey:@"phone"]];
    Address *address = [self.user valueForKey:@"address"];
    self.street.text = address.street;
    self.city.text = address.city;
    self.state.text = address.state;
    self.postcode.text = address.postcode;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
