//
//  FirstView.m
//  sampleMvc
//
//  Created by rakesh on 21/10/18.
//  Copyright © 2018 rakesh. All rights reserved.
//

#import "FirstView.h"
#import "AppDelegate.h"
#import "AuthorTableViewCell.h"

@implementation FirstView{
    AppDelegate *appdelegate;
    NSManagedObjectContext *context;
    NSArray *result;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setController:(FirstViewController *)firstViewController{
    _firstViewController = firstViewController;
    //TextField
    _authorName_Tf.delegate = self;
    _bookName_Tf.delegate = self;
    //TableView
    _AuthortableView.delegate = self;
    _AuthortableView.dataSource = self;
    
    //Get context
    appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    context = appdelegate.persistentContainer.viewContext;

    //Fetch data from Coredata
    NSFetchRequest *requestObj = [NSFetchRequest fetchRequestWithEntityName:@"AuthorTable"];
    result = [context executeFetchRequest:requestObj error:nil];
    
    //Display value
    NSLog(@"AuthorName:%@",[result valueForKey:@"authorname"]);


}
- (IBAction)RedirectSecondView:(id)sender {
    
    [_firstViewController redirectSecond];
}

- (IBAction)saveRecord:(id)sender {
    //Get context
    appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    context = appdelegate.persistentContainer.viewContext;
    
    //Save Data
    NSManagedObject *entityobj = [NSEntityDescription insertNewObjectForEntityForName:@"AuthorTable" inManagedObjectContext:context];
    [entityobj setValue:_authorName_Tf.text forKey:@"authorname"];
    [entityobj setValue:_bookName_Tf.text forKey:@"bookname"];
    [appdelegate saveContext];
    
//    //Fetch data from Coredata
//    NSFetchRequest *requestObj = [NSFetchRequest fetchRequestWithEntityName:@"AuthorTable"];
//    result = [context executeFetchRequest:requestObj error:nil];
//    
//    //Display value
//    NSLog(@"AuthorName:%@",[result valueForKey:@"authorname"]);

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Result count:%lu",(unsigned long)[result count]);
    return [result count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"AuthorTableViewCell_ID";
    
    AuthorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[AuthorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }

    
    [cell.authorNameLb setText:[[result valueForKey:@"authorname"] objectAtIndex:indexPath.row]];
    [cell.bookNameLb setText:[[result valueForKey:@"bookname"] objectAtIndex:indexPath.row]];
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
}

@end
