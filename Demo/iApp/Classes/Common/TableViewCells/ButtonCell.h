//
//  ButtonCell.h
//  iApp
//
//  Created by icoco7 on 7/8/14.
//  Copyright (c) 2014 i2Cart.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTableViewCell.h"

@interface ButtonCell : CTableViewCell

@property(nonatomic)IBOutlet UIButton* button;

@property(nonatomic) id <ObserverDelegate>observer;

-(IBAction)onClick:(id)sender;

@end
