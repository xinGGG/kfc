//
//  JXConnectionTool.m
//  kfc
//
//  Created by xing on 15/7/12.
//  Copyright (c) 2015年 ljx. All rights reserved.
//

#import "JXConnectionTool.h"
@implementation JXConnectionTool
+ (instancetype)connectionWithBlock:(connectionBlock)block{
    
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY年mm月dd日"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    dateString = [self encodeToPercentEscapeString:dateString];
    NSString *urlstr = [NSString stringWithFormat:@"http://a.54whr.com/kfc/get?s=%@",dateString];
    NSURL *url = [NSURL URLWithString:urlstr];
    NSURLRequest *req = [[NSURLRequest alloc]initWithURL:url cachePolicy:0 timeoutInterval:30];
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (block) {
            block(response,data,connectionError);
        }
    }];
    return nil;
}

+ (NSString *)encodeToPercentEscapeString: (NSString *) input{
    
    NSString *outputStr = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)input, NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8));
    return outputStr;
    
}
@end
