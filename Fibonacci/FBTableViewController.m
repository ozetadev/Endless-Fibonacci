//
//  FBTableViewController.m
//  Fibonacci
//
//  Created by Philip Bernstein on 1/20/16.
//  Copyright © 2016 iHeartMedia. All rights reserved.
//

#import "FBTableViewController.h"

@interface FBTableViewController ()

@end

@implementation FBTableViewController

static NSString *cellIdentifier = @"FibIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100000; // can't really be longer (sorry), can't use NSIntegerMax
}

#pragma mark - Table view UI

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    double currentFib = [self fibonacciNumberForIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%.0f", currentFib];
    cell.textLabel.adjustsFontSizeToFitWidth = YES; // make sure we don't truncate
    
    return cell;
}


#pragma mark - Fibonacci
-(double)fibonacciNumberForIndexPath:(NSIndexPath *)indexPath {
    
    double rowInput = indexPath.row;
    
    if (!fibData) {
        fibData = [[NSMutableArray alloc] init];
    }
    
    // necessarily "hard" coded portions of sequence
    if (rowInput < 2) {
        
        if (fibData.count <= rowInput) { // data set does not include our value
            [fibData addObject:[NSNumber numberWithDouble:rowInput]];
        }
        
        return rowInput;
    }
    
    if (rowInput < fibData.count) { // already have value, no need to calculate and store
        return [[fibData objectAtIndex:indexPath.row] doubleValue];
    }
    
    // actually calculated sequence numbers
    double minusOne = [[fibData objectAtIndex:rowInput-1] doubleValue];
    double minusTwo = [[fibData objectAtIndex:rowInput-2] doubleValue];
    
    double fibOutput = minusOne + minusTwo;
    
    [fibData addObject:[NSNumber numberWithDouble:fibOutput]];
    
    return fibOutput;
}

@end
