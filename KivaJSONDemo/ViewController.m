//
//  ViewController.m
//  KivaJSONDemo
//
//  Created by Chris Paveglio on 6/19/14.
//  Copyright (c) 2014 nobody. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
#define kLastKivaLoansURL [NSURL URLWithString:@"http://api.kivaws.org/v1/loans/search.json?status=fundraising"] //2

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *humanReadable;
@property (weak, nonatomic) IBOutlet UILabel *jsonSummary;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dispatch_async(kBgQueue, ^{
        NSData *data = [NSData dataWithContentsOfURL:kLastKivaLoansURL];
        [self performSelectorOnMainThread:@selector(fetchData:) withObject:data waitUntilDone:YES];
    });
}

- (void)fetchData:(NSData *)responseData
{
    //parse out json data
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData
                                                         options:kNilOptions
                                                           error:&error];
    NSArray *latestLoans = json[@"loans"];
    NSLog(@"loans: %@", latestLoans);
    
    //1
    NSDictionary *loan = latestLoans[0];
    
    //2
    NSNumber *fundedAmount = loan[@"funded_amount"];
    NSNumber *loanAmount = loan[@"loan_amount"];
    float outstandingAmount = loanAmount.floatValue - fundedAmount.floatValue;
    
    //3 set label
    _humanReadable.text = [NSString stringWithFormat:@"Latest loan: %@ from %@ needs another $%.2f to pursue their business dream", loan[@"name"], (NSDictionary *)loan[@"location"][@"country"], outstandingAmount];
}

@end
