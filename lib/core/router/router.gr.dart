// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const SplashScreen(),
      );
    },
    LandingPageRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const LandingPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const Login(),
      );
    },
    RegisterRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const Register(),
      );
    },
    CreatePostRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const CreatePost(),
      );
    },
    VerifyEmailRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const VerifyEmail(),
      );
    },
    MakeABidRoute.name: (routeData) {
      final args = routeData.argsAs<MakeABidRouteArgs>();
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: MakeABid(
          bidId: args.bidId,
          key: args.key,
        ),
      );
    },
    BidSentSuccessScreenRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const BidSentSuccessScreen(),
      );
    },
    DeleteAccountRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const DeleteAccount(),
      );
    },
    FeedBackViewRoute.name: (routeData) {
      final args = routeData.argsAs<FeedBackViewRouteArgs>(
          orElse: () => const FeedBackViewRouteArgs());
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: FeedBackView(
          key: args.key,
          postID: args.postID,
        ),
      );
    },
    ReportUserViewRoute.name: (routeData) {
      final args = routeData.argsAs<ReportUserViewRouteArgs>();
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: ReportUserView(
          key: args.key,
          user: args.user,
        ),
      );
    },
    FeedBackThanksRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const FeedBackThanks(),
      );
    },
    BartrDashBoardRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const BartrDashBoard(),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const ForgotPassword(),
      );
    },
    CodeSentPageRoute.name: (routeData) {
      final args = routeData.argsAs<CodeSentPageRouteArgs>();
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: CodeSentPage(
          key: args.key,
          email: args.email,
        ),
      );
    },
    EnterCodePageRoute.name: (routeData) {
      final args = routeData.argsAs<EnterCodePageRouteArgs>();
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: EnterCodePage(
          key: args.key,
          email: args.email,
        ),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ResetPasswordRouteArgs>();
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: ResetPassword(
          code: args.code,
          key: args.key,
        ),
      );
    },
    EditPostPageRoute.name: (routeData) {
      final args = routeData.argsAs<EditPostPageRouteArgs>(
          orElse: () => const EditPostPageRouteArgs());
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: EditPostPage(
          key: args.key,
          post: args.post,
          singlePost: args.singlePost,
        ),
      );
    },
    IDSubmittedPageRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const IDSubmittedPage(),
      );
    },
    VerifyProfilePageRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const VerifyProfilePage(),
      );
    },
    HomeRouter.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const EmptyRouterPage(),
      );
    },
    BidsRouter.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const EmptyRouterPage(),
      );
    },
    MessageRouter.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const EmptyRouterPage(),
      );
    },
    NotificationRouter.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const EmptyRouterPage(),
      );
    },
    ProfileRouter.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const EmptyRouterPage(),
      );
    },
    HomeRoute.name: (routeData) {
      final args = routeData.argsAs<HomeRouteArgs>();
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: Home(
          bartrScrollController: args.bartrScrollController,
          giveAwayScrollController: args.giveAwayScrollController,
          key: args.key,
        ),
      );
    },
    ProfilePostDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ProfilePostDetailRouteArgs>();
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: ProfilePostDetail(
          key: args.key,
          posts: args.posts,
          loadState: args.loadState,
          onRefresh: args.onRefresh,
          isUser: args.isUser,
          index: args.index,
          postType: args.postType,
          postIndex: args.postIndex,
          ondeletePost: args.ondeletePost,
        ),
      );
    },
    OtherUserProfileRoute.name: (routeData) {
      final args = routeData.argsAs<OtherUserProfileRouteArgs>();
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: OtherUserProfile(
          key: args.key,
          userId: args.userId,
          username: args.username,
        ),
      );
    },
    PostDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PostDetailRouteArgs>(
          orElse: () =>
              PostDetailRouteArgs(postId: pathParams.getString('postId')));
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: PostDetail(
          key: args.key,
          postId: args.postId,
        ),
      );
    },
    CommentScreenRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CommentScreenRouteArgs>(
          orElse: () =>
              CommentScreenRouteArgs(postId: pathParams.getString('postId')));
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: CommentScreen(
          key: args.key,
          postId: args.postId,
        ),
      );
    },
    SearchPageRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const SearchPage(),
      );
    },
    ChatPageRoute.name: (routeData) {
      final args = routeData.argsAs<ChatPageRouteArgs>();
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: ChatPage(
          key: args.key,
          user: args.user,
          chatRoomId: args.chatRoomId,
          postBid: args.postBid,
        ),
      );
    },
    FilterPageRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const FilterPage(),
      );
    },
    FollowUnfollowViewRoute.name: (routeData) {
      final args = routeData.argsAs<FollowUnfollowViewRouteArgs>();
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: FollowUnfollowView(
          key: args.key,
          currentIndex: args.currentIndex,
          userId: args.userId,
          username: args.username,
        ),
      );
    },
    BidsPageRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const BidsPage(),
      );
    },
    ItemBidsPageRoute.name: (routeData) {
      final args = routeData.argsAs<ItemBidsPageRouteArgs>();
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: ItemBidsPage(
          key: args.key,
          postId: args.postId,
        ),
      );
    },
    EditProfileRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const EditProfile(),
      );
    },
    MessagesScreenRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const MessagesScreen(),
      );
    },
    NotificationViewRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const NotificationView(),
      );
    },
    NotificationPostDetailRoute.name: (routeData) {
      final args = routeData.argsAs<NotificationPostDetailRouteArgs>();
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: NotificationPostDetail(
          key: args.key,
          postId: args.postId,
          senderId: args.senderId,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const Profile(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          SplashScreenRoute.name,
          path: '/',
        ),
        RouteConfig(
          LandingPageRoute.name,
          path: '/landing-page',
        ),
        RouteConfig(
          LoginRoute.name,
          path: '/Login',
        ),
        RouteConfig(
          RegisterRoute.name,
          path: '/Register',
        ),
        RouteConfig(
          CreatePostRoute.name,
          path: '/create-post',
        ),
        RouteConfig(
          VerifyEmailRoute.name,
          path: '/verify-email',
        ),
        RouteConfig(
          MakeABidRoute.name,
          path: '/make-aBid',
        ),
        RouteConfig(
          BidSentSuccessScreenRoute.name,
          path: '/bid-sent-success-screen',
        ),
        RouteConfig(
          DeleteAccountRoute.name,
          path: '/delete-account',
        ),
        RouteConfig(
          FeedBackViewRoute.name,
          path: '/feed-back-view',
        ),
        RouteConfig(
          ReportUserViewRoute.name,
          path: '/report-user-view',
        ),
        RouteConfig(
          FeedBackThanksRoute.name,
          path: '/feed-back-thanks',
        ),
        RouteConfig(
          BartrDashBoardRoute.name,
          path: '/bartr-dash-board',
          children: [
            RouteConfig(
              HomeRouter.name,
              path: 'home',
              parent: BartrDashBoardRoute.name,
              children: [
                RouteConfig(
                  HomeRoute.name,
                  path: '',
                  parent: HomeRouter.name,
                ),
                RouteConfig(
                  ProfilePostDetailRoute.name,
                  path: ':postdetail',
                  parent: HomeRouter.name,
                ),
                RouteConfig(
                  OtherUserProfileRoute.name,
                  path: ':userId',
                  parent: HomeRouter.name,
                ),
                RouteConfig(
                  PostDetailRoute.name,
                  path: ':postId',
                  parent: HomeRouter.name,
                ),
                RouteConfig(
                  CommentScreenRoute.name,
                  path: ':postId',
                  parent: HomeRouter.name,
                ),
                RouteConfig(
                  SearchPageRoute.name,
                  path: ':search',
                  parent: HomeRouter.name,
                ),
                RouteConfig(
                  ChatPageRoute.name,
                  path: ':userId',
                  parent: HomeRouter.name,
                ),
                RouteConfig(
                  FilterPageRoute.name,
                  path: 'filter',
                  parent: HomeRouter.name,
                ),
                RouteConfig(
                  FollowUnfollowViewRoute.name,
                  path: ':currentIndex',
                  parent: HomeRouter.name,
                ),
              ],
            ),
            RouteConfig(
              BidsRouter.name,
              path: 'bids',
              parent: BartrDashBoardRoute.name,
              children: [
                RouteConfig(
                  BidsPageRoute.name,
                  path: '',
                  parent: BidsRouter.name,
                ),
                RouteConfig(
                  ItemBidsPageRoute.name,
                  path: ':postId',
                  parent: BidsRouter.name,
                ),
                RouteConfig(
                  ChatPageRoute.name,
                  path: ':userId',
                  parent: BidsRouter.name,
                ),
                RouteConfig(
                  OtherUserProfileRoute.name,
                  path: ':userId',
                  parent: BidsRouter.name,
                ),
                RouteConfig(
                  PostDetailRoute.name,
                  path: ':postId',
                  parent: BidsRouter.name,
                ),
                RouteConfig(
                  CommentScreenRoute.name,
                  path: ':postId',
                  parent: BidsRouter.name,
                ),
                RouteConfig(
                  EditProfileRoute.name,
                  path: ':editProfile',
                  parent: BidsRouter.name,
                ),
                RouteConfig(
                  FollowUnfollowViewRoute.name,
                  path: ':currentIndex',
                  parent: BidsRouter.name,
                ),
                RouteConfig(
                  ProfilePostDetailRoute.name,
                  path: ':postdetail',
                  parent: BidsRouter.name,
                ),
              ],
            ),
            RouteConfig(
              MessageRouter.name,
              path: 'messages',
              parent: BartrDashBoardRoute.name,
              children: [
                RouteConfig(
                  MessagesScreenRoute.name,
                  path: '',
                  parent: MessageRouter.name,
                ),
                RouteConfig(
                  ChatPageRoute.name,
                  path: ':userId',
                  parent: MessageRouter.name,
                ),
                RouteConfig(
                  CommentScreenRoute.name,
                  path: ':postId',
                  parent: MessageRouter.name,
                ),
                RouteConfig(
                  ProfilePostDetailRoute.name,
                  path: ':postdetail',
                  parent: MessageRouter.name,
                ),
                RouteConfig(
                  OtherUserProfileRoute.name,
                  path: ':userId',
                  parent: MessageRouter.name,
                ),
                RouteConfig(
                  PostDetailRoute.name,
                  path: ':postId',
                  parent: MessageRouter.name,
                ),
                RouteConfig(
                  CommentScreenRoute.name,
                  path: ':postId',
                  parent: MessageRouter.name,
                ),
                RouteConfig(
                  FollowUnfollowViewRoute.name,
                  path: ':currentIndex',
                  parent: MessageRouter.name,
                ),
              ],
            ),
            RouteConfig(
              NotificationRouter.name,
              path: 'notifications',
              parent: BartrDashBoardRoute.name,
              children: [
                RouteConfig(
                  NotificationViewRoute.name,
                  path: '',
                  parent: NotificationRouter.name,
                ),
                RouteConfig(
                  PostDetailRoute.name,
                  path: ':postId',
                  parent: NotificationRouter.name,
                ),
                RouteConfig(
                  ProfilePostDetailRoute.name,
                  path: ':postdetail',
                  parent: NotificationRouter.name,
                ),
                RouteConfig(
                  OtherUserProfileRoute.name,
                  path: ':userId',
                  parent: NotificationRouter.name,
                ),
                RouteConfig(
                  NotificationPostDetailRoute.name,
                  path: ':postId',
                  parent: NotificationRouter.name,
                ),
                RouteConfig(
                  ItemBidsPageRoute.name,
                  path: ':postId',
                  parent: NotificationRouter.name,
                ),
                RouteConfig(
                  ChatPageRoute.name,
                  path: ':userId',
                  parent: NotificationRouter.name,
                ),
                RouteConfig(
                  FollowUnfollowViewRoute.name,
                  path: ':currentIndex',
                  parent: NotificationRouter.name,
                ),
              ],
            ),
            RouteConfig(
              ProfileRouter.name,
              path: 'profile',
              parent: BartrDashBoardRoute.name,
              children: [
                RouteConfig(
                  ProfileRoute.name,
                  path: '',
                  parent: ProfileRouter.name,
                ),
                RouteConfig(
                  ChatPageRoute.name,
                  path: ':userId',
                  parent: ProfileRouter.name,
                ),
                RouteConfig(
                  ProfilePostDetailRoute.name,
                  path: ':postdetail',
                  parent: ProfileRouter.name,
                ),
                RouteConfig(
                  OtherUserProfileRoute.name,
                  path: ':userId',
                  parent: ProfileRouter.name,
                ),
                RouteConfig(
                  PostDetailRoute.name,
                  path: ':postId',
                  parent: ProfileRouter.name,
                ),
                RouteConfig(
                  EditProfileRoute.name,
                  path: ':editProfile',
                  parent: ProfileRouter.name,
                ),
                RouteConfig(
                  FollowUnfollowViewRoute.name,
                  path: ':currentIndex',
                  parent: ProfileRouter.name,
                ),
              ],
            ),
          ],
        ),
        RouteConfig(
          ForgotPasswordRoute.name,
          path: '/forgot-password',
        ),
        RouteConfig(
          CodeSentPageRoute.name,
          path: '/code-sent-page',
        ),
        RouteConfig(
          EnterCodePageRoute.name,
          path: '/enter-code-page',
        ),
        RouteConfig(
          ResetPasswordRoute.name,
          path: '/reset-password',
        ),
        RouteConfig(
          EditPostPageRoute.name,
          path: '/edit-post-page',
        ),
        RouteConfig(
          IDSubmittedPageRoute.name,
          path: '/i-dsubmitted-page',
        ),
        RouteConfig(
          VerifyProfilePageRoute.name,
          path: '/verify-profile-page',
        ),
      ];
}

