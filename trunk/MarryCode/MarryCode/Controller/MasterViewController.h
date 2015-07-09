//
//  MasterViewController.h
//  APParallaxHeaderDemo
//
//  Created by Mathias Amnell on 2013-04-12.
//  Copyright (c) 2013 Apping AB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIImageView *topView;
@property (strong, nonatomic) IBOutlet UILabel *topLabel;
- (IBAction)insertCell:(id)sender;
@property (nonatomic) NSMutableArray *cellArray;

@end
