//
//  StateViewController.m
//  iApp
//
//  Created by icoco7 on 12/8/14.
//  Copyright (c) 2014 i2Cart.com. All rights reserved.
//

#import "StateViewController.h"
#import "RegisterViewController.h"

@interface StateViewController ()
{
    NSIndexPath* _selectedIndexPath;
    
    NSArray* _list;
}
@end

static NSString*  _reuseId = @"UITableViewCell";

@implementation StateViewController

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
    //UINib *nib = [UINib nibWithNibName:_reuseId bundle:nil];
    
    [self.tableView registerClass:[ UITableViewCell class]
           forCellReuseIdentifier:_reuseId] ;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = AppLocalizedString(@"Region/State");
    
    if (nil !=self.args) {
        NSString* name = [self.args valueForKey:@"name"];
        self.title = name;
    }
    [self prepareTableview];
    
    
}

- (void)renderToolBar:(BOOL)visiable
{
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self loadData];
    
}


#pragma mark data routine

#pragma loadData
- (void)loadData
{
    NSString* countryId = [self.args valueForKey:@"country_id"];
    if ([Lang isEmptyString:countryId]) {
        return;
    }
    
    __weak __typeof(self)weakSelf = self;
    OCAddressService* serivce = [OCAddressService regions:countryId];
    [serivce execute:^(id response) {
        RKMappingResult* result =  [Resource parseResponse2Result:response];
        _mappingResult = result;
        
        _list =  [response objectForKey:@"zone"];

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
    
    return [_list count];;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* reuseId =_reuseId;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId ];
    //[[CartItemCell alloc]initWithFrame:CGRectZero];
    //
    NSArray* items = _list;
    
    NSInteger row = indexPath.row;
    NSDictionary* item = [items objectAtIndex:row];
    
    NSLog(@"cellForRowAtIndexPath->%@",[item description]);
    
    cell.textLabel.text = [item valueForKey:@"name"];
    
    if ([indexPath compare:_selectedIndexPath] == NSOrderedSame) {
        cell.imageView.image = [UIImage imageNamed:@"row_selected.png"];
    }else
        cell.imageView.image  = nil;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( [indexPath compare:_selectedIndexPath] == NSOrderedSame) {
        [self setSelectIndexPath:nil];
    }else{
        [self setSelectIndexPath:indexPath];
    }
    
    //@step
    NSIndexSet* set = [NSIndexSet indexSetWithIndex:0];
    [self.tableView  reloadSections:set  withRowAnimation:UITableViewRowAnimationFade];
    
    
}

#pragma 
- (RegisterViewController*)findRegisterViewController;
{
    NSArray* viewControllers = self.navigationController.viewControllers;
    NSUInteger iMax = [viewControllers count];
    for (int i=0; i < iMax ; i++) {
        UIViewController* item = [viewControllers objectAtIndex:i];
        if ([item isKindOfClass:[RegisterViewController class]]) {
            return item;
        }
    }
    
    return nil;
}

- (UIViewController*)updateObserver:(NSDictionary*)value;
{
    NSArray* viewControllers = self.navigationController.viewControllers;
    NSUInteger iMax = [viewControllers count];
    for (int i=0; i < iMax ; i++) {
        UIViewController* item = [viewControllers objectAtIndex:i];
        if ([item conformsToProtocol:@protocol(ObserverDelegate)]) {
          id <ObserverDelegate> observer=   (id <ObserverDelegate>) item;
            [observer update:self value:value];
            return item;
        }
    }
    
    return nil ;
}
#pragma upate next button
- (void)setSelectIndexPath:(NSIndexPath*)indexPath
{
    _selectedIndexPath = indexPath;
    if (nil != _selectedIndexPath )
    {
        NSArray* items = _list;
        NSInteger row = _selectedIndexPath.row;
        NSDictionary* item = [items objectAtIndex:row];
        //@step
        [self.args setValue:item forKey: @"zone"] ;
        
        UIViewController* targetView = [self updateObserver:self.args];// [self findRegisterViewController];
        //targetView.args = self.args;
        
        [self.navigationController popToViewController:targetView animated:true];
        
        //[targetView updateCountryStateFields];
    }
}


@end
