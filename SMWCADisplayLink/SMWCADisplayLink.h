//
//  SMWCADisplayLink.h
//  SMWCADisplayLink
//
//  Created by Sam Meech Ward on 2016-01-08.
//  Copyright © 2016 Meech-Ward. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

/// A block that should be called upon each interval.
typedef void (^SMWCADisplayLinkStep)(CGFloat percentComplete);

NS_ASSUME_NONNULL_BEGIN

@interface SMWCADisplayLink : NSObject

/// The CADisplayLink that controls the timing.
@property (strong, nonatomic, readonly, nullable) CADisplayLink *timer;

/// The block that will be called upon each screen refresh.
@property (strong, nonatomic) SMWCADisplayLinkStep stepBlock;

/// The duration of the entire animaiton.
@property (nonatomic) CFTimeInterval duration;

/// Start / Restart the animation timer.
- (void)startTimer;

/// Stop the animation timer.
- (void)stopTimer;

@end

NS_ASSUME_NONNULL_END