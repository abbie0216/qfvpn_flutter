class PointsDetailResp {
    List<PointDetail>? items;
    int pageNo;
    int pageSize;
    int totalCount;
    int totalPage;

    PointsDetailResp({required this.items, required this.pageNo, required this.pageSize, required this.totalCount, required this.totalPage});

    factory PointsDetailResp.fromJson(Map<String, dynamic> json) {
        return PointsDetailResp(
            items: json['items'] != null ? (json['items'] as List).map((i) => PointDetail.fromJson(i)).toList(): null,
            pageNo: json['pageNo'], 
            pageSize: json['pageSize'], 
            totalCount: json['totalCount'], 
            totalPage: json['totalPage'], 
        );
    }

    Map<String, dynamic> toJson() {
        final data = <String, dynamic>{};
        data['pageNo'] = pageNo;
        data['pageSize'] = pageSize;
        data['totalCount'] = totalCount;
        data['totalPage'] = totalPage;
        if (items != null) {
            data['items'] = items!.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class PointDetail {
    String changeAt;
    String inOrOut;
    int point;
    String remark;
    int id;

    PointDetail({required this.changeAt, required this.inOrOut, required this.point, required this.remark, required this.id});

    factory PointDetail.fromJson(Map<String, dynamic> json) {
        return PointDetail(
            changeAt: json['changeAt'],
            inOrOut: json['inOrOut'],
            point: json['point'],
            remark: json['remark'],
            id: json['id'],
        );
    }

    Map<String, dynamic> toJson() {
        final data = <String, dynamic>{};
        data['changeAt'] = changeAt;
        data['inOrOut'] = inOrOut;
        data['point'] = point;
        data['remark'] = remark;
        data['id'] = id;
        return data;
    }
}