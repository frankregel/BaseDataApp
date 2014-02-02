//
//  GraphicsProtocol.h
//  DataSucker
//
//  Created by Frank Regel on 30.01.14.
//  Copyright (c) 2014 Frank Regel. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GraphicsProtocol <NSObject>

-(void)pickerButtonTouched:(UIViewController*)pickerViewController;
-(void)tableButtonTouched:(UIViewController*)tableViewController;

@end
