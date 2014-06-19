//
//  LocationModel.h
//  JSON_HelloWorld
//
//  Created by Chris Paveglio on 6/19/14.
//  Copyright (c) 2014 nobody. All rights reserved.
//

#import "JSONModel.h"

@interface LocationModel : JSONModel

@property (strong, nonatomic) NSString *country_code;
@property (strong, nonatomic) NSString *country;

@end
