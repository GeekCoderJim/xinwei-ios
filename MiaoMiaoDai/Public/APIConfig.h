

#import <Foundation/Foundation.h>
/***************SERVER HOST***************/

//服务器地址
//#define SERVER_HOST @"app.qzxwmy.com:8080/xinwei-server"
//测试服务器地址
#define SERVER_HOST @"94.191.12.44:8080/xinwei-server"
////内部测试
//#define SERVER_HOST @"wzpym.natapp1.cc"
@interface APIConfig : NSObject

// >>>>>>>>>>>>>>>>>>>>>公共>>>>>>>>>>>>>>>>>>>>>>>>


#define API_GET_UPDATE_INFO @"/app/update/info/ios"

#define API_UPLOAD_ONE_IMAGE @"/api/file/base64SavePic"

#define API_UPLOAD_MANY_IMAGE @"/api/file/picListSave"

#define API_GET_QUICKPAY_WEB @"/app/v2/user/yikunpay_url/"

#define API_GET_JT_WEB @"/app/iouEntry/"

// >>>>>>>>>>>>>>>>>>>>>登录注册>>>>>>>>>>>>>>>>>>>>>>>>
#define API_REGIST @"/user/register/"

#define API_LOGIN @"/app/v2/user/login"
//获取分公司列表
#define API_GetCompany @"/app/v2/user/getRegUserList"

#define API_LOGIN_CODE @"/api/userLogin/doCodeLogin"
//退出登录
#define LOGOUT_URL   @"/user/logOut/"
//重置登录密码
#define RESET_PWD_URL  @"/user/updatePwd/"
//重置交易密码
#define RESET_SPWD_URL  @"/user/reset_trade_pwd/"
//上传运营商信息
#define UPLOAD_PHONE_INFO  @"/user/phoneInfo/"
//上传通讯录信息
#define UPLOAD_CONTACT_INFO  @"/user/contactInfo/"
//上传通话记录
#define UPLOAD_CALL_LOG  @"/user/callLog/"
//获取用户认证状态
#define VERIFY_STATUS  @"/user/verifyStatus/"
//上传用户基本信息
#define SUBMIT_USER_INFO  @"/user/baseInfo/"
//上传用户紧急联系人
#define SUBMIT_USER_CONTACT  @"/user/contact/"
//获取紧急联系人信息
#define GET_CONTACT_INFO  @"/user/getContactInfo/"
//获取用户基本信息
#define GET_USER_INFO  @"/user/getBaseInfo/"
//上传银行卡信息
#define SUBMIT_BANK_INFO  @"/bankCard/add/"
//获取银行卡信息
#define GET_BANKCARD_LIST  @"/bankCard/list/"
//解绑银行卡信息
#define UNBIND_BANK_INFO  @"/bankCard/delete/"
//上传身份信息
#define SUBMIT_ID_INFO  @"/identity/add/"
//上传真实头像
#define UPLOAD_IMG_URL  @"/attachment/upload/"
//获取用户头像和身份证图片
#define GET_ID_IMAGE  @"/attachment/getIdCard/"

#define GET_SFRZ_IMAGE @""
//获取借款利息数据
#define BORROW_OWE  @"/debtHistory/loanInfo/"
//提交借款信息
#define SUBMIT_LOAN_INFO  @"/debtHistory/add/"
//获取用户额度
#define USER_LOAN_LINES  @"/debtHistory/lines/"
//获取账单列表
#define GET_BILL_LIST  @"/debtHistory/list/"
//获取待还款列表
#define GET_OWE_LIST  @"/debtHistory/oweList/"
//获取借款详情
#define GET_LOAN_DETAIL  @"/debtHistory/get/"
//取消借款申请
#define CANCEL_LOAN  @"/debtHistory/cancel/"
//延迟还款信息
#define GET_DELAY_INFO  @"/debtHistory/delayInfo/"
//获取银行卡签约信息
#define GET_CARD_SIGN  @"/lianpay/getBankCardSignData/"
//验证手机第一步
#define PHONE_RZ @"/app/hailiang/up_info/"
//验证手机第二步
#define PHONE_RZ_SECOND @"/app/hailiang/up_code/"
//还款申请
#define REPAY_URL  @"/lianpay/getRepaymentData2/"
//延期还款服务费 支付参数
#define DELAY_REPAY_URL  @"/lianpay/getDelayRepaymentData2/"
//消息列表
#define MESSAGE_LIST  @"/notice/list/"

#define GET_SHARE_INFO @"/app/share/getShareRegistData/"

#define REGIST_AGREE  @"/app/contract/registAgree"
#define ZHENGXIN  @"/app/contract/ZhengXin"
#define CONTACT_CONTRACT  @"/app/contract/ContactContract"
#define CONTACT_COLLECT  @"/app/contract/ContactCollect"
#define LOAN_CONTRACT  @"/app/contract/LoanContract/"

//探知数据api
#define TANZHI_API_URL  @"http://api.tanzhishuju.com/api/gateway"



// >>>>>>>>>>>>>>>>>>>>>2018-06-11 新增接口>>>>>>>>>>>>>>>>>>>>>>>>
//提交银行卡认证信息
#define API_uploadPersonInfo @"/app/v2/user/uploadPersonInfo/"
//上传照片URL接口
#define API_uploadPhotoInfo @"/app/v2/user/uploadPhotoInfo/"
//获取银行卡认证信息
#define API_personInfo @"/app/v2/user/personInfo/"
//获取省份和城市列表和银行类型
#define API_getAreaAndCityAndBankType @"/app/v2/user/getAreaAndCityAndBankType"
//获取分行列表
#define API_getBankListByCity @"/app/v2/user/getBankListByCityAndBankType"
//新的上传图片接口
#define API_UPLOAD_PHOTO_NEW @"/app/v2/file/upload/"
//上传位置、设备信息
#define API_UPLOAD_LOCATION_DEVICE_INFO @"/location/add/"
//手机认证 重新发送短信
#define API_RESEND_MSG @"/app/hailiang/resendVerifyCode/"
//SDK认证成功状态修改
#define API_ChangeVerifyStatus @"/app/bqs/changeVerifyStatus/"

#define API_WXPay @"/app/wxpay/createOrder/"

#define API_AliPay @"/app/alipay/createOrder/"

//阿里实人认证获取token
#define API_RPGetToeken @"/aliRp/rpToken"
//阿里实人认证Api
#define API_SaveRpResult @"/aliRp/rpStatus/"

//请求成功
#define SUCCESS @"200"
//请求失败
#define FAIL @"5008"
//请求参数错误
#define ERROR_PARAM @"5005"
//查不到记录
#define RECORD_NO_EXIST @"5003"
//密码相同
#define SAME_PWD @"5014"
//手机号已被注册
#define USER_REGISTED @"5013"
//密码错误
#define ERROR_PWD @"5015"
//用户未注册
#define USER_NO_REGISTED @"5016"
//用户未登录
#define NO_LOGIN @"5010"
//身份证已被绑定
#define ID_BOUNDED @"5031"
//额度不足
#define LINES_LACK @"5021"
//无法解绑银行卡
#define UNBIND_FAIL @"5033"
//token校验失败
#define TOKEN_ERROR @"5035"
//无法取消申请
#define CANONT_CANCEL @"5036"
//银行卡数量限制
#define BANK_LIMIT @"5037"
//无法再申请
#define UNABLE_APPLAY @"5045"
//应用版本错误
#define ERROR_VERSION @"5039"





@end
