//
//  VenuesListTableViewController.m
//  HumanityTest
//
//  Created by Dejan Bekic on 7/6/15.
//  Copyright (c) 2015 Dejan Bekic. All rights reserved.
//

#import "VenuesListTableViewController.h"
#import "FoursquareVenueManager.h"
#import "VenueTableViewCell.h"

@interface VenuesListTableViewController ()

@property (strong, nonatomic) NSArray *venues;

@end

@implementation VenuesListTableViewController

#pragma mark - lazy instantiation

- (NSArray *) venues {
    if (!_venues) {
        _venues = [[FoursquareVenueManager sharedManager] allVenues];
    } return _venues;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.venues count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VenueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VenueCell" forIndexPath:indexPath];
    [cell setUpWithVenue:self.venues[indexPath.row]];
    return cell;
}

//this method is called when venues are fetched
- (void) promptRefresh {
    self.venues = nil;
    [self.tableView reloadData];
}

#pragma mark - button action

- (IBAction)onMap:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
