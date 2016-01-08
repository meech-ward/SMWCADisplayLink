//
//  SMWCADisplayLink.m
//  SMWCADisplayLink
//
//  Created by Sam Meech Ward on 2016-01-08.
//  Copyright © 2016 Meech-Ward. All rights reserved.
//

#import "SMWCADisplayLink.h"

@interface SMWCADisplayLink() {
    CFTimeInterval _lastStep;
    CFTimeInterval _timeOffset;
}

@property (strong, nonatomic) CADisplayLink *timer;

@end

@implementation SMWCADisplayLink

@synthesize duration = _duration;

- (void)startTimer {
    // Stop the timer if it's already running
    [self stopTimer];
    
    // Start the timer
    _lastStep = CACurrentMediaTime();
    _timeOffset = 0;
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(step:)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)step:(CADisplayLink *)timer {
    // Calculate the time change
    CFTimeInterval thisStep = CACurrentMediaTime();
    CFTimeInterval stepDuration = thisStep - _lastStep;
    _lastStep = thisStep;
    
    // Update the time offset
    _timeOffset = MIN(_timeOffset + stepDuration, _duration);
    
    // Get the percentage of animation completion
    CGFloat percent = (_timeOffset / _duration)*100.0;
    
    // Perform animation updates
    if (_stepBlock) {
        _stepBlock(percent);
    }
    
    // Stop the timer if we've reached the end
    if (_timeOffset >= _duration) {
        [self stopTimer];
    }
}

- (void)stopTimer {
    [_timer invalidate];
    self.timer = nil;
}

@end
