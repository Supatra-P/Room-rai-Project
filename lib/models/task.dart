class Task {
  int? id;
  String? codeRoom; //EGR710
  int? floor; //7
  int? room; //10
  String? building; //Faculity of Engineering
  String? showSearch; //EGR710/Faculity of Engineering

  Task({
    this.id,
    this.codeRoom,
    this.floor,
    this.room,
    this.building,
    this.showSearch,
  });

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codeRoom = json['codeRoom'];
    floor = json['floor'];
    room = json['room'];
    building = json['building'];
    showSearch = json['showSearch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['codeRoom'] = this.codeRoom;
    data['floor'] = this.floor;
    data['room'] = this.room;
    data['building'] = this.building;
    data['showSearch'] = this.showSearch;
    return data;
  }
}
