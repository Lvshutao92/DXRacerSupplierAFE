//
//  Manager.m
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/10/13.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "Manager.h"
#import <sys/utsname.h>
static Manager *manager = nil;

@implementation Manager
+ (Manager *)sharedManager {
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[Manager alloc] init];
    });
    return manager;
}

- (NSMutableArray *)totalarr {
    if (_totalarr == nil) {
        self.totalarr = [NSMutableArray arrayWithCapacity:1];
    }
    return _totalarr;
}

- (NSMutableArray *)yijiarr {
    if (_yijiarr == nil) {
        self.yijiarr = [NSMutableArray arrayWithCapacity:1];
    }
    return _yijiarr;
}
- (NSMutableArray *)yijiimgarr {
    if (_yijiimgarr == nil) {
        self.yijiimgarr = [NSMutableArray arrayWithCapacity:1];
    }
    return _yijiimgarr;
}

- (NSMutableArray *)Array1 {
    if (_Array1 == nil) {
        self.Array1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _Array1;
}






//MD5加密
- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:
            
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            
            result[0], result[1], result[2], result[3],
            
            result[4], result[5], result[6], result[7],
            
            result[8], result[9], result[10], result[11],
            
            result[12], result[13], result[14], result[15]
            
            ];
}
//base加解密
+ (NSString*)encodeBase64String:(NSString* )input {
    NSData*data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 encodeData:data];
    NSString*base64String = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding] ;
    return base64String;
}
+ (NSString*)decodeBase64String:(NSString* )input {
    NSData*data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 decodeData:data];
    NSString*base64String = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding] ;
    return base64String;
}
+ (NSString*)encodeBase64Data:(NSData*)data {
    data = [GTMBase64 encodeData:data];
    NSString*base64String = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding] ;
    return base64String;
}
+ (NSString*)decodeBase64Data:(NSData*)data {
    data = [GTMBase64 decodeData:data];
    NSString*base64String = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding] ;
    return base64String;
}
//字典转json字符串
-(NSString *)convertToJsonData:(NSDictionary *)dict{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}
//金额转大写
+(NSString *)digitUppercase:(NSString *)numstr{
    double numberals=[numstr doubleValue];
    NSArray *numberchar = @[@"零",@"壹",@"贰",@"叁",@"肆",@"伍",@"陆",@"柒",@"捌",@"玖"];
    NSArray *inunitchar = @[@"",@"拾",@"佰",@"仟"];
    NSArray *unitname = @[@"",@"万",@"亿",@"万亿"];
    //金额乘以100转换成字符串（去除圆角分数值）
    NSString *valstr=[NSString stringWithFormat:@"%.2f",numberals];
    NSString *prefix;
    NSString *suffix;
    if (valstr.length<=2) {
        prefix=@"零元";
        if (valstr.length==0) {
            suffix=@"零角零分";
        }
        else if (valstr.length==1)
        {
            suffix=[NSString stringWithFormat:@"%@分",[numberchar objectAtIndex:[valstr intValue]]];
        }
        else
        {
            NSString *head=[valstr substringToIndex:1];
            NSString *foot=[valstr substringFromIndex:1];
            suffix = [NSString stringWithFormat:@"%@角%@分",[numberchar objectAtIndex:[head intValue]],[numberchar  objectAtIndex:[foot intValue]]];
        }
    }
    else
    {
        prefix=@"";
        suffix=@"";
        NSInteger flag = valstr.length - 2;
        NSString *head=[valstr substringToIndex:flag - 1];
        NSString *foot=[valstr substringFromIndex:flag];
        if (head.length>13) {
            return@"数值太大（最大支持13位整数），无法处理";
        }
        //处理整数部分
        NSMutableArray *ch=[[NSMutableArray alloc]init];
        for (int i = 0; i < head.length; i++) {
            NSString * str=[NSString stringWithFormat:@"%x",[head characterAtIndex:i]-'0'];
            [ch addObject:str];
        }
        int zeronum=0;
        
        for (int i=0; i<ch.count; i++) {
            int index=(ch.count -i-1)%4;//取段内位置
            NSInteger indexloc=(ch.count -i-1)/4;//取段位置
            if ([[ch objectAtIndex:i]isEqualToString:@"0"]) {
                zeronum++;
            }
            else
            {
                if (zeronum!=0) {
                    if (index!=3) {
                        prefix=[prefix stringByAppendingString:@"零"];
                    }
                    zeronum=0;
                }
                prefix=[prefix stringByAppendingString:[numberchar objectAtIndex:[[ch objectAtIndex:i]intValue]]];
                prefix=[prefix stringByAppendingString:[inunitchar objectAtIndex:index]];
            }
            if (index ==0 && zeronum<4) {
                prefix=[prefix stringByAppendingString:[unitname objectAtIndex:indexloc]];
            }
        }
        prefix =[prefix stringByAppendingString:@"元"];
        //处理小数位
        if ([foot isEqualToString:@"00"]) {
            suffix =[suffix stringByAppendingString:@"整"];
        }
        else if ([foot hasPrefix:@"0"])
        {
            NSString *footch=[NSString stringWithFormat:@"%x",[foot characterAtIndex:1]-'0'];
            suffix=[NSString stringWithFormat:@"%@分",[numberchar objectAtIndex:[footch intValue] ]];
        }
        else
        {
            NSString *headch=[NSString stringWithFormat:@"%x",[foot characterAtIndex:0]-'0'];
            NSString *footch=[NSString stringWithFormat:@"%x",[foot characterAtIndex:1]-'0'];
            suffix=[NSString stringWithFormat:@"%@角%@分",[numberchar objectAtIndex:[headch intValue]],[numberchar  objectAtIndex:[footch intValue]]];
        }
    }
    return [prefix stringByAppendingString:suffix];
}
//存取读取数据
+ (void)writewenjianming:(NSString *)wenjianming content:(NSString *)content {
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *path = [documents stringByAppendingPathComponent:wenjianming];
    NSString *str = content;
    [str writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}
+ (NSString *)redingwenjianming:(NSString *)wenjianming {
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *path = [documents stringByAppendingPathComponent:wenjianming];
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return str;
}
//金额格式转换
+ (NSString *)jinegeshi:(NSString *)text {
    if(!text || [text floatValue] == 0){
        return @"¥0.0000";
    }
    if (text.floatValue < 1000) {
        return  [NSString stringWithFormat:@"¥%.04f",text.floatValue];
    };
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@",###.0000;"];
    
    
    return [NSString stringWithFormat:@"¥%@",[numberFormatter stringFromNumber:[NSNumber numberWithDouble:[text doubleValue]]]];
}
//金额格式转换
+ (NSString *)jinegeshiLiangWei:(NSString *)text {
    if(!text || [text floatValue] == 0){
        return @"¥0.00";
    }
    if (text.floatValue < 1000) {
        return  [NSString stringWithFormat:@"¥%.02f",text.floatValue];
    };
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@",###.00;"];
    
    
    return [NSString stringWithFormat:@"¥%@",[numberFormatter stringFromNumber:[NSNumber numberWithDouble:[text doubleValue]]]];
}




