//
//  PresentAnimator.m
//  CustomTransitionExample
//
//  Created by TsauPoYuan on 2015/3/27.
//  Copyright (c) 2015年 LiveSimply. All rights reserved.
//

#import "PresentAnimator.h"

@implementation PresentAnimator

- (id)initWithTransitionImageView:(UIImageView*)transitionImageView
{
    if (self = [super init]) {
        _transitionImageView = transitionImageView;
        _transitionImageView.contentMode = UIViewContentModeScaleAspectFill;
        _transitionImageView.clipsToBounds = YES;
    }
    return self;
}

// This is used for percent driven interactive transitions, as well as for container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}


// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = fromViewController.view;
    
    UIView *toView = toViewController.view;
    
    UIView *containerView = [transitionContext containerView];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    CGRect initialFrame = [transitionContext initialFrameForViewController:fromViewController];
    
    CGRect offscreenRect = CGRectOffset(initialFrame, 0, [UIScreen mainScreen].bounds.size.height);
    
    // Presenting
    if (self.appearing) {
        
        // Position the view offscreen
        
        toView.frame = initialFrame;
        
        toView.alpha = 0;
        
        [containerView addSubview:toView];
        
        [containerView addSubview:_transitionImageView];
        
        //Compute transitionView final frame
        
        CGRect transitionViewFinalFrame = CGRectMake(0, 0, fromViewController.view.frame.size.width, kCoverImageViewHeight);
        
        [UIView animateWithDuration:0.2 animations:^{
            fromView.alpha = 0;
            fromView.frame = CGRectMake(initialFrame.origin.x, initialFrame.origin.y - 15, initialFrame.size.width, initialFrame.size.height);
        }];
        
        [UIView animateWithDuration:0.4 animations:^{
            _transitionImageView.frame = transitionViewFinalFrame;
        }];
        
        [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveLinear animations:^{
            toView.alpha = 1;
            toView.frame = initialFrame;
        } completion:^(BOOL finished) {
            fromView.alpha = 1.0;
            fromView.frame = initialFrame;
            [_transitionImageView removeFromSuperview];
            _transitionImageView = nil;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        
    }
    // Dismissing
    else {
        
        [containerView addSubview:toView];
        [containerView sendSubviewToBack:toView];
        
        [UIView animateWithDuration:duration
                              delay:0
             usingSpringWithDamping:1.2
              initialSpringVelocity:0
                            options:UIViewAnimationOptionCurveLinear
                         animations: ^{
                             
                             fromView.frame = offscreenRect;
                         } completion: ^(BOOL finished) {
                             
                             [fromView removeFromSuperview];
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         }];
    }
}

@end
