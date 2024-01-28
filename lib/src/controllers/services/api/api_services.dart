import 'package:easy_do/src/controllers/services/api/http_call.dart';
import 'package:easy_do/src/models/response_models/user_response_model.dart';

import 'package:http/http.dart' as http;

class ApiServices {
  late final HttpCall _httpCall;
  ApiServices() : _httpCall = HttpCall();

  // //! ---------------------------------------------------------------------------------------------- Login
  Future<UserResponseModel?> login(String email, String password, {Map<String, dynamic>? map}) async {
    String httpLink = map == null ? "user/login" : "user/register";

    Map<String, dynamic> sendData = {
      "email": email,
      "password": password
    };

    if (map != null) sendData.addAll(map);

    http.Response res = await _httpCall.post(httpLink, isAuthServer: true, body: sendData);

    if (map == null && res.statusCode != 200) throw res;
    if (map != null && res.statusCode != 201) throw res;
    return UserResponseModel.fromJson(res.body);
  }

  // Future<void> emailConfirmationResendOTP({required String email, required String code, required bool resend}) async {
  //   String httpLink = resend ? "SendOtp?userName=$email" : "EmailConfirmation";

  //   http.Response res = await _httpCall.post(
  //     httpLink,
  //     isAuthServer: true,
  //     additionalHeaderParameter: _headerParameter,
  //     body: resend
  //         ? null
  //         : {
  //             "userName": email,
  //             "otp": code
  //           },
  //   );

  //   if (res.statusCode != 200) throw res;
  //   return;
  // }

  // Future<TokenModel?> login2FA({required String email, required String code}) async {
  //   String httpLink = "login2FA";

  //   http.Response res = await _httpCall.post(
  //     httpLink,
  //     isAuthServer: true,
  //     additionalHeaderParameter: _headerParameter,
  //     body: {
  //       "userName": email,
  //       "code": code
  //     },
  //   );

  //   if (res.statusCode != 200) throw res;
  //   return TokenModel.fromJson(res.body);
  // }

  // //! ---------------------------------------------------------------------------------------------- dashboard_wrapper_screen
  // Future<DashboardScreenResponseModel> getDashboard() async {
  //   String httpLink = "Dashboard/GetDashBoardModel";

  //   http.Response res = await _httpCall.get(httpLink);

  //   if (res.statusCode != 200) throw res;
  //   return DashboardScreenResponseModel.fromJson(res.body);
  // }

  // Future<void> submitLeave(Map<String, String> map) async {
  //   String httpLink = "Leave/SubmitLeave";

  //   http.Response res = await _httpCall.post(httpLink, body: map);
  //   if (res.statusCode != 200) throw res;
  //   return;
  // }

  // //! ---------------------------------------------------------------------------------------------- profile_screen
  // Future<ProfileModel> getProfile() async {
  //   String httpLink = "Employee/GetProfileInfo";

  //   http.Response res = await _httpCall.get(httpLink);

  //   if (res.statusCode != 200) throw res;
  //   return ProfileModel.fromJson(res.body);
  // }

  // Future<void> changeProfile(Map<String, String> map) async {
  //   // /api/Employee/ChangeProfileInfo
  //   String httpLink = "Employee/ChangeProfileInfo";

  //   http.Response res = await _httpCall.post(httpLink, body: map);
  //   if (res.statusCode != 200) throw res;
  //   return;
  // }

  // //! ---------------------------------------------------------------------------------------------- expense_screen

  // Future<List<ValueModel>> getExpenseCategoryDropDown() async {
  //   // GetExpenseCategoryDropDown
  //   String httpLink = "Expense/GetExpenseCategoryDropDown";

  //   http.Response res = await _httpCall.get(httpLink);

  //   if (res.statusCode != 200) throw res;
  //   List v = jsonDecode(res.body);

  //   return v.map<ValueModel>((e) => ValueModel.fromMap(e)).toList();
  // }

  // Future<void> submitExpense(Map<String, dynamic> map) async {
  //   // Expense/SubmitExpense
  //   String httpLink = "Expense/SubmitExpense";

  //   http.Response res = await _httpCall.post(httpLink, body: map);
  //   if (res.statusCode != 200) throw res;
  //   return;
  // }

  // //! ---------------------------------------------------------------------------------------------- employee_screen
  // Future<List<ValueModel>> getDepartmentList() async {
  //   // /api/Department/GetDepartmentList
  //   String httpLink = "Department/GetDepartmentList";

  //   http.Response res = await _httpCall.get(httpLink);
  //   if (res.statusCode != 200) throw res;

  //   List v = jsonDecode(res.body);

  //   return v.map<ValueModel>((e) => ValueModel.fromMap(e)).toList();
  // }

  // Future<EmployeeScreenResponseModel> getEmployeeList({required String departmentName, required int pageNumber, String? query, String? shiftID}) async {
  //   // api/Employee/GetEmployeeListOrShiftMemberList
  //   String httpLink = "Employee/GetEmployeeListOrShiftMemberList?pageSize=$paginationPageSize&pageNumber=$pageNumber&departmentName=$departmentName";

  //   if (query != null) httpLink = "$httpLink&query_search=$query";
  //   if (shiftID != null) httpLink = "$httpLink&shiftID=$shiftID";

  //   http.Response res = await _httpCall.post(httpLink);
  //   if (res.statusCode != 200) throw res;

  //   return EmployeeScreenResponseModel.fromJson(res.body);
  // }

