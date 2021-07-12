class PrizeListResp {
    List<Prize> items;

    PrizeListResp({required this.items});

    factory PrizeListResp.fromJson(Map<String, dynamic> json) {
        return PrizeListResp(
            items: (json['items'] as List).map((i) => Prize.fromJson(i)).toList(),
        );
    }

    Map<String, dynamic> toJson() {
        final data = <String, dynamic>{};
        data['items'] = items.map((v) => v.toJson()).toList();
        return data;
    }
}

class Prize {
    String name;
    int point;
    int prizeId;

    Prize({required this.name, required this.point, required this.prizeId});

    factory Prize.fromJson(Map<String, dynamic> json) {
        return Prize(
            name: json['name'],
            point: json['point'],
            prizeId: json['prizeId'],
        );
    }

    Map<String, dynamic> toJson() {
        final data = <String, dynamic>{};
        data['name'] = name;
        data['point'] = point;
        data['prizeId'] = prizeId;
        return data;
    }
}