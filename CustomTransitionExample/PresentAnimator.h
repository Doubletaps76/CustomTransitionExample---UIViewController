//
//  PresentAnimator.h
//  CustomTransitionExample
//
//  Created by TsauPoYuan on 2015/3/27.
//  Copyright (c) 2015年 LiveSimply. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@interface PresentAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign, getter = isAppearing) BOOL appearing;

@property (nonatomic, strong) UIImageView *transitionImageView;

- (id)initWithTransitionImageView:(UIImageView*)transitionImageView;

@end