/// generated route for
/// [SplashScreen]
class SplashScreenRoute extends PageRouteInfo<void> {
  const SplashScreenRoute()
      : super(
          SplashScreenRoute.name,
          path: '/',
        );

  static const String name = 'SplashScreenRoute';
}

/// generated route for
/// [LandingPage]
class LandingPageRoute extends PageRouteInfo<void> {
  const LandingPageRoute()
      : super(
          LandingPageRoute.name,
          path: '/landing-page',
        );

  static const String name = 'LandingPageRoute';
}

/// generated route for
/// [Login]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/Login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [Register]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute()
      : super(
          RegisterRoute.name,
          path: '/Register',
        );

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [CreatePost]
class CreatePostRoute extends PageRouteInfo<void> {
  const CreatePostRoute()
      : super(
          CreatePostRoute.name,
          path: '/create-post',
        );

  static const String name = 'CreatePostRoute';
}

/// generated route for
/// [VerifyEmail]
class VerifyEmailRoute extends PageRouteInfo<void> {
  const VerifyEmailRoute()
      : super(
          VerifyEmailRoute.name,
          path: '/verify-email',
        );

  static const String name = 'VerifyEmailRoute';
}

/// generated route for
/// [MakeABid]
class MakeABidRoute extends PageRouteInfo<MakeABidRouteArgs> {
  MakeABidRoute({
    required String bidId,
    Key? key,
  }) : super(
          MakeABidRoute.name,
          path: '/make-aBid',
          args: MakeABidRouteArgs(
            bidId: bidId,
            key: key,
          ),
        );

