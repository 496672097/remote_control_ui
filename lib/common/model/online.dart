/// ip : "/192.168.1.103:51614"
/// os : "macos"

class Online {
  Online(
      String ip, 
      String os,
      int cpuCore,
      String hostname){
    _ip = ip;
    _os = os;
    _cpuCore = cpuCore;
    _hostname = hostname;
}
  late String _ip;
  late String _os;
  late int _cpuCore;
  late String _hostname;

  String get ip => _ip;
  String get os => _os;
  int get cpuCore => _cpuCore;
  String get hostname => _hostname;

}