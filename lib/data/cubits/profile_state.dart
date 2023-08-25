abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

//For Profile Page
class LoadingProfileState extends ProfileState {}

class DoneProfileState extends ProfileState {}

class ErrorProfileState extends ProfileState {
  final String error;

  ErrorProfileState(this.error);
}

class TakePicture extends ProfileState {}
