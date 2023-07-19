abstract class AdminStates {}

class InitialAdminState extends AdminStates {}

class GetAdminLoadingState extends AdminStates {}

class GetAdminSuccessState extends AdminStates {}

class GetAdminCachedSuccessState extends AdminStates {}

class GetAdminErrorState extends AdminStates {
  final String error;

  GetAdminErrorState(this.error);
}

class ChangeObscurePassFlagAdminState extends AdminStates {}

class ChangeObscureConfirmFlagAdminState extends AdminStates {}

class LogOutSuccessAdminState extends AdminStates {}