  static const String name = 'MakeABidRoute';
}

class MakeABidRouteArgs {
  const MakeABidRouteArgs({
    required this.bidId,
    this.key,
  });

  final String bidId;

  final Key? key;

  @override
  String toString() {
    return 'MakeABidRouteArgs{bidId: $bidId, key: $key}';
  }
}

/// generated route for
/// [BidSentSuccessScreen]
class BidSentSuccessScreenRoute extends PageRouteInfo<void> {
  const BidSentSuccessScreenRoute()
      : super(
          BidSentSuccessScreenRoute.name,
          path: '/bid-sent-success-screen',
        );

  static const String name = 'BidSentSuccessScreenRoute';
}

/// generated route for
/// [DeleteAccount]
class DeleteAccountRoute extends PageRouteInfo<void> {
  const DeleteAccountRoute()
      : super(
          DeleteAccountRoute.name,
          path: '/delete-account',
        );

  static const String name = 'DeleteAccountRoute';
}

/// generated route for
/// [FeedBackView]
class FeedBackViewRoute extends PageRouteInfo<FeedBackViewRouteArgs> {
  FeedBackViewRoute({
    Key? key,
    String? postID,
  }) : super(
          FeedBackViewRoute.name,
          path: '/feed-back-view',
          args: FeedBackViewRouteArgs(
            key: key,
            postID: postID,
          ),
        );

