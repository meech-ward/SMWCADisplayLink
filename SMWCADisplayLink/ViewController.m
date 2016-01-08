//
//  ViewController.m
//  SMWCADisplayLink
//
//  Created by Sam Meech Ward on 2016-01-08.
//  Copyright © 2016 Meech-Ward. All rights reserved.
//

#import "ViewController.h"

#import "SMWCADisplayLink.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *barView;
@property (strong, nonatomic) SMWCADisplayLink *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.timer = [[SMWCADisplayLink alloc] init];
    _timer.duration = 5.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)animate:(id)sender {
    
    __weak __block ViewController *weakSelf = self;
    CGFloat screenWidth = CGRectGetWidth(self.view.frame);
    CGRect barViewFrame = self.barView.frame;
    
    _timer.stepBlock = ^void(CGFloat percentComplete) {
        // Update the bar width
        CGFloat newWidth = screenWidth-(screenWidth*percentComplete/100.0);
        weakSelf.barView.frame = CGRectMake(0, CGRectGetMinY(barViewFrame), newWidth, CGRectGetHeight(barViewFrame));
    };
    [_timer startTimer];
}

@end
