//
//  DJZArithmeticController.m
//  Coder
//
//  Created by 张得军 on 2019/9/29.
//  Copyright © 2019 张得军. All rights reserved.
//

#import "DJZArithmeticController.h"

/**  定义一个链表  */
struct Node {
    
    NSInteger data;
    
    struct Node * next;
};

@protocol DJZArithmeticControllerDeleagte <NSObject>

@property (nonatomic, assign) NSInteger index;

@end

@interface DJZArithmeticController ()<DJZArithmeticControllerDeleagte>

@end

#define WeakObject(obj) __weak typeof(obj) weak_##obj = obj;

@implementation DJZArithmeticController

@synthesize index;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSObject *a = [NSObject new];
    WeakObject(a);
    NSLog(@"-----%@", weak_a);
    
    [self insertSortArray];
    
}

char *stringCode(char *inputCode) {
    int length = (int)strlen(inputCode);
    int size = 50;
    char *stack = (char *)malloc(sizeof(char) * size);
    int top = -1;
    for (int i = 0; i < length; i ++) {
        char temp = inputCode[i];
        if (temp != ']') {
            if (top == size - 1) {
                stack = realloc(stack, (size += 50) * sizeof(char));
            }
            stack[++top] = inputCode[i];
        }else{
            int tempSize = 10;
            int tempTop = -1;
            char *tempCode = (char *)malloc(sizeof(char) * tempSize);
            while (stack[top] != '[') {
                if (tempTop == tempSize - 1) {
                    tempCode = realloc(tempCode, (tempSize + 10) * sizeof(char));
                }
                tempTop ++;
                tempCode[tempTop] = stack[top];
                top --;
            }
            char strInt[11];
            int curTop = top;
            top --;
            while (top != -1 && stack[top] >= '0' && stack[top] <= '9') {
                top --;
            }
            for (int j = top + 1; j < curTop; j ++) {
                strInt[j - (top + 1)] = stack[j];
            }
            strInt[curTop] = '\0';
            int curNum = atoi(strInt);
            for (int k = 0; k < curNum; k ++) {
                int kk = tempTop;
                while (kk != -1) {
                    if (top == size - 1) {
                        stack = realloc(stack, (size + 50) * sizeof(char));
                    }
                    top ++;
                    stack[top] = tempCode[kk];
                    kk --;
                }
            }
            free(tempCode);
            tempCode = NULL;
        }
    }
    return stack;
}

char findFirstChar(char *cha) {
    char result = '\0';
    int array[256];
    for (int i = 0; i < 256; i ++) {
        array[i] = 0;
    }
    char *p = cha;
    //遍历每个字符，对出现的位置+1
    while (*p != '\0') {
        array[*(p++)]++;
    }
    
    p = cha;
    while (*p != '\0') {
        if (array[*p] == 1) {
            result = *p;
            break;
        }
        p++;
    }
    return result;
}

void char_reserve(char *cha) {
    char *begin = cha;
    char *end = cha + strlen(cha) - 1;
    while (begin < end) {
        char temp = *begin;
        *(begin ++) = *end;
        *(end --) = temp;
    }
}

- (void)orderListMerge
{
    int aLen = 5,bLen = 9;
    
    int a[] = {1,4,6,7,9};
    
    int b[] = {2,3,5,6,8,9,10,11,12};
    
    [self printList:a length:aLen];
    
    [self printList:b length:bLen];
    
    int result[14];
    
    int p = 0,q = 0,i = 0;//p和q分别为a和b的下标，i为合并结果数组的下标
    
    //任一数组没有达到s边界则进行遍历
    while (p < aLen && q < bLen) {
        
        //如果a数组对应位置的值小于b数组对应位置的值,则存储a数组的值，并移动a数组的下标与合并结果数组的下标
        if (a[p] < b[q]) result[i++] = a[p++];
        
        //否则存储b数组的值，并移动b数组的下标与合并结果数组的下标
        else result[i++] = b[q++];
    }
    //如果a数组有剩余，将a数组剩余部分拼接到合并结果数组的后面
        while (++p < aLen) {
            
            result[i++] = a[p];
        }
        
        //如果b数组有剩余，将b数组剩余部分拼接到合并结果数组的后面
        while (q < bLen) {
            
            result[i++] = b[q++];
        }
        
        [self printList:result length:aLen + bLen];
}

- (void)printList:(int [])list length:(int)length
{
    for (int i = 0; i < length; i++) {
        
        printf("%d ",list[i]);
    }
    
    printf("\n");
}

- (void)listReverse
{
    struct Node * p = [self constructList];
    
    [self printList:p];
    
    //反转后的链表头部
    struct Node * newH = NULL;
    //头插法
    while (p != NULL) {
        
        //记录下一个结点
        struct Node * temp = p->next;
        //当前结点的next指向新链表的头部
        p->next = newH;
        //更改新链表头部为当前结点
        newH = p;
        //移动p到下一个结点
        p = temp;
    }
    
    [self printList:newH];
}

- (void)printList:(struct Node *)head
{
    struct Node * temp = head;
    
    printf("list is : ");
    
    while (temp != NULL) {
        
        printf("%zd ",temp->data);
        
        temp = temp->next;
    }
    
    printf("\n");
}

- (struct Node *)constructList
{
    //头结点
    struct Node *head = NULL;
    //尾结点
    struct Node *cur = NULL;
    
    for (NSInteger i = 0; i < 10; i++) {
        
        struct Node *node = malloc(sizeof(struct Node));
        
        node->data = i;
        
        //头结点为空，新结点即为头结点
        if (head == NULL) {
            
            head = node;
            
        }else{
            //当前结点的next为尾结点
            cur->next = node;
        }
        
        //设置当前结点为新结点
        cur = node;
    }
    if (cur) {
        cur->next = NULL;
    }
    return head;
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
