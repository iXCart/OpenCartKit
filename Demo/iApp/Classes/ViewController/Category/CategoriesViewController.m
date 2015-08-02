//
//  CategoriesViewController.m
//  iApp
//
//  Created by icoco7 on 6/10/14.
//  Copyright (c) 2014 icocosoftware. All rights reserved.
//

#import "CategoriesViewController.h"
#import "SVPullToRefresh.h"
#import "ProductsViewController.h"
#import "ProductDetailViewController.h"

@interface CategoriesViewController ()

@end

static NSString* ruseCellId = @"BaseCell";

@implementation CategoriesViewController

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
    
   // self.tableView.tableHeaderView = self.searchBar;
    UIEdgeInsets inset = UIEdgeInsetsMake(44+20, 0, 0, 0);
    self.tableView.contentInset = inset;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title =@"Categories";
    [self prepareTableview];
   // [[XCartDataManager sharedManager] getCategories  ];
   // [self loadData];
    
    [self hookPullDownRefresh];
    [self.tableView triggerPullToRefresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchData:(NSString*) keywords{
    if ([CKStringUtils isEmpty:keywords]) {
        return;
    }
    __weak __typeof(self)weakSelf = self;
    OCProductService* serivce = [OCProductService search:keywords page:1];
    [serivce execute:^(id response) {
        NSArray* list = [response objectForKey:@"products"];
        RKMappingResult* rkResult =  [Resource parseResponse2Result:list];
        //@@TODO need pagnation
        _mappingResult = rkResult;
        //@step
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf.tableView reloadData];
    } failure:^(NSError *error) {
        NSString* buf = nil;
        [CDialogViewManager showMessageView:[error localizedDescription] message:buf delayAutoHide: 3];
        //@step
        _mappingResult = nil;
        //@step
         __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf.tableView reloadData];
    }];

  
    
}


- (void)loadData{
     __weak __typeof(self)weakSelf = self;
    OCCategoryService* serivce = [OCCategoryService getCategories:nil];
    [serivce execute:^(id response) {
        _mappingResult = [Resource parseResponse2Result:response];
        //@step
        [weakSelf.tableView reloadData];
        
        [weakSelf stopPullToRefreshAnimation];

    } failure:^(NSError *error) {
       [CDialogViewManager showMessageView:[error localizedDescription] message:nil delayAutoHide: 3];
        [weakSelf stopPullToRefreshAnimation];

    }];

    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    return [_mappingResult count];;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
    NSString* reuseId =ruseCellId;
     
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId forIndexPath:indexPath];
   //
     NSArray* items = [_mappingResult array];
     NSUInteger row = indexPath.row;
     NSDictionary* item = [items objectAtIndex:row];
     NSString* title = [item valueForKey:@"name"];
     cell.textLabel.text = [StringUtils decodeHTMLString:title];
     
 return cell;
 }



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray* items = [_mappingResult array];
    NSUInteger row = indexPath.row;
    NSDictionary* item = [items objectAtIndex:row];
    
    
    AppViewController* viewController = nil;
    if (![CKStringUtils isEmpty:[item stringValueForPath:@"category_id"]]) {
        viewController = [ProductsViewController create];
        viewController.args = item;

    }
    else
    {
        NSString* product_id = (NSString*) [item objectForKey: Product_product_id];
        if (![Lang isEmptyString:product_id]) {
            viewController = [ProductDetailViewController create];
            viewController.args = item;
         }
    }
         
    [self.navigationController pushViewController:viewController animated:true];
    
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar;
{
    searchBar.showsCancelButton= true;
    return  true;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar;
{
    searchBar.showsCancelButton = false;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
{
    
    NSString* keywords =  searchBar.text ;
    if ([Lang isEmptyString:keywords]) {
        [searchBar resignFirstResponder];
        [self loadData];
        return;
    }
 
    [self searchData:keywords];
    
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar;
{
    [searchBar resignFirstResponder];
    //[self loadData];
}

#pragma mark pull to refresh 
- (void)hookPullDownRefresh
{
    __weak CategoriesViewController *weakSelf = self;
    
    // setup pull-to-refresh
    [self.tableView addPullToRefreshWithActionHandler:^{
        weakSelf.searchBar.text = @"";
        [weakSelf  loadData];
    }];
    
    [self.tableView.pullToRefreshView  setTitle:NSLocalizedString(@"Release to load all categories...",@"") forState:(SVPullToRefreshStateTriggered)] ;
    
    self.tableView.pullToRefreshView.arrowColor = [UIColor grayColor];
}

-(void)stopPullToRefreshAnimation
{
    
    [self.tableView.pullToRefreshView stopAnimating]; // call to stop animation
    return;
    UIEdgeInsets inset = UIEdgeInsetsMake(44, 0, 0, 0);
    self.tableView.contentInset = inset;
    self.tableView.scrollIndicatorInsets = inset;
}
@end
