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

#import <UIKit/UIKit.h>

/**
 *  @brief  时间处理回调事件，设定的时间间隔到了会自动回调
 *
 *  @param now  现在的计数
 *  @param stop 时候理解停止
 */
typedef void(^HandleBlock)(NSUInteger now, BOOL *stop);

/**
 *  @brief  计数完毕的回调
 */
typedef void(^CompleteBlock)();


@interface MQTimer : NSObject

/**
 *  @brief  指定一个开始的数量到一个结束的数量来开始一个计数器
 *
 *  @param start         开始的数值
 *  @param end           结束的数值
 *  @param interval      回调的时间间隔
 *  @param handleBlock   回调处理方法
 *  @param completeBlock 完成时候的回调
 */
- (void)start:(NSUInteger)start end:(NSUInteger)end interval:(NSTimeInterval)interval handleBlock:(HandleBlock)handleBlock completeBlock:(CompleteBlock)completeBlock;

/**
 *  @brief  指定次数来开始一个计数器
 *
 *  @param times         次数
 *  @param interval      回调的时间间隔
 *  @param handleBlock   回调的处理方法
 *  @param completeBlock 完成时候的回调
 */
- (void)times:(NSUInteger)times interval:(NSTimeInterval)interval handleBlock:(HandleBlock)handleBlock completeBlock:(CompleteBlock)completeBlock;

/**
 *  @brief  停止计数
 */
- (void)stop;

/**
 *  @brief  暂停计数
 */
- (void)pause;

/**
 *  @brief  继续计数
 */
- (void)resume;

/**
 *  @brief  开始计数，通常在通过调用
 *  - (void)start:(NSUInteger)start end:(NSUInteger)end interval:(NSTimeInterval)interval handleBlock:(HandleBlock)handleBlock completeBlock:(CompleteBlock)completeBlock;
 *  或者
 *  - (void)times:(NSUInteger)times interval:(NSTimeInterval)interval handleBlock:(HandleBlock)handleBlock completeBlock:(CompleteBlock)completeBlock;
 *  之后调用此方法开始计数
 */
- (void)start;

@end
