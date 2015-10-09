//
//  ViewController.m
//  MQTimer
//
//  Created by WsdlDev on 15/10/9.
//  Copyright © 2015年 mazengyi. All rights reserved.
//

#import "ViewController.h"
#import "MQTimer.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *startTime;
@property (weak, nonatomic) IBOutlet UITextField *endTime;
@property (weak, nonatomic) IBOutlet UILabel *labCount;
@property (weak, nonatomic) IBOutlet UITextField *times;
@property (weak, nonatomic) IBOutlet UITextField *space;
@property (nonatomic, strong) MQTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    _timer = [MQTimer new];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)start:(id)sender {
    
    __weak typeof(self) weakSelf = self;
    [_timer start:_startTime.text.integerValue  end:_endTime.text.integerValue interval:_space.text.integerValue handleBlock:^(NSUInteger now, BOOL *stop) {
        NSLog(@"%lu", (unsigned long)now);
        weakSelf.labCount.text = [NSString stringWithFormat:@"当前计数:%lu", (unsigned long)now];
    } completeBlock:^{
        NSLog(@"完成");

    }];
    [_timer start];
}
- (IBAction)pause:(id)sender {
    [_timer pause];
}
- (IBAction)resume:(id)sender {
    [_timer resume];
}
- (IBAction)stop:(id)sender {
    [_timer stop];
}
- (IBAction)startCount:(id)sender {
    __weak typeof(self) weakSelf = self;

    [_timer times:_times.text.integerValue interval:_space.text.integerValue handleBlock:^(NSUInteger now, BOOL *stop) {
        NSLog(@"%lu", (unsigned long)now);
        weakSelf.labCount.text = [NSString stringWithFormat:@"当前计数:%lu", (unsigned long)now];

    } completeBlock:^{
        NSLog(@"完成");

    }];
}

@end
