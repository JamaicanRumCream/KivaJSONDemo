//
//  MasterViewController.m
//  JSON_HelloWorld
//
//  Created by Chris Paveglio on 6/19/14.
//  Copyright (c) 2014 nobody. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

#import "JSONModelLib.h"
#import "KivaFeed.h"
#import "HUD.h"

@interface MasterViewController()
{
    KivaFeed *_feed;
}

@end


@implementation MasterViewController

- (void)viewDidAppear:(BOOL)animated
{
    //show loader progress
    [HUD showUIBlockingIndicatorWithText:@"Fetching JSON"];
    
    //fetch the feed
    _feed = [[KivaFeed alloc] initFromURLWithString:@"http://api.kivaws.org/v1/loans/search.json?status=fundraising"
                                         completion:^(JSONModel *model, JSONModelError *err){
                                             //hide hud now
                                             [HUD hideUIBlockingIndicator];
                                             //json is fetched
                                             NSLog(@"loans: %@", _feed.loans);
                                             [self.tableView reloadData];
                                         }];
    
    /* alternate data initialization
     [JSONHTTPClient getJSONFromURLWithString:@"url..."
     completion:^(NSDictionary *json, JSONModelError *err) {
     
     NSError* error = nil;
     _feed = [[KivaFeed alloc] initWithDictionary:json error:&error];
     
     [self.tableView reloadData];
     }];
     */
}

#pragma mark - table methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _feed.loans.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoanModel* loan = _feed.loans[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ from %@",
                           loan.name, loan.location.country];
    return cell;
}

@end