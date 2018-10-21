//
//  AuthorTableViewCell.h
//  sampleMvc
//
//  Created by rakesh on 21/10/18.
//  Copyright © 2018 rakesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthorTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *authorNameLb;
@property (weak, nonatomic) IBOutlet UILabel *bookNameLb;

@end
