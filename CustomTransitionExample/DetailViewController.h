//
//  DetailViewController.h
//  CustomTransitionExample
//
//  Created by TsauPoYuan on 2015/3/27.
//  Copyright (c) 2015年 LiveSimply. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCoverImageViewHeight 200

@interface DetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


- (id)initWithCoverImageView:(UIImageView*)coverImageView;

@end
