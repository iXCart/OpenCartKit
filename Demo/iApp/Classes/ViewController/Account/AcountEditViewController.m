//
//  AcountEditViewController.m
//  iApp
//
//  Created by icoco7 on 7/26/14.
//  Copyright (c) 2014 i2Cart.com. All rights reserved.
//

#import "AcountEditViewController.h"
#import "EditTextFieldCell.h"


@interface AcountEditViewController ()
{
    NSArray* _defs;
    
    UITextField* _activeField;
    EditTextFieldCell* _activeCell;
    
    NSMutableDictionary* _form;
}
@end

@implementation AcountEditViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

static NSString* _reuseID = @"EditTextFieldCell";

-(void)prepareTableview
{
    UINib *nib = [UINib nibWithNibName:_reuseID bundle:nil];
    [self.tableView registerNib:nib
         forCellReuseIdentifier:_reuseID];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = AppLocalizedString(@"Account Information");
    [self prepareTableview];
    
    UIBarButtonItem* button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveAction:)];
    [self.navigationItem setRightBarButtonItem:button];
}


- (NSMutableDictionary*)getInputParams
{
    //return _form;
    
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    for (NSDictionary* item in _defs) {
        NSString* name = [item valueForKey:@"name"];
        NSString* value = [item valueForKey:@"value"];
        value = [Lang safeString:value toValue:@""];
        [params setObject:value forKey:name];
    }

    return  params;
}

- (void)saveAction:(id)sender
{
    if (nil != _activeCell) {
        [_activeCell.textField resignFirstResponder];
    }
    NSDictionary* params = [self getInputParams];
    if (nil == params || [params count]<=0) {
        return;
    }
    
    NSString* firstname = [params valueForKey:@"firstname"];
    NSString* lastname = [params valueForKey:@"lastname"];
    NSString* email = [params valueForKey:@"email"];
    NSString* telephone = [params valueForKey:@"telephone"];
    NSString* fax = [params valueForKey:@"fax"];
    
    __weak __typeof(self)weakSelf = self;
    OCAccountService* serivce = [OCAccountService edit:firstname lastname:lastname email:email telephone:telephone fax:fax];
    [serivce execute:^(id response) {
        NSDictionary* dict = (NSDictionary*)response;
        NSString* status = [dict stringValueForPath:@"status"];
        BOOL success = [@"success" isEqualToString:status];
        if (success)
        {
            [weakSelf.navigationController popViewControllerAnimated:true];
        }else
        {
            [Resource showRestResponseErrorMessage:response];
        }
    } failure:^(NSError *error) {
        [CDialogViewManager showMessageView:[error localizedDescription] message:nil delayAutoHide: 3];
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
    [self loadDefsDataToView];
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
    NSString* cfgFilePath =[Utils getBundleFileAsFullPath:  @"accountEditViewDef.plist"];
    NSArray* data = [NSArray arrayWithContentsOfFile:cfgFilePath];
	if (nil == data || [data count]<=0) {
		NSLog(@"Miss read data from->[%@]", cfgFilePath);
		return nil;
	}
    NSLog(@"%@->loadDefs:[%@]",self, data);
    return data;
}

- (void)loadDefsDataToView
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

- (void)loadData
{
    __weak __typeof(self)weakSelf = self;
    OCAccountService* serivce = [OCAccountService getEditInfo];
    [serivce execute:^(id response) {
        RKMappingResult* result =  [Resource parseResponse2Result:response];
        _mappingResult = result;
        //@step
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        [CDialogViewManager showMessageView:[error localizedDescription] message:nil delayAutoHide: 3];
    }];

    
    
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
    NSInteger row = indexPath.row;
    NSDictionary* item = [items objectAtIndex:row];
    NSNumber* height = [item valueForKey:@"height"];
    if (nil != height) {
        return  [height floatValue];
    }
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* reuseId =_reuseID;
    
    EditTextFieldCell *cell = (EditTextFieldCell*) [tableView dequeueReusableCellWithIdentifier:reuseId forIndexPath:indexPath];
    cell.indexPath = indexPath;

    NSArray* items = _defs;
    NSInteger row = indexPath.row;
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
  
    
    cell.textField.placeholder = title;
    cell.textField.floatingLabelTextColor = [UIColor lightGrayColor];
    cell.textField.textAlignment = NSTextAlignmentCenter;
    [cell layoutIfNeeded];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.observer = self;
    //@step
    if (nil != _mappingResult) {
        NSDictionary* dict = [_mappingResult dictionary];
        NSString* name = [item valueForKey:@"name"];
        NSString* value = [dict  valueForKey:name];
        [item setValue:value forKey:@"value"];
        
        cell.textField.text = value;
    }
    return cell;
}

- (void)processCommand:(NSDictionary*)dict
{
    NSString* class = (NSString*) [dict valueForKey:@"class"];
    if (StringEqual(class, @"Logout")) {
        
      
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray* items = _defs;
    int row = indexPath.row;
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
    if (nil != sender && [sender isKindOfClass:[EditTextFieldCell class]])
    {
        _activeCell = (EditTextFieldCell*)sender;
    }
    return;
    //@step
    if (nil != value && [value isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary* item = (NSDictionary*)value;
        NSString* key = [item valueForKey:@"name"];
        NSString* value = [item valueForKey:@"value"];
        [self setInputValue:key value:value];
        
        _activeCell = nil;
    }
    
  
}

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


@end
