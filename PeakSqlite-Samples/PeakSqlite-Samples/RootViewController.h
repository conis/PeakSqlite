//
//  ViewController.h
//  PeakSqlite-Samples
//
//  Created by conis on 8/21/13.
//  Copyright (c) 2013 conis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodolistEntity.h"

@interface RootViewController : UIViewController<UITabBarDelegate, UITableViewDataSource>
@property (nonatomic, strong) FMDatabase *database;
@property (weak, nonatomic) IBOutlet UITextField *todoInput;
@property (weak, nonatomic) IBOutlet UITableView *todolist;
@property (strong, nonatomic) NSArray *datas;
@end
