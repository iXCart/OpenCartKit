//
//  AddressViewController.m
//  iApp
//
//  Created by icoco7 on 7/26/14.
//  Copyright (c) 2014 i2Cart.com. All rights reserved.
//

#import "AddressViewController.h"
#import "EditTextFieldCell.h"
#import "StateViewController.h"

@interface AddressViewController ()
{
    NSArray* _defs;
    
    UITextField* _activeField;
    
    EditTextFieldCell* _activeCell;
    
    NSMutableDictionary* _form;
}
@end

@implementation AddressViewController


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
    UINib *nib = [UINib nibWithNibName:@"EditTextFieldCell" bundle:nil];
    [self.tableView registerNib:nib
         forCellReuseIdentifier:@"EditTextFieldCell"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = AppLocalizedString(@"New Address");
    [self prepareTableview];
    
   UIBarButtonItem*  button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction:)];
    [self.navigationItem setLeftBarButtonItem:button];
    
    button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveAction:)];
    [self.navigationItem setRightBarButtonItem:button];
}


- (NSMutableDictionary*)getInputParams
{
    return _form;
}
- (NSMutableDictionary*)getInputParams_discard
{
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    for (NSDictionary* item in _defs) {
        NSString* name = [item valueForKey:@"name"];
        NSString* value = [item valueForKey:@"value"];
        value = [Lang safeString:value toValue:@""];
        [params setObject:value forKey:name];
    }
    
    return  params;
}
#pragma mark - form data source
#pragma mark - form data source
- (NSString*)getInputValueByKey:(NSString*)key
{
    if (nil == _form) {
        return nil;
    }
    
    return [_form valueForKey:key];
}

- (void)setInputValue:(NSString*)key value:(NSString*)value
{
    if (nil == _form) {
        _form = [NSMutableDictionary dictionary];
    }
    [_form setValue:value forKey:key];
}


- (void)saveAction:(id)sender{
    
    if (nil != _activeCell) {
        [_activeCell.textField resignFirstResponder];
    }
    
    NSDictionary* params = [self getInputParams];
    if (nil == params || [params count]<=0) {
        return;
    }
    NSString* firstname = [params objectForKey:@"firstname"];
    NSString* lastname = [params objectForKey:@"lastname"];
    NSString* address_1 = [params objectForKey:@"address_1"];
    
    NSString* city = [params objectForKey:@"city"];
    NSString* country_id = [params objectForKey:@"country_id"];
    NSString* zone_id = [params objectForKey:@"zone_id"];

    //__weak __typeof(self)weakSelf = self;
    
    OCCheckoutService *serivce = nil;
    if (self.isShippingAddress) {
        serivce = [OCCheckoutService addShippingAddress:firstname lastname:lastname company:nil address_1:address_1 address_2:nil city:city postcode:nil country_id:country_id zone_id:zone_id];
    }else{
       serivce = [OCCheckoutService addPaymentAddress:firstname lastname:lastname company:nil address_1:address_1 address_2:nil city:city postcode:nil country_id:country_id zone_id:zone_id];
    }
    
    [serivce execute:^(id response) {
        //__strong __typeof(weakSelf)strongSelf = weakSelf;
        NSDictionary* dict = (NSDictionary*)response;
        NSString* status = [dict stringValueForPath:@"status"];
        BOOL success = [@"success" isEqualToString:status];
        
        if ( success)
        {
            [CDialogViewManager showMessageView:@"" message:@"Save success!" delayAutoHide:1];
            [self performSelector:@selector(closeView:) withObject:nil afterDelay:1.5];
        }else
        {
            [Resource showRestResponseErrorMessage:response];
        }
        
    } failure:^(NSError *error) {
        [CDialogViewManager showMessageView:@"" message:[error localizedDescription] delayAutoHide: 3];
    }];
   
    
}

