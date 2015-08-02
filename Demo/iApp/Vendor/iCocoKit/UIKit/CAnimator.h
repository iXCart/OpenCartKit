//
//  CAnimator.h
//  iApp
//
//  Created by icoco7 on 6/10/14.
//  Copyright (c) 2014 i2Cart.com. All rights reserved.
//

#import <Foundation/Foundation.h>
 
@interface CAnimator : NSObject


+ (void)fadeView:(UIView*)targetView completion:(void (^)(BOOL finished))completion;

+ (void)reloadTableView:(UITableView*)tableView;

@end
