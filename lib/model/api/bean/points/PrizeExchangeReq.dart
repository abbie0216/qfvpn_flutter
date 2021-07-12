class PrizeExchangeReq {
    int prizeId;

    PrizeExchangeReq({required this.prizeId});

    factory PrizeExchangeReq.fromJson(Map<String, dynamic> json) {
        return PrizeExchangeReq(
            prizeId: json['prizeId'], 
        );
    }

    Map<String, dynamic> toJson() {
        final data = <String, dynamic>{};
        data['prizeId'] = prizeId;
        return data;
    }
}