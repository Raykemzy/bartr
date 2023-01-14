import 'package:bartr/core/config/response/base_response.dart';
import 'package:bartr/features/bids/domain/user_bids_model.dart';

abstract class BidsRepository {
  Future<BaseResponse<UserBid>> getUserBids();
  Future<BaseResponse<PostBidResponse>> getPostBids(String userId);
}
