//
//  LoanModel.h
//  JSON_HelloWorld
//
//  Created by Chris Paveglio on 6/19/14.
//  Copyright (c) 2014 nobody. All rights reserved.
//

#import "JSONModel.h"
#import "LocationModel.h"

@protocol LoanModel
@end

@interface LoanModel : JSONModel

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *use;

@property (strong, nonatomic) LocationModel *location;

@end
