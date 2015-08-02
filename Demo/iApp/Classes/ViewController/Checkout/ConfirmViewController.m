//
//  ConfirmViewController.m
//  iApp
//
//  Created by icoco7 on 6/10/14.
//  Copyright (c) 2014 i2Cart.com. All rights reserved.
//

#import "ConfirmViewController.h"
#import "DataModel.h"
#import "ProductDetailViewController.h"
 
#import "CartConfirmItemCell.h"
#import "PaymentAddressViewController.h"
#import "TotalsTableViewController.h"

@interface ConfirmViewController ()
{
     TotalsTableViewController* _totalsController;
}
@end

static NSString* _reuseID = @"CartConfirmItemCell";

@implementation ConfirmViewController

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


-(void)prepareTableview
{
    UINib *nib = [UINib nibWithNibName:_reuseID bundle:nil];
    [self.tableView registerNib:nib
         forCellReuseIdentifier:_reuseID];
    
    if (nil == _totalsController) {
        _totalsController = (TotalsTableViewController*) [TotalsTableViewController create];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = AppLocalizedString(@"Confirm Order");
    
    [self prepareTableview];
   
    
}
- (void)renderToolBar:(BOOL)visiable
{
    
}


- (void)reloadTotalsView
{
    //@step
    NSArray* list = [[_mappingResult dictionary] valueForKey :Cart_totals];
    [_totalsController relaod:list];
    if (nil == _prodcuts || [_prodcuts count] ==0) {
        self.tableView.tableFooterView  = nil;
        _totalsController.tableView.tableFooterView = nil;
    }else
    {
        _totalsController.tableView.tableFooterView = self.bottomView;
        CGRect frame = _totalsController.view.frame;
        frame.size.height = frame.size.height + self.bottomView.frame.size.height;
         _totalsController.view.frame = frame;
        
        self.tableView.tableFooterView = _totalsController.view;
        
        
    }
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self loadData];
    
}

- (void)showNextScene
{
    [self.navigationController popToRootViewControllerAnimated:true];;
    return;
    NSString* message = @"Your Order Has Been Processed!\nThanks for shopping with us online!";
    [CDialogViewManager showMessageView:@"" message:message delayAutoHide:-1];

    
    return;
    AppViewController * viewController = [PaymentAddressViewController create];
    // viewController.args = item;

    [self.navigationController pushViewController:viewController animated:true];
}

- (void)doSuccessAction{
    __weak __typeof(self)weakSelf = self;
    OCCheckoutService *serivce = [OCCheckoutService success];
    [serivce execute:^(id response) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        NSDictionary* dict = (NSDictionary*)response;
        NSString* status = [dict stringValueForPath:@"status"];
        BOOL success = [@"success" isEqualToString:status];
        if (success)
        {
           NSDictionary* data = [response valueForKey:Rest_data];
            NSString* message = [data valueForKey:@"heading_title"];
            [CDialogViewManager showMessageView:@"" message:message delayAutoHide:-1];
            //@step
            [self showNextScene];

        }else
        {
            [Resource showRestResponseErrorMessage:response];
        }
        
        
    } failure:^(NSError *error) {
        
        [CDialogViewManager showMessageView:@"" message:[error localizedDescription] delayAutoHide:-1];
    }];
  
    
    
}
- (IBAction)nextStep:(id)sender{
    __weak __typeof(self)weakSelf = self;
    OCCheckoutService *serivce = [OCCheckoutService paymentConfirm];
    [serivce execute:^(id response) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        NSDictionary* dict = (NSDictionary*)response;
        NSString* status = [dict stringValueForPath:@"status"];
        BOOL success = [@"success" isEqualToString:status];
        if (success)
        {
            [strongSelf doSuccessAction];
        }else
        {
            [Resource showRestResponseErrorMessage:response];
        }

        
    } failure:^(NSError *error) {
        
        [CDialogViewManager showMessageView:@"" message:[error localizedDescription] delayAutoHide:-1];
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
    OCCheckoutService *serivce = [OCCheckoutService confirm];
    [serivce execute:^(id response) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        
        _mappingResult =  [Resource parseResponse2Result:response];
        //@step
        _prodcuts = [[_mappingResult dictionary] valueForKey :Cart_products];
        //@step
        [strongSelf.tableView reloadData];
        //@step
        [strongSelf reloadTotalsView];
        
    } failure:^(NSError *error) {
        
        [CDialogViewManager showMessageView:@"" message:[error localizedDescription] delayAutoHide:-1];
    }];
 
}
#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 151;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_prodcuts count];;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* reuseId =_reuseID;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId forIndexPath:indexPath];
    
         //
    NSArray* items = _prodcuts;

    int row = indexPath.row;
    NSDictionary* item = [items objectAtIndex:row];
    //cell.textLabel.text = [item valueForKey:Cart_Product_name];
    CartConfirmItemCell* theCell = (CartConfirmItemCell*)cell;
    theCell.labelName.text =[item valueForKey:Cart_Product_name];
    theCell.labelName.numberOfLines = 2;
    theCell.labelModel.text = [item valueForKey:Cart_Product_model];
    theCell.labelPrice.text =[item valueForKey:Cart_Product_price];
    
    theCell.labelQuantity.text = [Lang safeNumberToIntString:[item valueForKey:Cart_Product_quantity] toValue:@""] ;
    theCell.labelTotal.text = [item valueForKey:Cart_Product_total];
    //@step
    NSString* imageUrlString = [item valueForKey:Product_thumb];
    [Resource assginImageWithSource:theCell.extImageView source:imageUrlString];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray* items = _prodcuts;
    int row = indexPath.row;
    NSDictionary* item = [items objectAtIndex:row];
    AppViewController * viewController = [ProductDetailViewController create];
    viewController.args = item;
    
    [self.navigationController pushViewController:viewController animated:true];
    
}


@end
