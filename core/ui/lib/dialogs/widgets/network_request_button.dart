import 'package:flutter/material.dart';
import 'package:ui/dialogs/widgets/dialog_button.dart';

//ignore: must_be_immutable
class NetworkRequestButton extends StatefulWidget{
  NetworkRequestButton(this.text,this.color,this.onClick, {Key? key}) : super(key: key);

  final String? text;
  final Color color;
  final Function(BuildContext?) onClick;

  bool isClicked = false;
  State<StatefulWidget>? state;
  bool disabled = false;

  void onComplete(){
    disabled = false;
    (state as _NetworkRequestButtonState).resetButton();
  }

  @override
  State<StatefulWidget> createState() => _NetworkRequestButtonState();

  NetworkRequestButton setState(bool value) {
    disabled = !value;
    if(state != null) (state! as _NetworkRequestButtonState).resetButton();
    return this;
  }

  NetworkRequestButton disable() {
    disabled = true;
    if(state != null) (state! as _NetworkRequestButtonState).resetButton();
    return this;
  }

  NetworkRequestButton enable() {
    disabled = false;
    if(state != null) (state! as _NetworkRequestButtonState).resetButton();
    return this;
  }
}

class _NetworkRequestButtonState extends State<NetworkRequestButton>{

  BuildContext? lastContext;

  @override
  Widget build(BuildContext context) {

    lastContext = context;
    widget.state = this;

    if(widget.isClicked) {
      return const CircularProgressIndicator();
    } else {
      return DialogButton(widget.text, widget.disabled ? Colors.blue : widget.color, widget.disabled ? (buildContext) {} : onClick, fontSize: 20,);
    }
  }

  void onClick(BuildContext context){
    setState(() => widget.isClicked = true);
    widget.onClick.call(lastContext);
  }

  void resetButton(){
    setState(() => widget.isClicked = false);
  }

}