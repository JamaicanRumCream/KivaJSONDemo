//
//  KivaFeed.h
//  JSON_HelloWorld
//
//  Created by Chris Paveglio on 6/19/14.
//  Copyright (c) 2014 nobody. All rights reserved.
//

#import "JSONModel.h"
#import "LoanModel.h"

@interface KivaFeed : JSONModel

@property (strong, nonatomic) NSArray<LoanModel>* loans;

@end
