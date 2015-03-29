//
//  ViewController.m
//  CustomTransitionExample
//
//  Created by TsauPoYuan on 2015/3/27.
//  Copyright (c) 2015年 LiveSimply. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "PresentAnimator.h"
#import "TableViewCell.h"


@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) NSIndexPath *selectIndexPath;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _images = [NSMutableArray array];
    [_images addObjectsFromArray:@[[UIImage imageNamed:@"22"],[UIImage imageNamed:@"21"],[UIImage imageNamed:@"20"],[UIImage imageNamed:@"19"],[UIImage imageNamed:@"18"],[UIImage imageNamed:@"17"],[UIImage imageNamed:@"16"],[UIImage imageNamed:@"15"],[UIImage imageNamed:@"14"],[UIImage imageNamed:@"13"],[UIImage imageNamed:@"12"],[UIImage imageNamed:@"11"],[UIImage imageNamed:@"10"],[UIImage imageNamed:@"9"],[UIImage imageNamed:@"8"],[UIImage imageNamed:@"7"],[UIImage imageNamed:@"6"],[UIImage imageNamed:@"5"],[UIImage imageNamed:@"4"],[UIImage imageNamed:@"3"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"1"]]];
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TableViewCell class]) bundle:nil] forCellReuseIdentifier:kCellID];
}

#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _images.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    
    cell.coverImageView.image = _images[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectIndexPath = indexPath;
    
    DetailViewController *detailVC = [[DetailViewController alloc] initWithCoverImageView:[[UIImageView alloc] initWithImage:_images[indexPath.row]]];
    detailVC.transitioningDelegate = self;
    
    [self presentViewController:detailVC animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

#pragma mark - TransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    CGRect rectOfCellInTableView = [_tableView rectForRowAtIndexPath:_selectIndexPath];
    CGRect rectOfCellInSuperView = [_tableView convertRect:rectOfCellInTableView toView:[_tableView superview]];
    UIImageView *sourceImageView = [[UIImageView alloc] initWithFrame:rectOfCellInSuperView];
    sourceImageView.image = _images[_selectIndexPath.row];
    PresentAnimator *animator = [[PresentAnimator alloc] initWithTransitionImageView:sourceImageView];
    animator.appearing = YES;
    
    return animator;
}

- (id<UIViewControllerAnimatedTransitioning>) animationControllerForDismissedController:(UIViewController *)dismissed
{
    PresentAnimator *animator = [[PresentAnimator alloc] init];
    animator.appearing = NO;
    return animator;
}

@end
