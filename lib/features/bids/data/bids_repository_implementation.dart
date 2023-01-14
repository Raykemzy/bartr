import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/config/exception/app_exception.dart';
import 'package:bartr/core/config/response/base_response.dart';
import 'package:bartr/core/services/network/rest_client.dart';
import 'package:bartr/domain/repositories/bids_repository.dart';
import 'package:bartr/features/bids/domain/user_bids_model.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BidRepoImpl implements BidsRepository {
  final RestClient _client;

  BidRepoImpl(this._client);
  @override
  Future<BaseResponse<UserBid>> getUserBids() async {
    try {
      return await _client.getUserBids();
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }
  
  @override
  Future<BaseResponse<PostBidResponse>> getPostBids(String userId)async {
    try{
      return await _client.getPostBids(userId);
    }on DioError catch (e) {
      return AppException.handleError(e);
    }
  }
}

final bidsRepository =
    Provider<BidsRepository>((ref) => BidRepoImpl(ref.read(restClient)));
