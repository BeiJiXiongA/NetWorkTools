//
//  ViewController.m
//  NetWorkTools
//
//  Created by ZhangWei-SpaceHome on 2017/4/20.
//  Copyright © 2017年 zhangwei. All rights reserved.
//

#import "ViewController.h"
#import "AFHTTPSessionManager.h"
#import "AFURLResponseSerialization.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UITextView *jsonTextView;
@property (weak, nonatomic) IBOutlet UITextField *clientIDTextFielf;

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *clientSeg;

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *clientType;
@property (nonatomic, strong) NSString *clientID;
@property (weak, nonatomic) IBOutlet UIButton *checkResult;
@property (nonatomic, strong) NSString *messId;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _url = @"http://kjjapi.kongjianjia.com/index/AsynPush/push";
    self.urlTextField.text = _url;
    
    //versiontype  1:B,2:C
    _clientSeg.selectedSegmentIndex = 0;
    _clientType = [NSString stringWithFormat:@"%zi",_clientSeg.selectedSegmentIndex+1];
    [_clientSeg addTarget:self action:@selector(typeChange) forControlEvents:UIControlEventValueChanged];
    //LIP:73533ce931f6ac0c99b6a69efffd653c
    /*touch :262791ea73abb8aa9572ae3056c744cf*/
    // zw iphone:371a4e1a5f7e2f9b5fe5b6f7582803bf
    //c端 :zw的 iphone :0c22b6e433623406a6249f42e273fd26
    //9d6a4e8215065d49ebdce8e053bd3274
    _clientID = @"371a4e1a5f7e2f9b5fe5b6f7582803bf";
    _clientIDTextFielf.text = _clientID;
    
}

-(void)typeChange
{
    _clientType = [NSString stringWithFormat:@"%zi",_clientSeg.selectedSegmentIndex+1];
}

- (IBAction)startRequest:(UIButton *)sender {
    
    NSString *url = @"http://kjjapi.kongjianjia.com/index/AsynPush/push";
    _clientID = [NSString stringWithFormat:@"[\
    {\"ge_id\":\"371a4e1a5f7e2f9b5fe5b6f7582803bf\",\"versiontype\":\"1\"},\
    {\"ge_id\":\"0c22b6e433623406a6249f42e273fd26\",\"versiontype\":\"2\"}]"];
    NSDictionary *contentDict = @{@"ios":_clientID,@"content":@"您有一条竞拍信息",@"title":@"竞拍",@"type":@"13",@"param":@"8116"};
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/x-javascript", @"text/html", nil];
    mgr.requestSerializer.timeoutInterval = 60.0;
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 2.发送一个POST请求
    [mgr POST:url parameters:contentDict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
        NSLog(@"push data %@",dictData);
        
        self.jsonTextView.text = dictData.description;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 告诉外界(外面):我们请求失败了
        NSLog(@"error %@",error);
    }];
}
- (IBAction)checkResult:(id)sender {
    
    NSString *url = @"http://kjjapi.kongjianjia.com/index/AsynPush/getR";
    //OSL-0427_dn4Q3sG1sP6yY30qsoT3L6 //3:00 PM
    //OSL-0427_kyIiYZmYBm7S3EtR3rUE33 //16:16
    //OSL-0508_gPu86XPEwn9F6mwHT4DDJA  //5-8 17:09
    NSDictionary *contentDict = @{@"messId":@"OSL-0508_gPu86XPEwn9F6mwHT4DDJA"};
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/x-javascript", @"text/html", nil];
    mgr.requestSerializer.timeoutInterval = 60.0;
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 2.发送一个POST请求
    [mgr POST:url parameters:contentDict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
        NSLog(@"result data %@",dictData);
        self.jsonTextView.text = dictData.description;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 告诉外界(外面):我们请求失败了
        NSLog(@"error %@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
