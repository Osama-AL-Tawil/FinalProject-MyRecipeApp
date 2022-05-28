class TransNameModel{
  String? ar;
  String? en;
  TransNameModel(this.ar,this.en);
  toMap(){
    return {'ar':ar,'en':en};
  }
}