//金额格式转换
+ (NSString *)usdjinegeshi:(NSString *)text {
    if(!text || [text floatValue] == 0){
        return @"$0.0000";
    }
    if (text.floatValue < 1000) {
        return  [NSString stringWithFormat:@"$%.4f",text.floatValue];
    };
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@",###.0000;"];
    return [NSString stringWithFormat:@"$%@",[numberFormatter stringFromNumber:[NSNumber numberWithDouble:[text doubleValue]]]];
}
//时间格式转换
+ (NSString *)timezhuanhuan:(NSString *)str {
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    fmt.dateFormat = @"MMM dd,yyyy HH:mm:ss aa";
    NSDate *createDate = [fmt dateFromString:str];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString * times = [fmt stringFromDate:createDate];
    
    return times;
}

//时间戳转时间
+ (NSString *)TimeCuoToTime:(NSString *)str{
    
    long long time=[str longLongValue] / 1000;
    //    如果服务器返回的是13位字符串，需要除以1000，否则显示不正确(13位其实代表的是毫秒，需要除以1000)
    //    long long time=[timeStr longLongValue] / 1000;
    
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString*timeString=[formatter stringFromDate:date];
    
    return timeString;
    
    
    
    //    NSTimeInterval time =[str doubleValue];
    //    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //    //实例化一个NSDateFormatter对象
    //    NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
    //    //设定时间格式,这里可以设置成自己需要的格式
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //    NSString*currentDateStr = [dateFormatter stringFromDate:detaildate];
    //    return currentDateStr;
}
+ (NSString *)TimeCuoToTimes:(NSString *)str{
    long long time=[str longLongValue] / 1000;
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString*timeString=[formatter stringFromDate:date];
    return timeString;
}







