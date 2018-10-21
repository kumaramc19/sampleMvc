//
//  FirstView.h
//  sampleMvc
//
//  Created by rakesh on 21/10/18.
//  Copyright © 2018 rakesh. All rights reserved.
//

#import "BaseView.h"
#import "FirstViewController.h"
@class FirstViewController;

@interface FirstView : BaseView<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong,setter=setController:) FirstViewController *firstViewController;
- (IBAction)RedirectSecondView:(id)sender;
- (IBAction)saveRecord:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *authorName_Tf;
@property (weak, nonatomic) IBOutlet UITextField *bookName_Tf;

@property (weak, nonatomic) IBOutlet UITableView *AuthortableView;

@end
