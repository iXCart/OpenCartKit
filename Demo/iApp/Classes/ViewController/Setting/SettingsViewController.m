//
//  SettingsViewController.m
//  iApp
//
//  Created by icoco7 on 6/10/14.
//  Copyright (c) 2014 i2Cart.com. All rights reserved.
//

#import "SettingsViewController.h"
#import "LoginViewController.h"
#import "DataModel.h"

@interface SettingsViewController ()

@end

static NSString* ruseCellId = @"BaseCell";
@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)prepareTableview
{
    
    [self.tableView registerClass: [UITableViewCell class]
         forCellReuseIdentifier:ruseCellId];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = AppLocalizedString(@"Settings");
    [self prepareTableview];
}

- (BOOL)checkValidateUser
{
    OCCustomer* user = [[DataModel sharedInstance] getActiveUser];
    if (nil == user || ![user isValidateUser]) {
        LoginViewController* viewController = (LoginViewController*)[CUIEnginer createViewController:@"LoginViewController" inNavigationController:true];
        
        [self presentViewController:viewController animated:true completion:^{
            self.view.hidden = false;
            
        }];
        return false;
        
    }
    //@ste has login
    return true;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //@step
    [self loadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray*) loadDefs
{
    NSString* cfgFilePath =[Utils getBundleFileAsFullPath:  @"settingDefs.plist"];
    NSArray* data = [NSArray arrayWithContentsOfFile:cfgFilePath];
	if (nil == data || [data count]<=0) {
		NSLog(@"Miss read data from->[%@]", cfgFilePath);
		return nil;
	}
    NSLog(@"%@->loadDefs:[%@]",self, data);
    return data;
}

- (void)loadData
{
    _defs = [self loadDefs];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_defs count];;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* reuseId =ruseCellId;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId forIndexPath:indexPath];
    
        //
    NSArray* items = _defs;
    NSInteger row = indexPath.row;
    NSDictionary* item = [items objectAtIndex:row];
    cell.textLabel.text = [item valueForKey:@"name"];
    
    return cell;
}

- (void)processCommand:(NSDictionary*)dict
{
    NSString* class = (NSString*) [dict valueForKey:@"class"];
    do{
        if ([Lang isEmptyString:class]) {
            break;
        }
        
        if (StringEqual(class, @"Logout")) {
            
            [self confirmLogout:nil];
            break;
        }
        //@step
        NSString* needLogin = (NSString*) [dict valueForKey:@"loginUser"];
        if ([Lang toBool:needLogin] ) {
            if ( ![self checkValidateUser])
            {
                break;
            }
        }
        UIViewController* viewController = [CUIEnginer createViewController:class inNavigationController:false];
        [self.navigationController pushViewController:viewController animated:true];
        

    }while (false);
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray* items = _defs;
    NSInteger row = indexPath.row;
    NSDictionary* item = [items objectAtIndex:row];
    [self processCommand:item];
  
    
}

#pragma mark Logout
- (void)confirmLogout:(id)sender
{
    NSString* message = AppLocalizedString(@"Logout now?");
    NSString* cancel = AppLocalizedString(@"Cancel");
    NSString* ok = AppLocalizedString(@"OK");
    
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:message delegate:self cancelButtonTitle: cancel otherButtonTitles: ok, nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (buttonIndex == alertView.cancelButtonIndex) {
        return;
    }
     [[DataModel sharedInstance]loutOut];
}
@end
