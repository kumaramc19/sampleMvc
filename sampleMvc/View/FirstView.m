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
    cell.EditBt.tag = indexPath.row;
    [cell.EditBt addTarget:self action:@selector(UpdateRecord:) forControlEvents: UIControlEventTouchUpInside];
    cell.DeleteBt.tag = indexPath.row;
    [cell.DeleteBt addTarget:self action:@selector(DeleteRecord:) forControlEvents: UIControlEventTouchUpInside];

    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
}

-(void)UpdateRecord:(UIButton *)sender{
    NSLog(@"sender:%ld",(long)sender.tag);

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"AuthorTable" inManagedObjectContext:context]];
    
//    //Show All Values
//    NSError *error = nil;
//    NSArray *results = [context executeFetchRequest:request error:&error];
//    NSLog(@"Simple fetchRequest:%@",[results valueForKey:@"authorname"]);
    
    
//    The array results contains all the managed objects contained within the sqlite file. If you want to grab a specific object (or more objects) you need to use a predicate with that request
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"authorname == %@", @"prakash"];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];

    NSLog(@"predicate Value:%@",[results valueForKey:@"bookname"]);
    
    // maybe some check before, to be sure results is not empty
    for(int i=0;i<results.count;i++){
    NSManagedObject* favoritsGrabbed = [results objectAtIndex:i];
    [favoritsGrabbed setValue:@"kumarBook" forKey:@"bookname"];
    [appdelegate saveContext];
    }
    
    [_AuthortableView reloadData];

}

-(void)DeleteRecord:(UIButton *)sender{
    NSLog(@"sender:%ld",(long)sender.tag);
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"AuthorTable" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"authorname == %@",@"prakash"];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    
    NSError *error;
    NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *managedObject in items)
    {
        [context deleteObject:managedObject];
        
    }
 [appdelegate saveContext];
    //Fetch data from Coredata
    NSFetchRequest *requestObj = [NSFetchRequest fetchRequestWithEntityName:@"AuthorTable"];
    result = [context executeFetchRequest:requestObj error:nil];

    [_AuthortableView reloadData];
}
/*NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
 NSEntityDescription *entity = [NSEntityDescription entityForName:@"entityname" inManagedObjectContext:context];
 NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID like %@",userID];
 [fetchRequest setPredicate:predicate];
 [fetchRequest setFetchLimit:1];
 [fetchRequest setEntity:entity];
 NSError *error;
 NSArray *arrResult = [context executeFetchRequest:fetchRequest error:&error];
 YourEntityname *entity = arrResult[0];
 entity.userID = @"2"
 [appdelegate saveContext];*/


@end
