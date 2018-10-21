//
//  secondView.h
//  sampleMvc
//
//  Created by rakesh on 21/10/18.
//  Copyright © 2018 rakesh. All rights reserved.
//

#import "BaseView.h"
#import "SecondViewController.h"

@class SecondViewController;
@interface secondView : BaseView
@property (nonatomic,strong,setter=setController:) SecondViewController *secondViewController;

@end
