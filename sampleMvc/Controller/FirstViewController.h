//
//  FirstViewController.h
//  sampleMvc
//
//  Created by rakesh on 21/10/18.
//  Copyright © 2018 rakesh. All rights reserved.
//

#import "BaseViewController.h"
#import "FirstView.h"
@class FirstView;

@interface FirstViewController : BaseViewController
@property (strong, nonatomic) IBOutlet FirstView *firstView;
-(void)redirectSecond;
@end
