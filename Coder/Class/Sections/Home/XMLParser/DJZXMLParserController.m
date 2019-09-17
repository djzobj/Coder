//
//  DJZXMLParserController.m
//  Coder
//
//  Created by 张得军 on 2019/9/17.
//  Copyright © 2019 张得军. All rights reserved.
//

#import "DJZXMLParserController.h"

@interface DJZXMLParserController ()<NSXMLParserDelegate>

@end

@implementation DJZXMLParserController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //1.url
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/video?type=XML"];
    //2.创建请求对象
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    
    //3.发送异步请求
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            return ;
        }
        NSXMLParser *parser = [[NSXMLParser alloc]initWithData:data];
        
        //4.2 设置代理
        parser.delegate = self;
        
        //4.3 开始解析,阻塞.解析XML文档并没有开子线程。
        [parser parse];
    }];
    
    [dataTask resume];
    
}

#pragma mark NSXMLParserDelegate

//1.开始解析XML文档的时候
-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"%s",__func__);
}

//2.开始解析某个元素
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    NSLog(@"开始解析%@---%@",elementName,attributeDict);
    //过滤根元素
    if ([elementName isEqualToString:@"videos"]) {
        return;
    }
    
    // attributeDict中存放的是XML文档元素中的内容，以字典的形式
    //字典转模型
    //    [self.videos addObject:[XMGVideo mj_objectWithKeyValues:attributeDict]];
}

//3.某个元素解析完毕
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSLog(@"结束解析%@",elementName);
}

//4.结束解析
-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"%s",__func__);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
