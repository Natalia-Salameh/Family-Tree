class AppLink {
// ========================== Auth ========================== //

  static const String serverName = "https://ajial.azurewebsites.net/api";

  static const String login = "$serverName/Account/Login/MobileApp";

  static const String signup = "$serverName/Account/Register";

  static const String sendEmailVerification =
      "$serverName/Account/SendEmailVerification";

  static const String codeVerification = "$serverName/Account/VerifyEmail";

  // ========================== On Boarding Form  ========================== //

  static const String addMember = "$serverName/Members";

  static const String connectMemberWithAccount =
      "$serverName/Members/AddUserToMember";

  static const String familyName = "$serverName/Families/MobileSearch";

  static const String diary = "$serverName/Profile/AddLegacy";

  // ========================== Home  ========================== //

  static const String search = "$serverName/Members/MobileSearch";

  static const String home = "$serverName/Members/HomePageMembers";

  static const String getLegacyFromId = "$serverName/Profile/FromMemberId";

  // ========================== Profile  ========================== //

  static const String userLegacy = "$serverName/Profile/FromMemberId";

  static const String memberLegacy = "$serverName/Profile/ForMyAccount";

  static const String updateMemberLegacy = "$serverName/Profile/Update";

  static const String updateMemberImage =
      "$serverName/Members/UpdateImageForMyAccount";

  // ========================== Tree  ========================== //

  static const String addMarriageForm = "$serverName/Relations/AddMarriage";

  static const String addChild = "$serverName/Relations/AddChild";
}
