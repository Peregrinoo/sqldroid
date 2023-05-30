//                                                Deus seja louvado !!!

// ignore_for_file: unnecessary_getters_setters

enum ConnectionType{
  wifi,
  bluetooth,
  radio,
}


class Connection{

  //Classe responsavel por gerenciar os tipos de conexões que nós temos, radio, wifi e bluetooth para cada rede !

  String _serverAddress = "";
  String serverPort = "";

  ConnectionType? connectionType;


  //Singleton;
  Connection._();

  Connection(ConnectionType cn){
    connectionType = cn;
  }

  String get serverAddress => _serverAddress;

  set serverAddress(String value) {
    _serverAddress = value;
  }

  static final Connection getConnection = Connection._();

}



