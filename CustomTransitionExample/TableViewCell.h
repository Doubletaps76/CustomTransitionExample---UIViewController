//
//  TableViewCell.h
//  CustomTransitionExample
//
//  Created by TsauPoYuan on 2015/3/27.
//  Copyright (c) 2015年 LiveSimply. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCellID @"CellID"
#define kCellHeight 130

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

@end
