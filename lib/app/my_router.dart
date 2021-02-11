import 'package:aksestokomobile/screen/account/reward_screen.dart';
import 'package:aksestokomobile/screen/account/detail_reward_screen.dart';
import 'package:aksestokomobile/screen/account/summary_screen.dart';
import 'package:aksestokomobile/screen/customer_service/detail_issue_screen.dart';
import 'package:aksestokomobile/screen/home/home_screen.dart';
import 'package:aksestokomobile/screen/home/select_distributor.dart';
import 'package:aksestokomobile/screen/home/select_product.dart';
import 'package:aksestokomobile/screen/home/cart_screen.dart';
import 'package:aksestokomobile/screen/home/checkout_screen.dart';
import 'package:aksestokomobile/screen/home/success_screen.dart';
import 'package:aksestokomobile/screen/home/payment_screen.dart';
import 'package:aksestokomobile/screen/home/parent_screen.dart';
import 'package:aksestokomobile/screen/login/forgot_password_screen.dart';
import 'package:aksestokomobile/screen/login/login_screen.dart';
import 'package:aksestokomobile/screen/login/register_screen.dart';
import 'package:aksestokomobile/screen/login/otp_screen.dart';
import 'package:aksestokomobile/screen/order/add_payment_screen.dart';
import 'package:aksestokomobile/screen/order/payment_kreditpro.dart';
import 'package:aksestokomobile/screen/setting/check_permission_screen.dart';
import 'package:aksestokomobile/screen/customer_service/customer_service.dart';
import 'package:aksestokomobile/screen/splash_screen.dart';
import 'package:aksestokomobile/screen/order/history_order_screen.dart';
import 'package:aksestokomobile/screen/order/detail_order_screen.dart';
import 'package:aksestokomobile/screen/order/confirmation_acceptance_screen.dart';
import 'package:aksestokomobile/screen/order/detail_payment.dart';
import 'package:aksestokomobile/screen/account/update_profile_screen.dart';
import 'package:aksestokomobile/screen/account/list_address_screen.dart';
import 'package:aksestokomobile/screen/account/add_address_screen.dart';
import 'package:aksestokomobile/screen/account/edit_address_screen.dart';
import 'package:aksestokomobile/screen/account/sales_person_screen.dart';
import 'package:aksestokomobile/screen/account/change_password_screen.dart';
import 'package:aksestokomobile/screen/promo/detail_promo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const String root = "/";
const loginScreen = "/LoginScreen";
const parentScreen = "/ParentScreen";
const registerScreen = "/RegisterScreen";
const forgotPasswordScreen = "/ForgotPasswordScreen";
const homeScreen = "/HomeScreen";
const requestOtpScreen = "/RequestOtpScreen";
const selectDistributorScreen = "/SelectDistributorScreen";
const selectProductScreen = "/SelectProductScreen";
const cartScreen = "/CartScreen";
const checkoutScreen = "/CheckoutScreen";
const paymentScreen = "/PaymentScreen";
const successScreen = "/SuccessScreen";
const historyOrderScreen = "/HistoryOrderScreen";
const detailOrderScreen = "/DetailOrderScreen";
const detailPromo = "/DetailPromoScreen";
const confirmationAcceptScreen = "/ConfirmationAcceptScreen";
const detailPaymentScreen = "/DetailPaymentScreen";
const addPaymentScreen = "/AddPaymentScreen";
const updateProfileScreen = "/UpdateProfileScreen";
const listAddressScreen = "/ListAddressScreen";
const addAddressScreen = "/AddAddressScreen";
const editAddressScreen = "/EditAddressScreen";
const salesPersonScreen = "/SalesPersonScreen";
const changePasswordScreen = "/ChangePasswordScreen";
const paymentKreditProScreen = "/PaymentKreditproScreen";
const checkPermissionScreen = "/CheckPermissionScreen";
const customerService = "/CustomerService";
const detailIssueScreen = "/DetailIssueScreen";
const rewardScreen = "/RewardScreen";
const detailRewardScreen = "/DetailRewardScreen";
const summaryScreen = "/SummaryScreen";

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return GetRouteBase(
          page: SplashScreen(),
          settings: settings,
        );
      case parentScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.fade,
          page: ParentScreen(),
        );
      case paymentKreditProScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.fade,
          page: PaymentKreditproScreen(),
        );
      case checkPermissionScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.fade,
          page: CheckPermissionScreen(),
        );
      case addPaymentScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.fade,
          page: AddPaymentScreen(),
        );
      case successScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.fade,
          page: SuccessScreen(),
        );
      case paymentScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.fade,
          page: PaymentScreen(),
        );
      case checkoutScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.fade,
          page: CheckoutScreen(),
        );
      case confirmationAcceptScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.fade,
          page: ConfirmationAcceptScreen(),
        );
      case cartScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.fade,
          page: CartScreen(),
        );
      case selectProductScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.fade,
          page: SelectProductScreen(),
        );
      case loginScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.fade,
          page: LoginScreen(),
        );
      case selectDistributorScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.fade,
          page: SelectDistributorScreen(),
        );
      case registerScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: RegisterScreen(),
        );
      case forgotPasswordScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: ForgotPasswordScreen(),
        );
      case requestOtpScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: RequestOtpScreen(),
        );
      case homeScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: HomeScreen(),
        );
      case historyOrderScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.fade,
          page: HistoryOrderScreen(),
        );
      case detailOrderScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.fade,
          page: DetailOrderScreen(),
        );
      case detailPromo:
        return GetRouteBase(
          settings: settings,
          transition: Transition.fade,
          page: DetailPromoScreen(),
        );
      case detailPaymentScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.fade,
          page: DetailPaymentScreen(),
        );
      case updateProfileScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.fade,
          page: UpdateProfileScreen(),
        );
      case listAddressScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.fade,
          page: ListAddressScreen(),
        );
      case addAddressScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.fade,
          page: AddAddressScreen(),
        );
      case editAddressScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.fade,
          page: EditAddressScreen(),
        );
      case salesPersonScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.fade,
          page: SalesPersonScreen(),
        );
      case changePasswordScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.fade,
          page: ChangePasswordScreen(),
        );
      case rewardScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.fade,
          page: RewardScreen(),
        );
      case summaryScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.fade,
          page: SummaryScreen(),
        );
      case detailIssueScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.fade,
          page: DetailIssueScreen(),
        );
        case customerService:
          return GetRouteBase(
          settings: settings,
          transition: Transition.fade,
          page: CustomerServiceScreen(),
        );
      case detailRewardScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.fade,
          page: DetailRewardScreen(),
        );
      default:
        return GetRouteBase(
            settings: settings,
            transition: Transition.fade,
            page: Scaffold(
              body:
                  Center(child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}