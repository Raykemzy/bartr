// ignore_for_file: constant_identifier_names

enum LoadState { loading, idle, success, error, loadmore, done, other }

enum LoginLoadState { loading, idle, success, error, unverified }

enum TimerState { timerNotStarted, timerStarted, timerEnded }

enum FollowState { following, notFollowing }

enum ValidationState {
  idle,
  typing,
  notEnough,
  tooMuch,
  enough,
  hasSpecChar,
  noSpecChar,
  finshed
}

enum CurrentState {
  loggedIn,
  onboarded,
  initial,
}

enum PostType {
  Barter,

  Giveaway
}

enum ImageType { single, multi }

enum PostVisiblility { Private, Public }

enum NavigationViewType { home, bids, messages, notifications, profile }

enum SearchStatus { idle, loading, hasSearch, noSearch, error }

enum NotificationType { comment, bid, post, message, user }