  static const String name = 'FeedBackViewRoute';
}

class FeedBackViewRouteArgs {
  const FeedBackViewRouteArgs({
    this.key,
    this.postID,
  });

  final Key? key;

  final String? postID;

  @override
  String toString() {
    return 'FeedBackViewRouteArgs{key: $key, postID: $postID}';
  }
}

/// generated route for
/// [ReportUserView]
class ReportUserViewRoute extends PageRouteInfo<ReportUserViewRouteArgs> {
  ReportUserViewRoute({
    Key? key,
    required BartrUser user,
  }) : super(
          ReportUserViewRoute.name,
          path: '/report-user-view',
          args: ReportUserViewRouteArgs(
            key: key,
            user: user,
          ),
        );

  static const String name = 'ReportUserViewRoute';
}

class ReportUserViewRouteArgs {
  const ReportUserViewRouteArgs({
    this.key,
    required this.user,
  });

  final Key? key;

  final BartrUser user;

  @override
  String toString() {
    return 'ReportUserViewRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [FeedBackThanks]
class FeedBackThanksRoute extends PageRouteInfo<void> {
  const FeedBackThanksRoute()
      : super(
          FeedBackThanksRoute.name,
          path: '/feed-back-thanks',
        );

  static const String name = 'FeedBackThanksRoute';
}

/// generated route for
/// [BartrDashBoard]
class BartrDashBoardRoute extends PageRouteInfo<void> {
  const BartrDashBoardRoute({List<PageRouteInfo>? children})
      : super(
          BartrDashBoardRoute.name,
          path: '/bartr-dash-board',
          initialChildren: children,
        );

  static const String name = 'BartrDashBoardRoute';
}

/// generated route for
/// [ForgotPassword]
class ForgotPasswordRoute extends PageRouteInfo<void> {
  const ForgotPasswordRoute()
      : super(
          ForgotPasswordRoute.name,
          path: '/forgot-password',
        );

  static const String name = 'ForgotPasswordRoute';
}

/// generated route for
/// [CodeSentPage]
class CodeSentPageRoute extends PageRouteInfo<CodeSentPageRouteArgs> {
  CodeSentPageRoute({
    Key? key,
    required String email,
  }) : super(
          CodeSentPageRoute.name,
          path: '/code-sent-page',
          args: CodeSentPageRouteArgs(
            key: key,
            email: email,
          ),
        );

  static const String name = 'CodeSentPageRoute';
}

class CodeSentPageRouteArgs {
  const CodeSentPageRouteArgs({
    this.key,
    required this.email,
  });

  final Key? key;

  final String email;

  @override
  String toString() {
    return 'CodeSentPageRouteArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [EnterCodePage]
class EnterCodePageRoute extends PageRouteInfo<EnterCodePageRouteArgs> {
  EnterCodePageRoute({
    Key? key,
    required String email,
  }) : super(
          EnterCodePageRoute.name,
          path: '/enter-code-page',
          args: EnterCodePageRouteArgs(
            key: key,
            email: email,
          ),
        );

  static const String name = 'EnterCodePageRoute';
}

class EnterCodePageRouteArgs {
  const EnterCodePageRouteArgs({
    this.key,
    required this.email,
  });

  final Key? key;

  final String email;

  @override
  String toString() {
    return 'EnterCodePageRouteArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [ResetPassword]
class ResetPasswordRoute extends PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    required String code,
    Key? key,
  }) : super(
          ResetPasswordRoute.name,
          path: '/reset-password',
          args: ResetPasswordRouteArgs(
            code: code,
            key: key,
          ),
        );

  static const String name = 'ResetPasswordRoute';
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({
    required this.code,
    this.key,
  });

  final String code;

  final Key? key;

  @override
  String toString() {
    return 'ResetPasswordRouteArgs{code: $code, key: $key}';
  }
}

/// generated route for
/// [EditPostPage]
class EditPostPageRoute extends PageRouteInfo<EditPostPageRouteArgs> {
  EditPostPageRoute({
    Key? key,
    Post? post,
    SinglePost? singlePost,
  }) : super(
          EditPostPageRoute.name,
          path: '/edit-post-page',
          args: EditPostPageRouteArgs(
            key: key,
            post: post,
            singlePost: singlePost,
          ),
        );

  static const String name = 'EditPostPageRoute';
}

class EditPostPageRouteArgs {
  const EditPostPageRouteArgs({
    this.key,
    this.post,
    this.singlePost,
  });

  final Key? key;

  final Post? post;

  final SinglePost? singlePost;

  @override
  String toString() {
    return 'EditPostPageRouteArgs{key: $key, post: $post, singlePost: $singlePost}';
  }
}

/// generated route for
/// [IDSubmittedPage]
class IDSubmittedPageRoute extends PageRouteInfo<void> {
  const IDSubmittedPageRoute()
      : super(
          IDSubmittedPageRoute.name,
          path: '/i-dsubmitted-page',
        );

  static const String name = 'IDSubmittedPageRoute';
}

/// generated route for
/// [VerifyProfilePage]
class VerifyProfilePageRoute extends PageRouteInfo<void> {
  const VerifyProfilePageRoute()
      : super(
          VerifyProfilePageRoute.name,
          path: '/verify-profile-page',
        );

  static const String name = 'VerifyProfilePageRoute';
}

/// generated route for
/// [EmptyRouterPage]
class HomeRouter extends PageRouteInfo<void> {
  const HomeRouter({List<PageRouteInfo>? children})
      : super(
          HomeRouter.name,
          path: 'home',
          initialChildren: children,
        );

  static const String name = 'HomeRouter';
}

/// generated route for
/// [EmptyRouterPage]
class BidsRouter extends PageRouteInfo<void> {
  const BidsRouter({List<PageRouteInfo>? children})
      : super(
          BidsRouter.name,
          path: 'bids',
          initialChildren: children,
        );

  static const String name = 'BidsRouter';
}

/// generated route for
/// [EmptyRouterPage]
class MessageRouter extends PageRouteInfo<void> {
  const MessageRouter({List<PageRouteInfo>? children})
      : super(
          MessageRouter.name,
          path: 'messages',
          initialChildren: children,
        );

  static const String name = 'MessageRouter';
}

/// generated route for
/// [EmptyRouterPage]
class NotificationRouter extends PageRouteInfo<void> {
  const NotificationRouter({List<PageRouteInfo>? children})
      : super(
          NotificationRouter.name,
          path: 'notifications',
          initialChildren: children,
        );

  static const String name = 'NotificationRouter';
}

/// generated route for
/// [EmptyRouterPage]
class ProfileRouter extends PageRouteInfo<void> {
  const ProfileRouter({List<PageRouteInfo>? children})
      : super(
          ProfileRouter.name,
          path: 'profile',
          initialChildren: children,
        );

  static const String name = 'ProfileRouter';
}

/// generated route for
/// [Home]
class HomeRoute extends PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    required ScrollController bartrScrollController,
    required ScrollController giveAwayScrollController,
    Key? key,
  }) : super(
          HomeRoute.name,
          path: '',
          args: HomeRouteArgs(
            bartrScrollController: bartrScrollController,
            giveAwayScrollController: giveAwayScrollController,
            key: key,
          ),
        );

