//
//  Interface.h
//  iApp
//
//  Created by icoco7 on 7/31/15.
//  Copyright (c) 2015 i2Cart.com All rights reserved.
//

#import <Foundation/Foundation.h>

 
@protocol ObserverDelegate <NSObject>

@required
-(void)update:(id)sender  value :(id) value;

@optional
-(id)onCallBack:(id)sender  value :(id) value;

@end

@interface Interface : NSObject

@end
