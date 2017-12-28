//
//  ViewController.m
//  TestRAC
//
//  Created by 贺杨 on 2017/12/18.
//  Copyright © 2017年 贺杨. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveCocoa.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) RACSignal *networkSig;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    RAC(self.button,enabled) = [RACSignal combineLatest:@[self.userNameField.rac_textSignal,self.passwordField.rac_textSignal]
//                                                 reduce:^id(NSString *userName,NSString *password){
//                                                     return @(userName.length >= 8 && password.length >= 6);
//                                                 }];
    self.button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [self login];
    }];
    [self.button.rac_command.executionSignals subscribeNext:^(id x) {
        NSLog(@"\nbegin---\n%@\n---end",x);

//        if ([x boolValue] == YES) {
//            NSLog(@"\nbegin---\n%@\n---end",@"success" );
//        }
//        else {
//            NSLog(@"\nbegin---\n%@\n---end",@"failure");
//        }
    }];
}


- (RACSignal *)login {
    RACSignal *sig = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        if ([self.userNameField.text isEqualToString:@"yang2333"] && [self.passwordField.text isEqualToString:@"123456"]) {
            [subscriber sendNext:@(1)];
            [subscriber sendCompleted];
        }
        else {
            [subscriber sendNext:@(0)];
            [subscriber sendCompleted];
        }
        return nil;
    }];
    
    return sig;
}

//- (RACSignal *)firstSig {
//
//    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        [subscriber sendNext:@1];
//        [subscriber sendCompleted];
//        return nil;
//    }];
//}

//- (void)testRAC {
//    __block int callCount = 0;
//    self.networkSig = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        __block int i = 0;
//        callCount ++;
//        NSLog(@"\nbegin---\n callCount ==%d\n---end",callCount );
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            i++;
//            [subscriber sendNext:@(i)];
//        });
//        return nil;
//    }];
//
//    RACSubject *subject = [RACSubject subject];
//    RACMulticastConnection *multicastConnection = [self.networkSig multicast:subject];
//    [multicastConnection connect];
//
//    [multicastConnection.signal subscribeNext:^(id x) {
//        NSLog(@"\nbegin---\nfirst i ====  %@\n---end", x);
//    }];
//
//    [multicastConnection.signal subscribeNext:^(id x) {
//        NSLog(@"\nbegin---\nsecond i ====  %@\n---end", x);
//    }];


//    RAC(self.label,text,@"nil的值") = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        __block int i = 0;
//        [[self.button rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(id x) {
//            i ++;
//            if (i > 3) {
//                [subscriber sendNext:nil];
//            }
//            else {
//                [subscriber sendNext:@"123"];
//            }
//
//        }];
//        return nil;
//        }];
    
    
//    __block int testNum = 0;
//    RACSignal *sig = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        testNum ++;
//        [subscriber sendNext:@1];
//        return nil;
//    }];
//
//    [sig subscribeNext:^(id x) {
//        NSLog(@"\nbegin---\n%@\n---end",x );
//    }];
    
    
//    __block int missilesToLaunch = 0;

    // Signal that will have the side effect of changing `missilesToLaunch` on
    // subscription.
//    RACSignal *processedSignal = [[RACSignal
//                                   return:@"missiles"]
//                                  map:^(id x) {
//                                      missilesToLaunch++;
//                                      return [NSString stringWithFormat:@"will launch %d %@", missilesToLaunch, x];
//                                  }];
//
//    // This will print "First will launch 1 missiles"
//    [processedSignal subscribeNext:^(id x) {
//        NSLog(@"First %@", x);
//    }];
//
//    // This will print "Second will launch 2 missiles"
//    [processedSignal subscribeNext:^(id x) {
//        NSLog(@"Second %@", x);
//    }];

    
    