  // Future<void> changeEmployeeRole(List<MemberModel> member, {bool? isAdmin, bool? isFollow}) async {
  //   // /api/Employee/ChangeEmployeeRole
  //   String httpLink = "Employee/ChangeEmployeeRole";

  //   if (isAdmin != null) httpLink = "$httpLink?isAdmin=$isAdmin";
  //   if (isFollow != null) httpLink = "$httpLink?isFollow=$isFollow";

  //   List<String> s = [];
  //   if (isAdmin != null) {
  //     s = [
  //       member.first.id
  //     ];
  //   } else {
  //     s = member.map((e) => e.id).toList();
  //   }

  //   http.Response res = await _httpCall.post(httpLink, body: s);
  //   if (res.statusCode != 200) throw res;
  // }

  // Future<void> addShiftOrTeamMembers(String? shiftId, bool doAdd, List<String> membersId) async {
  //   // api/Employee/AddShiftOrTeamMembers
  //   // /api/Employee/RemoveShiftOrTeamMembers
  //   String httpLink = "";

  //   if (doAdd) {
  //     httpLink = "Employee/AddShiftOrTeamMembers?${shiftId == null ? "" : "shiftID=$shiftId"}";
  //   } else {
  //     httpLink = "Employee/RemoveShiftOrTeamMembers?${shiftId == null ? "" : "shiftID=$shiftId"}";
  //   }

  //   http.Response res = await _httpCall.post(httpLink, body: membersId);
  //   if (res.statusCode != 200) throw res;

  //   return;
  // }

  // //! ---------------------------------------------------------------------------------------------- payroll_screen
  // Future<PayrollScreenResponseModel> getPaymentInformation(String memberId) async {
  //   // api/Payroll/GetEmployeePaymentInformation

  //   String httpLink = "Payroll/GetEmployeePaymentInformation?memberID=$memberId";

  //   http.Response res = await _httpCall.get(httpLink);
  //   if (res.statusCode != 200) throw res;

  //   return PayrollScreenResponseModel.fromJson(res.body);
  // }

  // Future<void> submitPayroll(Map data) async {
  //   // /api/Payroll/SubmitPayroll
  //   String httpLink = "Payroll/SubmitPayroll";

  //   http.Response res = await _httpCall.post(httpLink, body: data);
  //   if (res.statusCode != 200) throw res;
  //   return;
  // }

  // //! ---------------------------------------------------------------------------------------------- attendance_screen
  // Future<AttendanceScreenResponseModel> getMonthlyAttendanceInformation(String dateTime) async {
  //   // Attendance/GetMonthlyAttendanceInformation?date=2023-12-18T08%3A00%3A21.883Z

  //   String httpLink = "Attendance/GetMonthlyAttendanceInformation?date=$dateTime";

  //   http.Response res = await _httpCall.get(httpLink);
  //   if (res.statusCode != 200) throw res;

  //   return AttendanceScreenResponseModel.fromJson(res.body);
  // }

  // //! ---------------------------------------------------------------------------------------------- payslip_screen
  // Future<List<DateTime>> getPayslipDropdown() async {
  //   // /api/Payroll/GetPayslipDropdown

  //   String httpLink = "Payroll/GetPayslipDropdown";

  //   http.Response res = await _httpCall.get(httpLink);
  //   if (res.statusCode != 200) throw res;

  //   List<dynamic> l = jsonDecode(res.body);

  //   return l.map((e) => DateTime.parse(e)).toList();
  // }

  // Future<Uint8List> getPayslip(String date) async {
  //   // GetPayslip
  //   String httpLink = "GetPayslip?month=$date";
  //   http.Response res = await _httpCall.get(httpLink, customBaseLink: imageBaseLink, headerParameter: {
  //     HttpHeaders.acceptHeader: 'application/pdf',
  //   });
  //   if (res.statusCode != 200) throw res;
  //   return res.bodyBytes;
  // }

  // //! ---------------------------------------------------------------------------------------------- give_attendance_screen
  // Future<String> getAttendanceType() async {
  //   //https://gtrbd.net/Halda/api/Attendance/GetAttendanceType
  //   String httpLink = "Attendance/GetAttendanceType";

  //   http.Response res = await _httpCall.get(httpLink);
  //   if (res.statusCode != 200) throw res;
  //   return res.body;
  // }

  // Future<void> submitAttendance(PostAttendanceModel postAttendanceModel) async {
  //   // String httpLink = "api/EasyHR/SetAttendance"; //demo api
  //   //https://gtrbd.net/Halda/api/Attendance/SetAttendance
  //   String httpLink = "Attendance/SetAttendance";

  //   http.Response res = await _httpCall.post(httpLink, body: postAttendanceModel.toJson());
  //   if (res.statusCode != 200) throw res;

  //   String metaData = res.body;

  //   if (metaData != "true") throw Exception("Something went wrong");

  //   showToast(message: "Successful");
  // }

  // //! ---------------------------------------------------------------------------------------------- company_screens
  // Future<CompanyScreenResponseModel> getCompanyDetails() async {
  //   // /api/Company/GetCompanyDetails
  //   String httpLink = "Company/GetCompanyDetails";

  //   http.Response res = await _httpCall.get(httpLink);
  //   if (res.statusCode != 200) throw res;
  //   return CompanyScreenResponseModel.fromJson(res.body);
  // }

  // Future<void> setupCompany(Map data) async {
  //   // /api/Company/SetupCompany
  //   String httpLink = "Company/SetupCompany";

  //   http.Response res = await _httpCall.post(httpLink, body: data);
  //   if (res.statusCode != 200) throw res;
  //   return;
  // }
}
