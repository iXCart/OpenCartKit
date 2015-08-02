//
//  ShippingAddressViewController.m
//  iApp
//
//  Created by icoco7 on 7/8/14.
//  Copyright (c) 2014 i2Cart.com. All rights reserved.
//

#import "ShippingAddressViewController.h"
#import "ShippingMethodViewController.h"
 
#import "AddressCell.h"
#import "AddressViewController.H"


@interface ShippingAddressViewController ()
{
    NSIndexPath* _selectedIndexPath;
}

@end

@implementation ShippingAddressViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

static NSString* cellId = @"AddressCell";

-(void)prepareTableview
{
    UINib *nib = [UINib nibWithNibName:cellId  bundle:nil];
    [self.tableView registerNib:nib
         forCellReuseIdentifier:cellId];
    
    //@step
    if (nil == self.bottomView){
        UIView* addNewAddressBar =[[NSBundle mainBundle]loadNibNamed:@"AddNewAddressBar" owner:self options:0][0];
        self.bottomView = addNewAddressBar;
    }
    
    self.tableView.tableFooterView = self.bottomView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = AppLocalizedString(@"Delivery Address");
    
    [self prepareTableview];
    
    
}
- (void)renderToolBar:(BOOL)visiable
{
    if (visiable) {
        UIBarButtonItem* button = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(nextStep:)];
        [self.navigationItem setRightBarButtonItem:button];
    }else
        [self.navigationItem setRightBarButtonItem:nil];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self loadData];
    
    [self renderToolBar:true];
}

- (void)showNextScene
{
    
    AppViewController * viewController = [ShippingMethodViewController create];
    // viewController.args = item;
    
    [self.navigationController pushViewController:viewController animated:true];
    
}


- (void)nextStep:(id)sender{
    
    //@step
    NSDictionary* rowData = [self getSelecteRowData];
    if (nil == rowData) {
        return;
    }
    __weak __typeof(self)weakSelf = self;
    
    NSString* address_id = [rowData valueForKey:CheckoutPaymentAddress_address_id];
    OCCheckoutService *serivce = [OCCheckoutService setShippingAddress:address_id];
    [serivce execute:^(id response) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        NSDictionary* dict = (NSDictionary*)response;
        NSString* status = [dict stringValueForPath:@"status"];
        BOOL success = [@"success" isEqualToString:status];
        
        if ( success)
        {
            [strongSelf showNextScene];
        }else
        {
            [Resource showRestResponseErrorMessage:response];
        }
        
    } failure:^(NSError *error) {
        [CDialogViewManager showMessageView:@"" message:[error localizedDescription] delayAutoHide:-1];
    }];
    
    
}

- (IBAction)addNewAddress:(id)sender
{
    
    
    AddressViewController* addressView = (AddressViewController*) [AddressViewController create];
    
    CNavigationController* nav = [[CNavigationController alloc]initWithRootViewController:addressView];
    addressView.isShippingAddress = true;
    
    addressView.args = _mappingResult.dictionary;
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:nav animated:true completion:^{
        
    }];
}


- (RKMappingResult*)parseData2Result:(NSData*)data
{
    //@step
    NSDictionary* response = [Lang paseJSONDatatoArrayOrNSDictionary:data];
    RKMappingResult* result = [[RKMappingResult alloc]initWithDictionary:response];
    return  result;
}

- (void)loadData{
    __weak __typeof(self)weakSelf = self;
    OCCheckoutService *serivce = [OCCheckoutService shippingAddress];
    [serivce execute:^(id response) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        _mappingResult =  [Resource parseResponse2Result:response];
        //@step
        _list = [[[_mappingResult dictionary] objectForKey:@"addresses"] allObjects];
        //@step
        [strongSelf.tableView reloadData];
    } failure:^(NSError *error) {
        [CDialogViewManager showMessageView:@"" message:[error localizedDescription] delayAutoHide:-1];
    }];
    
    
}

#pragma mark getSelecteRowData
- (NSDictionary*)getSelecteRowData
{
    if (nil == _list) {
        return nil;
    }
    NSArray* items = _list;
    int row = _selectedIndexPath.row;
    NSDictionary* item = [items objectAtIndex:row];
    
    return item;
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 80;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_list count];;
}

-( NSString*)wrapFullName:(NSDictionary*)dict
{
    NSString* firstName = [dict valueForKey:@"firstname"];
    NSString* lastname = [dict valueForKey:@"lastname"];
    NSString* result = [NSString stringWithFormat:@"%@ %@",
                        firstName,lastname];
    return result;
}

-( NSString*)wrapAddress:(NSDictionary*)dict
{
    
    NSString* zone = [dict valueForKey:@"zone"];
    NSString* city = [dict valueForKey:@"city"];
    NSString* address_1 = [dict valueForKey:@"address_1"];
    
    NSString* country = [dict valueForKey:@"country"];
    
    NSString* result = [NSString stringWithFormat:@"%@,%@,%@\n%@",
                        address_1,zone,city,country];
    return result;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* reuseId =cellId;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId forIndexPath:indexPath];
    
    //
    NSArray* items = _list;
    
    int row = indexPath.row;
    NSDictionary* item = [items objectAtIndex:row];
    //cell.textLabel.text = [item valueForKey:Cart_Product_name];
    AddressCell* theCell = (AddressCell*)cell;
    //theCell.labelFirst.text = first;
    theCell.labelFirst.text =[self wrapFullName:item];
    theCell.labelLast.text =[self wrapAddress:item];
    
    if ([indexPath compare:_selectedIndexPath] == NSOrderedSame) {
        theCell.leftImageView.image = [UIImage imageNamed:@"row_selected.png"];
    }else
        theCell.leftImageView.image = nil;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray* items = _list;
    int row = indexPath.row;
    NSDictionary* item = [items objectAtIndex:row];
    
    if ( [indexPath compare:_selectedIndexPath] == NSOrderedSame) {
        _selectedIndexPath = nil;
    }else{
        _selectedIndexPath = indexPath;
    }
    
    //@step
//    NSIndexSet* set = [NSIndexSet indexSetWithIndex:0];
//    [self.tableView  reloadSections:set  withRowAnimation:UITableViewRowAnimationFade];
    //@step seem the sdk bug, have to use animate while reload table
    [CAnimator reloadTableView:self.tableView];
}

@end