//    NSArray *strings = @[ @"A", @"B", @"C" ];
//    RACSequence *sequence = [strings.rac_sequence map:^(NSString *str) {
//        NSLog(@"%@", str);
//        return [str stringByAppendingString:@"_"];
//    }];
////
////    // Logs "A" during this call.
//    NSString *concatA = sequence.head;
//    NSString *tail = sequence.tail.head;
////
//    // Logs "B" during this call.
//    NSString *concatB = sequence.tail.head;
//
//    // Does not log anything.
//    NSString *concatB2 = sequence.tail.head;
//
//    RACSequence *derivedSequence = [sequence map:^(NSString *str) {
//        return [@"_" stringByAppendingString:str];
//    }];
//    // oncatA2 : A_
//    NSString *concatA2 = sequence.head;

    
//    RACSequence *numbers = @{@"key1":@"values",@"key2":@"value2"}.rac_sequence;
//
//    // Contains: 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9
//    RACSequence *extended = [numbers flattenMap:^(NSString *num) {
//        return num.rac_sequence;
//    }];
//
//    // Contains: 1_ 3_ 5_ 7_ 9_
//    RACSequence *edited = [numbers flattenMap:^(NSString *num) {
//        if (num.intValue % 2 == 0) {
//            return [RACSequence empty];
//        } else {
//            NSString *newNum = [num stringByAppendingString:@"_"];
//            return [RACSequence return:newNum];
//        }
//    }];
    
    
//    RACSubject *letters = [RACSubject subject];
//    RACSubject *numbers = [RACSubject subject];
//    RACSubject *signalOfSignals = [RACSubject subject];
//
//    RACSignal *switched = [signalOfSignals switchToLatest];
//
//    // Outputs: A B 1 D
//    [switched subscribeNext:^(NSString *x) {
//        NSLog(@"%@", x);
//    }];
//
//    [signalOfSignals sendNext:letters];
//    [letters sendNext:@"A"];
//    [letters sendNext:@"B"];
//
//    [signalOfSignals sendNext:numbers];
//    [letters sendNext:@"C"];
//    [numbers sendNext:@"1"];
//
//    [signalOfSignals sendNext:letters];
//    [numbers sendNext:@"2"];
//    [letters sendNext:@"D"];
//
    
    
    
    
//    RACSubject *letters = [RACSubject subject];
//    RACSubject *numbers = [RACSubject subject];
//    RACSignal *combined = [RACSignal
//                           combineLatest:@[ letters, numbers ]
//                           reduce:^(NSString *letter, NSString *number) {
//                               return [letter stringByAppendingString:number];
//                           }];
//
//    // Outputs: B1 B2 C2 C3
//    [combined subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];
//
//    [letters sendNext:@"A"];
//    [letters sendNext:@"B"];
//    [numbers sendNext:@"1"];
//    [numbers sendNext:@"2"];
//    [letters sendNext:@"C"];
//    [numbers sendNext:@"3"];
    
    
    
//    RACSignal *letters = [@"A B C D E F G H I" componentsSeparatedByString:@" "].rac_sequence.signal;
//
//    // The new signal only contains: 1 2 3 4 5 6 7 8 9
//    //
//    // But when subscribed to, it also outputs: A B C D E F G H I
//    RACSignal *sequenced = [[letters
//                             doNext:^(NSString *letter) {
//                                 NSLog(@"%@", letter);
//                             }]
//                            then:^{
//                                return [@"1 2 3 4 5 6 7 8 9" componentsSeparatedByString:@" "].rac_sequence.signal;
//                            }];
//
//    NSArray *tmp = sequenced.toArray;
    
    
//    RACSubject *letters = [RACSubject subject];
//    RACSubject *numbers = [RACSubject subject];
//    RACSignal *signalOfSignals = [RACSignal createSignal:^ RACDisposable * (id<RACSubscriber> subscriber) {
//        [subscriber sendNext:letters];
//        [subscriber sendNext:numbers];
//        [subscriber sendCompleted];
//        return nil;
//    }];
//
////    RACSignal *flattened = [signalOfSignals flatten];
//
//    // Outputs: A 1 B C 2
//    [signalOfSignals subscribeNext:^(NSString *x) {
//        NSLog(@"%@", x);
//    }];
//
//    [letters sendNext:@"A"];
//    [numbers sendNext:@"1"];
//    [letters sendNext:@"B"];
//    [letters sendNext:@"C"];
//    [numbers sendNext:@"2"];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
