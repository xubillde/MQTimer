//
//
//  Copyright (c) 2015 mazengyi https://github.com/semazengyi/MQTimer
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "MQTimer.h"

@interface MQTimer ()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSUInteger intStart;
@property (nonatomic, assign) NSUInteger intEnd;
@property (nonatomic, copy) HandleBlock handleBlock;
@property (nonatomic, copy) CompleteBlock completeBlock;

@property (nonatomic, assign) CGFloat timeInterval;
@property (nonatomic, assign) CGFloat current;

@property (nonatomic, assign) BOOL isDesc;  ///是否是递减
@end


@implementation MQTimer



#pragma mark - public
- (void)start:(NSUInteger)start end:(NSUInteger)end interval:(NSTimeInterval)interval handleBlock:(HandleBlock)handleBlock completeBlock:(CompleteBlock)completeBlock;
{
    
    if (start == end) {
        NSLog(@"时间相等");
        return;
    }
    if (self.timer) {
        [self stop];
    }
    self.timer = [self createTimer:interval];
    self.intStart = start;
    self.intEnd = end;
    self.handleBlock = handleBlock;
    self.completeBlock = completeBlock;
    self.current = start;
    if (start > end) {
        //倒数
        self.timeInterval = -interval;
        self.isDesc = YES;
    }
    else
    {
        //正数
        self.timeInterval = interval;
        self.isDesc = NO;
    }
}

- (void)times:(NSUInteger)times interval:(NSTimeInterval)interval handleBlock:(HandleBlock)handleBlock completeBlock:(CompleteBlock)completeBlock
{
    [self start:0 end:times interval:interval handleBlock:handleBlock completeBlock:completeBlock];
}

- (void)stop
{
    //关闭定时器
    [self.timer invalidate];
    self.timer = nil;
}

- (void)pause
{
    if (self.timer) {
        self.timer.fireDate = [NSDate distantFuture];
    }
}

- (void)resume
{
    if (self.timer) {
        self.timer.fireDate = [NSDate distantPast];
    }
}

- (void)start
{
    if (self.timer) {
        [self.timer fire];
    }
}


#pragma mark - private
- (NSTimer *)createTimer:(NSTimeInterval)interval
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(timerHandle) userInfo:nil repeats:YES];
    return timer;
}

#pragma mark - handle
- (void)complete
{
    if (self.completeBlock) {
        self.completeBlock();
        [self stop];
    }
}

- (void)handle
{
    BOOL stop = NO;
    self.handleBlock(self.current, &stop);
    if (stop) {
        [self complete];
    }
}

- (void)timerHandle
{
    self.current += self.timeInterval;
    //倒计时  从大到小
    if (self.isDesc)
    {
        if (self.current <= self.intEnd) {
            [self complete];
        }
        else
        {
            [self handle];
        }
    }
    else
    {
        if (self.current >= self.intEnd) {
            [self complete];
        }
        else
        {
            [self handle];
        }
    }
}


@end