- (void)cancelAction:(id)sender
{
    [self.parentViewController dismissViewControllerAnimated:true completion:^{
        
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
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
    NSString* cfgFilePath =[Utils getBundleFileAsFullPath:  @"addressViewDef.plist"];
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
    NSArray* array = [self loadDefs ];
    NSMutableArray* list = [NSMutableArray arrayWithCapacity:[array count]];
    for (NSDictionary* item in array) {
        NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithDictionary:item];
        [list addObject:dict];
    }
    
    _defs = list;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSArray* items = _defs;
    int row = indexPath.row;
    NSDictionary* item = [items objectAtIndex:row];
    NSNumber* height = [item valueForKey:@"height"];
    if (nil != height) {
        return  [height floatValue];
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* reuseId =@"EditTextFieldCell";
    
    EditTextFieldCell *cell = (EditTextFieldCell*) [tableView dequeueReusableCellWithIdentifier:reuseId forIndexPath:indexPath];
    cell.indexPath = indexPath;

    NSArray* items = _defs;
    NSUInteger row = indexPath.row;
    NSDictionary* item = [items objectAtIndex:row];

    [cell setArgs:item];
    
 

    
    NSString* title = [item valueForKey:@"title"];
    if (StringEqual(title,@"BLANK")) {
        title = @"";
        cell.textField.enabled = false;
    }
    else
    {
        //@step
        cell.textField.enabled =  ![Lang toBool:[item valueForKey:@"readonly"]];
    }
 
    //@step
    NSString* key = [item valueForKey:@"name"];
    NSString* value = [self getInputValueByKey:key];
    cell.textField.text = [Lang safeString:value toValue:@""];
    //@step
    cell.textField.placeholder = title;
    cell.textField.floatingLabelTextColor = [UIColor blackColor];
    [cell layoutIfNeeded];
    
    //@step
    cell.observer = self;
    
    return cell;
}

- (void)processCommand:(NSDictionary*)dict
{
 
    NSString* class = (NSString*) [dict valueForKey:@"class"];
    do{
        if ([Lang isEmptyString:class]) {
            break;
        }
        
        UIViewController* viewController = [CUIEnginer createViewController:class inNavigationController:false];
        [self.navigationController pushViewController:viewController animated:true];
        
        
    }while (false);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray* items = _defs;
    NSUInteger row = indexPath.row;
    NSDictionary* item = [items objectAtIndex:row];
    [self processCommand:item];
    //@step
    //ProductsViewController* viewController = [[ProductsViewController alloc]initWithNibName:@"ProductsViewController" bundle:nil];
    
    // AppViewController * viewController = [ProductsViewController create];
    // viewController.args = item;
    
    // [self.navigationController pushViewController:viewController animated:true];
    
}

#pragma mark keyboard

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)unregisterForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (void)keyboardWillShown:(NSNotification*)aNotification
{
    UIScrollView* containerView = self.tableView;
    CGRect  activeFrame ;
    
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect frame = self.view.frame;
    frame.size.height -= kbSize.height;
    CGPoint fOrigin = activeFrame.origin;
    fOrigin.y -= containerView.contentOffset.y;
    fOrigin.y += activeFrame.size.height;
    if (!CGRectContainsPoint(frame, fOrigin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeFrame.origin.y + activeFrame.size.height - frame.size.height);
        [containerView setContentOffset:scrollPoint animated:YES];
    }
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [self.tableView setContentOffset:CGPointZero animated:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _activeField = nil;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)update:(id)sender value:(id)value
{
    NSLog(@"%@->update,%@,%@", self,sender, value);
    if (nil!=sender && [sender isKindOfClass:[StateViewController class]]) {
        [self updateCountryStateFields:value];
        return;
    }
    
    if (nil != sender && [sender isKindOfClass:[EditTextFieldCell class]])
    {
        _activeCell = (EditTextFieldCell*)sender;
    }
    
    //@step
    if (nil != value && [value isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary* item = (NSDictionary*)value;
        NSString* key = [item valueForKey:@"name"];
        NSString* value = [item valueForKey:@"value"];
        [self setInputValue:key value:value];
        
        _activeCell = nil;
    }
    
    
}

- (void)updateCountryStateFields:(NSDictionary*)params;
{
    if (nil == params) {
        return;
    }
    if (params) {
        //@step
        
        NSString* key = @"country_id" ;
        NSString* value = [params valueForKey:key];
        [self setInputValue:key value:value];
        //@step
        key = @"name" ;
        value = [params valueForKey:key];
        key = @"country";
        [self setInputValue:key value:value];
        
        
        
        //@step
        if (1) {
            NSDictionary* zone = [params valueForKey:@"zone"];
            NSString* key = @"zone_id" ;
            NSString* value = [zone valueForKey:key];
            [self setInputValue:key value:value];
            //@step
            key = @"name" ;
            value = [zone valueForKey:key];
            key = @"zone";
            [self setInputValue:key value:value];
            
        }
        
        //@step
        //NSArray* cells = [self.tableView visibleCells];
        [self.tableView reloadRowsAtIndexPaths:[self.tableView indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
