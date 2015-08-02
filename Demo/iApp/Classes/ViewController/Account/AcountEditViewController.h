//
//  AcountEditViewController.h
//  iApp
//
//  Created by icoco7 on 7/26/14.
//  Copyright (c) 2014 i2Cart.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppTableViewController.h"
@interface AcountEditViewController : AppTableViewController<UITextFieldDelegate,ObserverDelegate>
{
}
 
@property (nonatomic)BOOL isShippingAddress;
@end
