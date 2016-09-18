//
//  UserInfoCell.h
//  Appertized-iOS-Test
//
//  Created by Peter Hall on 14/09/2016.
//  Copyright © 2016 Peter Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface UserInfoCell : UITableViewCell


@property(nonatomic, weak)IBOutlet UILabel*name;
@property(nonatomic, weak)IBOutlet UILabel*gender;
@property(nonatomic, weak)IBOutlet AsyncImageView*profileImage;

@end