  static const String name = 'HomeRoute';
}

class HomeRouteArgs {
  const HomeRouteArgs({
    required this.bartrScrollController,
    required this.giveAwayScrollController,
    this.key,
  });

  final ScrollController bartrScrollController;

  final ScrollController giveAwayScrollController;

  final Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{bartrScrollController: $bartrScrollController, giveAwayScrollController: $giveAwayScrollController, key: $key}';
  }
}

/// generated route for
/// [ProfilePostDetail]
class ProfilePostDetailRoute extends PageRouteInfo<ProfilePostDetailRouteArgs> {
  ProfilePostDetailRoute({
    Key? key,
    required List<Post> posts,
    required LoadState loadState,
    required Future<void> Function() onRefresh,
    required bool isUser,
    required int index,
    required PostType postType,
    required int postIndex,
    required void Function() ondeletePost,
  }) : super(
          ProfilePostDetailRoute.name,
          path: ':postdetail',
          args: ProfilePostDetailRouteArgs(
            key: key,
            posts: posts,
            loadState: loadState,
            onRefresh: onRefresh,
            isUser: isUser,
            index: index,
            postType: postType,
            postIndex: postIndex,
            ondeletePost: ondeletePost,
          ),
        );

  static const String name = 'ProfilePostDetailRoute';
}

