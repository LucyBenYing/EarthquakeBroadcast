import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

 enum LoginType {
   register,//注册
   login,//登录
   changePassword,//修改密码
 }

class LoginPageApp extends StatelessWidget {
  final LoginType loginType;
  LoginPageApp({Key key,@required this.loginType}) : super(key: key);
  
  String _getTitle(){
    String title;
    switch (loginType) {
      case LoginType.register:
      {
        title = "注册";
        break;
      }
      case LoginType.login:
      {
        title = "登录";
        break;
      }
      case LoginType.changePassword:
      {
        title  = "修改密码";
        break;
      }
      default:
      {
        title = '';
        break;
      }
    }
    return title;
  }

  @override
  Widget build(BuildContext context) {
   
 return new Scaffold(
   appBar: new AppBar(
     title: new Text('${_getTitle()}') ,
   ),
   body: new LoginPageView(loginType: loginType),
  );
  }

}

class LoginPageView extends StatelessWidget {
  final LoginType loginType;
  LoginPageView({Key key,@required this.loginType}) : super(key: key); 
  @override
  Widget build(BuildContext context) { 
    return new  InputWidget(loginType: loginType);
  }

}

 
 
class InputWidget extends StatefulWidget {
  final LoginType loginType;
  InputWidget({Key key,@required this.loginType}) : super(key: key); 
  @override
  State<StatefulWidget> createState() { 
  return new _InputWidgetState( loginType);
  }
}

class _InputWidgetState extends State<InputWidget> {
  
   
  _InputWidgetState(this.loginType);
  LoginType loginType; 
  final String mUserName = 'username';
  final String mPassword = 'password';
    //  final string 
  final TextEditingController _namecontroller = new TextEditingController();
  final TextEditingController _passwordcontroller = new TextEditingController();
  final TextEditingController _confirmPasswordcontroller = new TextEditingController();
  var userName;
  var password;
  

  save(String uaerName, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString( mUserName,  uaerName);
    prefs.setString( mPassword, password);
  }

  Future<String> getUserName() async { 
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userName = prefs.getString(mUserName);
    if(userName != null ){
      setState(() {
        _namecontroller.text = userName;
          userName = userName;
        });
    }
    return userName;
  }

  Future<String> getPassword() async {
  var password;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  password = prefs.getString(mPassword);
  if (password != null) {
    setState(() {
      _passwordcontroller.text = password;
        password = password;
      });
  }
  return password;
}

  Widget _loginWidget (BuildContext context){
    return new Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[ 
      new TextField(
        controller: _namecontroller,
        decoration: new InputDecoration(
          contentPadding: new EdgeInsets.symmetric(vertical: 20.0),
          icon: new Icon(Icons.perm_identity),
          labelText: "请输入用户名:", 
          
        ), 
      ),
        new TextField(
        controller: _passwordcontroller,
        decoration: new InputDecoration(
          contentPadding: new EdgeInsets.symmetric(vertical: 20.0),
          icon: new Icon(Icons.perm_phone_msg),
          labelText: "请输入密码:", 
        ),
        obscureText: true,
      ),
      new RaisedButton(
        onPressed: (){
final name = _namecontroller.value.text.toString();
final pass = _passwordcontroller.value.text.toString();
if (name.length > 0 && pass.length > 0) {
  
  save(name , pass);
 Navigator.pushNamedAndRemoveUntil(
   context,
   '/', 
    (Route route) => false);
} else  
          showDialog(
            context: context,
            builder: (BuildContext context) => new AlertDialog(
              title: new Text('请输入用户名或密码'),
              content: new Text('name:${_namecontroller.text},password${_passwordcontroller.text}'),
            ),
          );
         
        },
        child: new Text('登录'),
      ),
       new RaisedButton(
        onPressed: (){
          Navigator.of(context).pushNamed('/register');
        },
        child: new Text('注册'),
      ),
      new RaisedButton(
        onPressed: (){
          Navigator.of(context).pushNamed('/changePassword');
        },
        child: new Text('修改密码'),
      ),
    ]);
  }
  Widget _registerWidget (BuildContext context){
    return new Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
        // _getuserName(context),
            new TextField(
              onChanged: (String content){
                print('$content');
              },
        controller: _namecontroller,
        decoration: new InputDecoration(
          contentPadding: new EdgeInsets.symmetric(vertical: 20.0),
          icon: new Icon(Icons.perm_identity),
          labelText: "请输入用户名:", 
        ), 
      ),
        new TextField(
        controller: _passwordcontroller,
        decoration: new InputDecoration(
          contentPadding: new EdgeInsets.symmetric(vertical: 20.0),
          icon: new Icon(Icons.perm_phone_msg),
          labelText: "请输入密码:", 
        ),
        obscureText: true,
        ),
         new TextField(
        controller: _confirmPasswordcontroller,
        decoration: new InputDecoration(
          contentPadding: new EdgeInsets.symmetric(vertical: 20.0),
          icon: new Icon(Icons.perm_phone_msg),
          labelText: "请确认密码:", 
        ),
        obscureText: true,
      ),
      new RaisedButton(
        onPressed: (){
          // save();
         Navigator.of(context).pushNamed('/login');
        },
        child: new Text('立即注册'),
      ),
    ]);
  }
Widget _changePassword(BuildContext context){ 
    return new Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
        // _getuserName(context),
            new TextField(
              onChanged: (String content){
                print('$content');
              },
        controller: _namecontroller,
        decoration: new InputDecoration(
          contentPadding: new EdgeInsets.symmetric(vertical: 20.0),
          icon: new Icon(Icons.perm_identity),
          labelText: "请输入旧密码:", 
        ), 
        obscureText: true,
      ),
        new TextField(
        controller: _passwordcontroller,
        decoration: new InputDecoration(
          contentPadding: new EdgeInsets.symmetric(vertical: 20.0),
          icon: new Icon(Icons.perm_phone_msg),
          labelText: "请新输入密码:", 
        ),
        obscureText: true,
        ),
         new TextField(
        controller: _confirmPasswordcontroller,
        decoration: new InputDecoration(
          contentPadding: new EdgeInsets.symmetric(vertical: 20.0),
          icon: new Icon(Icons.perm_phone_msg),
          labelText: "请确认密码:", 
        ),
        obscureText: true,
      ),
      new RaisedButton(
        onPressed: (){
           Navigator.of(context).pushNamed('/login');
        },
        child: new Text('确认'),
      ),
    ]);
  }
  
  @override
  Widget build(BuildContext context) {
 

    print('$loginType');
     switch (loginType) {
      case LoginType.register:
      {
       return _registerWidget(context); 
      }
      case LoginType.login:
      {
        getUserName();
        getPassword();
        return _loginWidget(context);
      }
      case LoginType.changePassword:
      {
        return _changePassword(context);
      }
      default:
      {
        return _loginWidget(context); 
      }
    } 
  }

}
