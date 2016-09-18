//
//  UserDetailViewController.h
//  Appertized-iOS-Test
//
//  Created by Peter Hall on 17/09/2016.
//  Copyright © 2016 Peter Hall. All rights reserved.
//

#import "ViewController.h"
#import "User.h"
#import <MessageUI/MessageUI.h>



@interface UserDetailViewController : UIViewController<MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *gender;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *street;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *state;
@property (weak, nonatomic) IBOutlet UILabel *postcode;
@property (weak, nonatomic) IBOutlet UILabel *dateOfBirth;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObject *user;

-(IBAction)sendEmail:(id)sender;
-(IBAction)callNumber:(id)sender;
-(IBAction)deleteUser:(id)sender;

@end