//网络请求
+ (AFHTTPSessionManager *)returnsession{
    
    //https处理
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"dms.dxracer.com.cn" ofType:@".cer"];
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    NSSet *cerSet = [NSSet setWithObjects:cerData, nil];
    //适配https
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = YES;
    [securityPolicy setPinnedCertificates:cerSet];
    
    
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.requestSerializer  = [AFJSONRequestSerializer serializer];
    
    //参数格式处理
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];
    
    
    //网络处理LoginViewController
    
    
    // 设置超时时间
    [session.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    session.requestSerializer.timeoutInterval = 60.f;
    [session.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    return session;
}
+ (NSDictionary *)returndiction:(NSDictionary *)dic {
    NSString *str = [[Manager sharedManager] convertToJsonData:dic];
    NSString *jsonStr = [Manager encodeBase64String:str];
    NSString *tokenStr = [[Manager sharedManager] md5:[NSString stringWithFormat:@"%@%@",str,CHECKWORD]];
    NSDictionary *para = [[NSDictionary alloc]init];
    para = @{@"token":tokenStr,@"json":jsonStr};
    //    NSLog(@"传入的参数===%@",dic);
    return para;
}
+ (NSDictionary *)returndictiondata:(NSData *)responseObject {
    NSString *base64Decoded = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    NSData *madata = [[NSData alloc] initWithData:[base64Decoded dataUsingEncoding:NSUTF8StringEncoding ]] ;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:madata options:NSJSONReadingAllowFragments error:nil];
    //    NSLog(@"请求返回数据===%@",dic);
    return dic;
}

+ (UIButton *)returnButton{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 30, 30);
    [btn setImage:[UIImage imageNamed:@"Back-2"] forState:UIControlStateNormal];
    
    
    
    
    
    
    return btn;
}

+ (CGFloat )returnTiJi:(NSString *)longstr width:(NSString *)widthstr height:(NSString *)heightstr{
    CGFloat a1 = [longstr floatValue];
    CGFloat a2 = [widthstr floatValue];
    CGFloat a3 = [heightstr floatValue];
    return a1*a2*a3*0.000001;
}



//计算两个日期之间的天数
+ (NSInteger)calcDaysFromBegin:(NSDate *)beginDate end:(NSDate *)endDate
{
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //取两个日期对象的时间间隔：
    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
    NSTimeInterval time=[endDate timeIntervalSinceDate:beginDate];
    
    int days=((int)time)/(3600*24);
    //int hours=((int)time)%(3600*24)/3600;
    //NSString *dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时",days,hours];
    return days;
}


//延时
//dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30.0/*延迟执行时间*/ * NSEC_PER_SEC));
//dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//});


