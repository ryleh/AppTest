//
//  UserDetailViewController.m
//  Appertized-iOS-Test
//
//  Created by Peter Hall on 17/09/2016.
//  Copyright © 2016 Peter Hall. All rights reserved.
//

#import "UserDetailViewController.h"
#import <MessageUI/MessageUI.h>
#import "DataManager.h"

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

-(IBAction)sendEmail:(id)sender
{
    if ([MFMailComposeViewController canSendMail])
    {
        
        MFMailComposeViewController *mvController = [[MFMailComposeViewController alloc] init];
        mvController.mailComposeDelegate = self;
        
        [mvController setToRecipients:@[[self.user valueForKey:@"email"]]];
        
        [self presentViewController:mvController animated:YES completion:nil];
        
    }
    else
    {
        [self showAlertWithTitle:@"No Email" andMessage:@"You are unable to send email on this device"];
    }

}

-(IBAction)callNumber:(id)sender
{
    NSString *phNo = [self.user valueForKey:@"phone"];
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        [self showAlertWithTitle:@"Can't Call" andMessage:@"You can't make a phone call on this device"];
    }
}

-(void)showAlertWithTitle:(NSString*)title andMessage:(NSString*)message
{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:title
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"Ok"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   [alert dismissViewControllerAnimated:YES completion:nil];
                               }];
    
    
    [alert addAction:okButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(IBAction)deleteUser:(id)sender
{
 
    // display an alert
    UIAlertController *alert = [UIAlertController
                                 alertControllerWithTitle:@"Delete User"
                                 message:@"Are you sure you want to delete the user?"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelBtn = [UIAlertAction
                                actionWithTitle:@"Cancel"
                                style:UIAlertActionStyleCancel
                                handler:^(UIAlertAction * action) {
                                    [alert dismissViewControllerAnimated:YES completion:nil];
                                }];
    
    UIAlertAction *deleteBtn = [UIAlertAction
                               actionWithTitle:@"Delete"
                               style:UIAlertActionStyleDestructive
                               handler:^(UIAlertAction * action) {
                                   DataManager *dManager = [[DataManager alloc]initWithContext:self.managedObjectContext];
                                   [dManager deleteUser:self.user];
                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                   [self.navigationController popViewControllerAnimated:YES];
                               }];
    
    
    [alert addAction:cancelBtn];
    [alert addAction:deleteBtn];
    
    [self presentViewController:alert animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Mail Controller delegate methods
/*
 This informs what happened when with the email request and dismisses the view
 */
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"You sent the email.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"You saved a draft of this email");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"You cancelled sending this email.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