class ProfilePostDetailRouteArgs {
  const ProfilePostDetailRouteArgs({
    this.key,
    required this.posts,
    required this.loadState,
    required this.onRefresh,
    required this.isUser,
    required this.index,
    required this.postType,
    required this.postIndex,
    required this.ondeletePost,
  });

  final Key? key;

  final List<Post> posts;

  final LoadState loadState;

  final Future<void> Function() onRefresh;

  final bool isUser;

  final int index;

  final PostType postType;

  final int postIndex;

  final void Function() ondeletePost;

  @override
  String toString() {
    return 'ProfilePostDetailRouteArgs{key: $key, posts: $posts, loadState: $loadState, onRefresh: $onRefresh, isUser: $isUser, index: $index, postType: $postType, postIndex: $postIndex, ondeletePost: $ondeletePost}';
  }
}

/// generated route for
/// [OtherUserProfile]
class OtherUserProfileRoute extends PageRouteInfo<OtherUserProfileRouteArgs> {
  OtherUserProfileRoute({
    Key? key,
    required String userId,
    required String username,
  }) : super(
          OtherUserProfileRoute.name,
          path: ':userId',
          args: OtherUserProfileRouteArgs(
            key: key,
            userId: userId,
            username: username,
          ),
          rawPathParams: {'userId': userId},
        );

