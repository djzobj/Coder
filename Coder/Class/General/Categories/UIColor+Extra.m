//
//  UIColor+Extra.m
//  gjj51
//
//  Created by 魏裕群 on 15/8/2.
//  Copyright (c) 2015年 jianbing. All rights reserved.
//

#import "UIColor+Extra.h"
#define CHECK_CLR(x) if(x==NSNotFound)break

static NSMutableDictionary *sm_colors;

@implementation UIColor(Extra)

+(UIColor*)miss_colorWithRGB:(NSString*)string{
    if (!string || ![string isKindOfClass:[NSString class]]) {
        return nil;
    }
    string = [string uppercaseString];
    if (sm_colors) {
        id col = [sm_colors objectForKey:string];
        if (col) {
            return col;
        }
    }else{
        sm_colors = [NSMutableDictionary dictionaryWithCapacity:20];
    }
    do{
        static NSString*cs=@"0123456789ABCDEF";
        if (string.length==4&&[string characterAtIndex:0]=='#') {
            NSInteger r = [cs rangeOfString:[string substringWithRange:NSMakeRange(1, 1)]].location;
            CHECK_CLR(r);
            NSInteger g = [cs rangeOfString:[string substringWithRange:NSMakeRange(2, 1)]].location;
            CHECK_CLR(g);
            NSInteger b = [cs rangeOfString:[string substringWithRange:NSMakeRange(3, 1)]].location;
            CHECK_CLR(b);
            UIColor *col = [UIColor colorWithRed:(float)r/15.0f green:(float)g/15.0f blue:(float)b/15.0f alpha:1];
            [sm_colors setObject:col forKey:string];
            return col;
        }else if (string.length==7&&[string characterAtIndex:0]=='#') {
            NSInteger tmp = [cs rangeOfString:[string substringWithRange:NSMakeRange(1, 1)]].location;
            CHECK_CLR(tmp);
            NSInteger r = [cs rangeOfString:[string substringWithRange:NSMakeRange(2, 1)]].location;
            CHECK_CLR(r);
            r+=16*tmp;
            tmp = [cs rangeOfString:[string substringWithRange:NSMakeRange(3, 1)]].location;
            CHECK_CLR(tmp);
            NSInteger g = [cs rangeOfString:[string substringWithRange:NSMakeRange(4, 1)]].location;
            CHECK_CLR(g);
            g+=16*tmp;
            tmp = [cs rangeOfString:[string substringWithRange:NSMakeRange(5, 1)]].location;
            CHECK_CLR(tmp);
            NSInteger b = [cs rangeOfString:[string substringWithRange:NSMakeRange(6, 1)]].location;
            CHECK_CLR(b);
            b+=16*tmp;
            UIColor *col = [UIColor colorWithRed:(CGFloat)r/255.0f green:(CGFloat)g/255.0f blue:(CGFloat)b/255.0f alpha:1];
            [sm_colors setObject:col forKey:string];
            return col;
        }
    }while (false);
    return nil;
}

/**
 darkGray

 @return #333333
 */
+(UIColor*)darkGray {
    return [UIColor miss_colorWithRGB:@"#263038"];
}

/**
 strongGray

 @return #868686
 */
+(UIColor*)strongGray {
    return [UIColor miss_colorWithRGB:@"#868686"];
}

/**
 mediGray

 @return #a6a6a6
 */
+(UIColor*)mediGray {
    return [UIColor miss_colorWithRGB:@"#a6a6a6"];
}

/**
 regularGray

 @return #b9b9b9
 */
+(UIColor*)regularGray  {
    return [UIColor miss_colorWithRGB:@"#b9b9b9"];
}

/**
 normGray
 分割线
 @return #eeeeee
 */
+(UIColor*)normGray {
    return [UIColor miss_colorWithRGB:@"#eeeeee"];
}

/**
 lightGray
 背景
 @return #f5f5f5
 */
+(UIColor*)lightGray  {
    return [UIColor miss_colorWithRGB:@"#f5f5f5"];
}

/**
 exLightGray

 @return #f6f6f6
 */
+(UIColor*)exLightGray {
    return [UIColor miss_colorWithRGB:@"#f6f6f6"];
}

/**
 skyBlue

 @return #4678e7，Pro:#435c94
 */
+(UIColor*)skyBlue  {
    
    return [UIColor miss_colorWithRGB:@"#4678e7"];
}

/**
 orange

 @return #ff7800，Pro:#ee6539
 */
+(UIColor*)orange {
    
    return [UIColor miss_colorWithRGB:@"#ff7800"];
}

/**
 yellow

 @return #fcb200
 */
+(UIColor*)yellow {
    return [UIColor miss_colorWithRGB:@"#fcb200"];
}

/**
 darkBlue

 @return #263038
 */
+(UIColor*)darkBlue {
    return [UIColor miss_colorWithRGB:@"#263038"];
}

/**
 lightBlue

 @return #40beee
 */
+(UIColor*)lightBlue {
    return [UIColor miss_colorWithRGB:@"#40beee"];
}

/**
 treeGreen

 @return #29c675
 */
+(UIColor*)treeGreen {
    return [UIColor miss_colorWithRGB:@"#29c675"];
}

/**
 shadowGray

 @return #dcdcdc
 */
+(UIColor*)shadowGray {
    return [UIColor miss_colorWithRGB:@"#dcdcdc"];
}

/**
 red

 @return #ff6666
 */
+(UIColor*)red{
    return [UIColor miss_colorWithRGB:@"#ff6666"];
}


/**
 dullGray

 @return #666666
 */
+(UIColor*)dullGray{
    return [UIColor miss_colorWithRGB:@"#666666"];
}

/**
 gay4
 
 @return #3333333
 */
+(UIColor*)gray3{
    return [UIColor miss_colorWithRGB:@"#333333"];
}


/**
 gay4
 
 @return #444444
 */
+(UIColor*)gray4{
    return [UIColor miss_colorWithRGB:@"#444444"];
}

/**
 gay5
 
 @return #5555555
 */
+(UIColor*)gray5{
    return [UIColor miss_colorWithRGB:@"#555555"];
}

/**
 gay6
 
 @return #666666
 */
+(UIColor*)gray6{
    return [UIColor miss_colorWithRGB:@"#666666"];
}

/**
 gay9
 
 @return #999999
 */
+(UIColor*)gray9{
    return [UIColor miss_colorWithRGB:@"#999999"];
}

/**
 disabledGray

 @return #bccoca
 */
+(UIColor *)disabledGray {
    return [UIColor miss_colorWithRGB:@"#bcc0ca"];
}

@end
