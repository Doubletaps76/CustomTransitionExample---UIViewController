//
//  DetailViewController.m
//  CustomTransitionExample
//
//  Created by TsauPoYuan on 2015/3/27.
//  Copyright (c) 2015年 LiveSimply. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) NSArray *titles;

@end

@implementation DetailViewController

- (id)initWithCoverImageView:(UIImageView*)coverImageView;
{
    if (self = [super init]) {
        _coverImageView = coverImageView;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [closeBtn setTitle:@"X" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(leaveVC) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [closeBtn setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.7]];
    closeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
    closeBtn.frame = CGRectMake(13, 27, 30, 30);
    closeBtn.layer.borderColor = [UIColor blackColor].CGColor;
    closeBtn.layer.borderWidth = 1.0;
    closeBtn.layer.cornerRadius = 15;
    [self.view addSubview:closeBtn];
    
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kCoverImageViewHeight)];
    tableHeaderView.backgroundColor = [UIColor clearColor];
    
    _coverImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kCoverImageViewHeight);
    _coverImageView.clipsToBounds = YES;
    _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [tableHeaderView addSubview:_coverImageView];
    
    _titles = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = tableHeaderView;
    _tableView.separatorColor = [UIColor clearColor];
}

- (void)leaveVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titles.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _titles[indexPath.row];
    return cell;
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _tableView) {
        //do zoom out
        CGFloat offsetY = -scrollView.contentOffset.y;
        if (offsetY > 0) {
            CGRect imgRect = _coverImageView.frame;
            imgRect.origin.y = scrollView.contentOffset.y;
            imgRect.size.height = kCoverImageViewHeight+offsetY;
            _coverImageView.frame = imgRect;
        }
    }
}

@end