  static const String name = 'OtherUserProfileRoute';
}

class OtherUserProfileRouteArgs {
  const OtherUserProfileRouteArgs({
    this.key,
    required this.userId,
    required this.username,
  });

  final Key? key;

  final String userId;

  final String username;

  @override
  String toString() {
    return 'OtherUserProfileRouteArgs{key: $key, userId: $userId, username: $username}';
  }
}

/// generated route for
/// [PostDetail]
class PostDetailRoute extends PageRouteInfo<PostDetailRouteArgs> {
  PostDetailRoute({
    Key? key,
    required String postId,
  }) : super(
          PostDetailRoute.name,
          path: ':postId',
          args: PostDetailRouteArgs(
            key: key,
            postId: postId,
          ),
          rawPathParams: {'postId': postId},
        );

  static const String name = 'PostDetailRoute';
}

class PostDetailRouteArgs {
  const PostDetailRouteArgs({
    this.key,
    required this.postId,
  });

  final Key? key;

  final String postId;

  @override
  String toString() {
    return 'PostDetailRouteArgs{key: $key, postId: $postId}';
  }
}

/// generated route for
/// [CommentScreen]
class CommentScreenRoute extends PageRouteInfo<CommentScreenRouteArgs> {
  CommentScreenRoute({
    Key? key,
    required String postId,
  }) : super(
          CommentScreenRoute.name,
          path: ':postId',
          args: CommentScreenRouteArgs(
            key: key,
            postId: postId,
          ),
          rawPathParams: {'postId': postId},
        );

  static const String name = 'CommentScreenRoute';
}

class CommentScreenRouteArgs {
  const CommentScreenRouteArgs({
    this.key,
    required this.postId,
  });

  final Key? key;

  final String postId;

  @override
  String toString() {
    return 'CommentScreenRouteArgs{key: $key, postId: $postId}';
  }
}

/// generated route for
/// [SearchPage]
class SearchPageRoute extends PageRouteInfo<void> {
  const SearchPageRoute()
      : super(
          SearchPageRoute.name,
          path: ':search',
        );

  static const String name = 'SearchPageRoute';
}

/// generated route for
/// [ChatPage]
class ChatPageRoute extends PageRouteInfo<ChatPageRouteArgs> {
  ChatPageRoute({
    Key? key,
    required Member user,
    required String chatRoomId,
    PostBid? postBid,
  }) : super(
          ChatPageRoute.name,
          path: ':userId',
          args: ChatPageRouteArgs(
            key: key,
            user: user,
            chatRoomId: chatRoomId,
            postBid: postBid,
          ),
        );

  static const String name = 'ChatPageRoute';
}

class ChatPageRouteArgs {
  const ChatPageRouteArgs({
    this.key,
    required this.user,
    required this.chatRoomId,
    this.postBid,
  });

  final Key? key;

  final Member user;

  final String chatRoomId;

  final PostBid? postBid;

  @override
  String toString() {
    return 'ChatPageRouteArgs{key: $key, user: $user, chatRoomId: $chatRoomId, postBid: $postBid}';
  }
}