//- (void)lod{
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
//    AFHTTPSessionManager *session = [Manager returnsession];
//    __weak typeof(self) weakSelf = self;
//    NSDictionary *dic = [[NSDictionary alloc]init];
//    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],};
//    [session POST:KURLNSString(@"user", @"login") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *dic = [Manager returndictiondata:responseObject];
//
//
//
//        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
//            NSDictionary *diction = [[dic objectForKey:@"rows"] objectForKey:@"user"];
//
//        }else {
//            [[Manager sharedManager] tishiyu:@"登录失败！请检查登录信息是否正确" controller:weakSelf];
//        }
//
//        [hud hideAnimated:YES];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [[Manager sharedManager] tishi:error controller:weakSelf];
//        [hud hideAnimated:YES];
//    }];
//}
//

//获取设备当前网络IP地址
- (NSString *)getIPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4 ?
    @[ /*IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6,*/ IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ]:
    @[ /*IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4,*/ IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    //    NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}
//获取所有相关IP信息
- (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}


- (NSString*)iphoneType {
    
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString*platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone1,1"])
        return@"iPhone 2G";
    
    if([platform isEqualToString:@"iPhone1,2"])
        return@"iPhone 3G";
    
    if([platform isEqualToString:@"iPhone2,1"])
        return@"iPhone 3GS";
    
    if([platform isEqualToString:@"iPhone3,1"])
        return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,2"])
        return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,3"])
        return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone4,1"])
        return@"iPhone 4S";
    
    if([platform isEqualToString:@"iPhone5,1"])
        return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,2"])
        return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,3"])
        return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone5,4"])
        return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone6,1"])
        return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone6,2"])
        return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone7,1"])
        return@"iPhone 6 Plus";
    
    if([platform isEqualToString:@"iPhone7,2"])
        return@"iPhone 6";
    
    if([platform isEqualToString:@"iPhone8,1"])
        return@"iPhone 6s";
    
    if([platform isEqualToString:@"iPhone8,2"])
        return@"iPhone 6s Plus";
    
    if([platform isEqualToString:@"iPhone8,4"])
        return@"iPhone SE";
    
    if([platform isEqualToString:@"iPhone9,1"])
        return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,2"])
        return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone10,1"])
        return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,4"])
        return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,2"])
        return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,5"])
        return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,3"])
        return@"iPhone X";
    
    if([platform isEqualToString:@"iPhone10,6"])
        return@"iPhone X";
    
    if([platform isEqualToString:@"iPod1,1"])
        return@"iPod Touch 1G";
    
    if([platform isEqualToString:@"iPod2,1"])
        return@"iPod Touch 2G";
    
    if([platform isEqualToString:@"iPod3,1"])
        return@"iPod Touch 3G";
    
    if([platform isEqualToString:@"iPod4,1"])
        return@"iPod Touch 4G";
    
    if([platform isEqualToString:@"iPod5,1"])
        return@"iPod Touch 5G";
    
    if([platform isEqualToString:@"iPad1,1"])
        return@"iPad 1G";
    
    if([platform isEqualToString:@"iPad2,1"])
        return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,2"])
        return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,3"])
        return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,4"])
        return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,5"])
        return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,6"])
         return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,7"])
        return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad3,1"])
         return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,2"])
         return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,3"])
         return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,4"])
         return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,5"])
        return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,6"])
         return@"iPad 4";
    
    if([platform isEqualToString:@"iPad4,1"])
         return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,2"])
         return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,3"])
        return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,4"])
        return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,5"])
         return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,6"])
        return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,7"])
         return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,8"])
         return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,9"])
        return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad5,1"])
        return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,2"])
        return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,3"])
        return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad5,4"])
        return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad6,3"])
        return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,4"])
        return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,7"])
        return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"iPad6,8"])
         return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"i386"])
        return@"iPhone Simulator";
    
    if([platform isEqualToString:@"x86_64"])
        return@"iPhone Simulator";
    
    return platform;
    
}

@end

