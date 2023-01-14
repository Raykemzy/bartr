import 'package:auto_route/empty_router_widgets.dart';
import 'package:bartr/core/router/routes.dart';
import 'package:bartr/features/post_and_comments/domain/models/single_post_model.dart';
import 'package:bartr/features/verify_profile/presentation/pages/id_submitted_page.dart';
import 'package:bartr/features/verify_profile/presentation/pages/verify_profile_page.dart';
import 'package:flutter/material.dart';

part 'router.gr.dart';

@CupertinoAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: SplashScreen, initial: true),
    AutoRoute(page: LandingPage),
    AutoRoute(page: Login),
    AutoRoute(page: Register),
    AutoRoute(page: CreatePost),
    AutoRoute(page: VerifyEmail),
    AutoRoute(page: MakeABid),
    AutoRoute(page: BidSentSuccessScreen),
    AutoRoute(page: DeleteAccount),
    AutoRoute(page: FeedBackView),
    AutoRoute(page: ReportUserView),
    AutoRoute(page: FeedBackThanks),
    AutoRoute(
      page: BartrDashBoard,
      children: [
        AutoRoute(
          page: EmptyRouterPage,
          path: "home",
          name: "homeRouter",
          children: [
            AutoRoute(page: Home, initial: true),
            AutoRoute(path: ':postdetail', page: ProfilePostDetail),
            AutoRoute(path: ':userId', page: OtherUserProfile),
            AutoRoute(path: ':postId', page: PostDetail),
            AutoRoute(path: ':postId', page: CommentScreen),
            AutoRoute(path: ':search', page: SearchPage),
            AutoRoute(path: ":userId", page: ChatPage),
            AutoRoute(path: "filter", page: FilterPage),
            AutoRoute(path: ':currentIndex', page: FollowUnfollowView),
          ],
        ),
        AutoRoute(
            page: EmptyRouterPage,
            path: "bids",
            name: "bidsRouter",
            children: [
              AutoRoute(page: BidsPage, initial: true),
              AutoRoute(path: ":postId", page: ItemBidsPage),
              AutoRoute(path: ":userId", page: ChatPage),
              AutoRoute(path: ':userId', page: OtherUserProfile),
              AutoRoute(path: ':postId', page: PostDetail),
              AutoRoute(path: ':postId', page: CommentScreen),
              AutoRoute(path: ':editProfile', page: EditProfile),
              AutoRoute(path: ':currentIndex', page: FollowUnfollowView),
              AutoRoute(path: ':postdetail', page: ProfilePostDetail),
            ]),
        AutoRoute(
          page: EmptyRouterPage,
          path: "messages",
          name: "messageRouter",
          children: [
            AutoRoute(page: MessagesScreen, initial: true),
            AutoRoute(path: ":userId", page: ChatPage),
            AutoRoute(path: ':postId', page: CommentScreen),
            AutoRoute(path: ':postdetail', page: ProfilePostDetail),
            AutoRoute(path: ':userId', page: OtherUserProfile),
            AutoRoute(path: ':postId', page: PostDetail),
            AutoRoute(path: ':postId', page: CommentScreen),
            AutoRoute(path: ':currentIndex', page: FollowUnfollowView),
          ],
        ),
        AutoRoute(
          page: EmptyRouterPage,
          path: "notifications",
          name: "notificationRouter",
          children: [
            AutoRoute(page: NotificationView, initial: true),
            AutoRoute(path: ':postId', page: PostDetail),
            AutoRoute(path: ':postdetail', page: ProfilePostDetail),
            AutoRoute(path: ':userId', page: OtherUserProfile),
            AutoRoute(path: ':postId', page: NotificationPostDetail),
            AutoRoute(path: ":postId", page: ItemBidsPage),
            AutoRoute(path: ":userId", page: ChatPage),
            AutoRoute(path: ':currentIndex', page: FollowUnfollowView),
          ],
        ),
        AutoRoute(
          page: EmptyRouterPage,
          path: "profile",
          name: "ProfileRouter",
          children: [
            AutoRoute(initial: true, page: Profile),
            AutoRoute(path: ":userId", page: ChatPage),
            AutoRoute(path: ':postdetail', page: ProfilePostDetail),
            AutoRoute(path: ':userId', page: OtherUserProfile),
            AutoRoute(path: ':postId', page: PostDetail),
            AutoRoute(path: ':editProfile', page: EditProfile),
            AutoRoute(path: ':currentIndex', page: FollowUnfollowView),
          ],
        ),
      ],
    ),
    AutoRoute(page: ForgotPassword),
    AutoRoute(page: CodeSentPage),
    AutoRoute(page: EnterCodePage),
    AutoRoute(page: ResetPassword),
    AutoRoute(page: EditPostPage),
    AutoRoute(page: IDSubmittedPage),
    AutoRoute(page: VerifyProfilePage),
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {}
