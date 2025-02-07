import 'package:equatable/equatable.dart';

/// used equatable package to compare objects
/// login state
class LocalAuthStates extends Equatable{
  const LocalAuthStates();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

/// initial state of login
class Authorized extends LocalAuthStates{
  const Authorized();
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

/// loading state of login state
class Unauthorized extends LocalAuthStates{
  const Unauthorized();

  @override
  List<Object?> get props=>[];
}