/// generated route for
/// [FilterPage]
class FilterPageRoute extends PageRouteInfo<void> {
  const FilterPageRoute()
      : super(
          FilterPageRoute.name,
          path: 'filter',
        );

  static const String name = 'FilterPageRoute';
}

/// generated route for
/// [FollowUnfollowView]
class FollowUnfollowViewRoute
    extends PageRouteInfo<FollowUnfollowViewRouteArgs> {
  FollowUnfollowViewRoute({
    Key? key,
    required int currentIndex,
    required String userId,
    required String username,
  }) : super(
          FollowUnfollowViewRoute.name,
          path: ':currentIndex',
          args: FollowUnfollowViewRouteArgs(
            key: key,
            currentIndex: currentIndex,
            userId: userId,
            username: username,
          ),
          rawPathParams: {'currentIndex': currentIndex},
        );

  static const String name = 'FollowUnfollowViewRoute';
}

class FollowUnfollowViewRouteArgs {
  const FollowUnfollowViewRouteArgs({
    this.key,
    required this.currentIndex,
    required this.userId,
    required this.username,
  });

  final Key? key;

  final int currentIndex;

  final String userId;

  final String username;

  @override
  String toString() {
    return 'FollowUnfollowViewRouteArgs{key: $key, currentIndex: $currentIndex, userId: $userId, username: $username}';
  }
}

/// generated route for
/// [BidsPage]
class BidsPageRoute extends PageRouteInfo<void> {
  const BidsPageRoute()
      : super(
          BidsPageRoute.name,
          path: '',
        );

  static const String name = 'BidsPageRoute';
}

/// generated route for
/// [ItemBidsPage]
class ItemBidsPageRoute extends PageRouteInfo<ItemBidsPageRouteArgs> {
  ItemBidsPageRoute({
    Key? key,
    required String postId,
  }) : super(
          ItemBidsPageRoute.name,
          path: ':postId',
          args: ItemBidsPageRouteArgs(
            key: key,
            postId: postId,
          ),
        );

  static const String name = 'ItemBidsPageRoute';
}

class ItemBidsPageRouteArgs {
  const ItemBidsPageRouteArgs({
    this.key,
    required this.postId,
  });

  final Key? key;

  final String postId;

  @override
  String toString() {
    return 'ItemBidsPageRouteArgs{key: $key, postId: $postId}';
  }
}

/// generated route for
/// [EditProfile]
class EditProfileRoute extends PageRouteInfo<void> {
  const EditProfileRoute()
      : super(
          EditProfileRoute.name,
          path: ':editProfile',
        );

  static const String name = 'EditProfileRoute';
}

/// generated route for
/// [MessagesScreen]
class MessagesScreenRoute extends PageRouteInfo<void> {
  const MessagesScreenRoute()
      : super(
          MessagesScreenRoute.name,
          path: '',
        );

  static const String name = 'MessagesScreenRoute';
}

/// generated route for
/// [NotificationView]
class NotificationViewRoute extends PageRouteInfo<void> {
  const NotificationViewRoute()
      : super(
          NotificationViewRoute.name,
          path: '',
        );

  static const String name = 'NotificationViewRoute';
}

/// generated route for
/// [NotificationPostDetail]
class NotificationPostDetailRoute
    extends PageRouteInfo<NotificationPostDetailRouteArgs> {
  NotificationPostDetailRoute({
    Key? key,
    required String postId,
    required String senderId,
  }) : super(
          NotificationPostDetailRoute.name,
          path: ':postId',
          args: NotificationPostDetailRouteArgs(
            key: key,
            postId: postId,
            senderId: senderId,
          ),
          rawPathParams: {'postId': postId},
        );

  static const String name = 'NotificationPostDetailRoute';
}

class NotificationPostDetailRouteArgs {
  const NotificationPostDetailRouteArgs({
    this.key,
    required this.postId,
    required this.senderId,
  });

  final Key? key;

  final String postId;

  final String senderId;

  @override
  String toString() {
    return 'NotificationPostDetailRouteArgs{key: $key, postId: $postId, senderId: $senderId}';
  }
}

/// generated route for
/// [Profile]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute()
      : super(
          ProfileRoute.name,
          path: '',
        );

  static const String name = 'ProfileRoute';
}
