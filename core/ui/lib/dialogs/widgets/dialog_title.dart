import 'package:flutter/material.dart';

class DialogTittle extends StatelessWidget {
  const DialogTittle(this.title, this.onClose, {Key? key}) : super(key: key);

  final String? title;
  final Function onClose;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onClose as void Function()?,
          child: const Icon(Icons.close, color: Colors.black, size: 30,),
        ),
        Expanded(
            child: Text(
              title!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 25, fontWeight: FontWeight.bold),
            )
        ),
        Container(width: 30,),
      ],
    );
  }

}