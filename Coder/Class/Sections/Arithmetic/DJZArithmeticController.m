//
//  DJZArithmeticController.m
//  Coder
//
//  Created by 张得军 on 2019/9/29.
//  Copyright © 2019 张得军. All rights reserved.
//

#import "DJZArithmeticController.h"

@interface DJZArithmeticController ()

@end

@implementation DJZArithmeticController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

int BinarySearch(int array[], int n, int value)
{
    int left = 0;
    int right = n - 1;
    //如果这里是int right = n 的话，那么下面有两处地方需要修改，以保证一一对应：
    //1、下面循环的条件则是while(left < right)
    //2、循环内当 array[middle] > value 的时候，right = mid

    while (left <= right)  //循环条件，适时而变
    {
        int middle = left + ((right - left) >> 1);  //防止溢出，移位也更高效。同时，每次循环都需要更新。
        if (array[middle] > value)
            right = middle - 1;  //right赋值，适时而变
        else if (array[middle] < value)
            left = middle + 1;
        else
            return middle;
        //可能会有读者认为刚开始时就要判断相等，但毕竟数组中不相等的情况更多
        //如果每次循环都判断一下是否相等，将耗费时间
    }
    return -1;
}

- (void)insertSortArray {
    NSMutableArray *array = @[@"2", @"1", @"7", @"5", @"8", @"3"].mutableCopy;
    NSInteger j;
    NSInteger i;
    for (j = 1; j < array.count; j ++) {
        NSString *tmp = array[j];
        i = j - 1;
        while (i >= 0 && [array[i] integerValue] > tmp.integerValue) {
            array[i + 1] = array[i];
            i --;
        }
        array[i + 1] = tmp;
    }
    NSLog(@"");
}

- (void)bubbling {
    NSMutableArray *array = @[@"2", @"1", @"7", @"5", @"8", @"3"].mutableCopy;
    for (NSInteger i = 0; i < array.count; i ++) {
        for (NSInteger j = 0; j < array.count - 1 - i; j ++) {
            NSString *number1 = array[j];
            NSString *number2 = array[j+1];
            if (number1.integerValue > number2.integerValue) {
                [array exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    NSLog(@"");
}

- (void)quickSort {
    NSMutableArray *array = @[@"6", @"1", @"7", @"5", @"8", @"3", @"9"].mutableCopy;
    [self quickSortWithData:array left:0 right:array.count - 1];
}

- (void)quickSortWithData:(NSMutableArray <NSString *>*)datas left:(NSInteger)left right:(NSInteger)right {
    if (left > right) {
        return;
    }
    NSInteger i, j,temp;
    temp = [datas[left] integerValue];
    i = left;
    j = right;
    while (i != j) {
        while ([datas[j] integerValue] >= temp && i < j) {
            j --;
        }
        while ([datas[i] integerValue] <= temp && i < j) {
            i ++;
        }
        if (i < j) {
            NSString *t = datas[i];
            datas[i] = datas[j];
            datas[j] = t;
        }
    }
    datas[left] = datas[i];
    datas[i] = [NSString stringWithFormat:@"%@", @(temp)];
    [self quickSortWithData:datas left:left right:i - 1];
    [self quickSortWithData:datas left:i + 1 right:right];
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
