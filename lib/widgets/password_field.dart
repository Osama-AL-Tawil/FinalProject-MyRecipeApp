import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




class PasswordToggleProvider extends ChangeNotifier {
  bool status = true;

  bool getStatus() {
    return status;
  }
  updateStatus() {
    status = !status;
    notifyListeners();
  }

}

class PasswordFieldWidget extends StatelessWidget {
  final String hintText;
  final double? radius;
  final double? marginBottom;
  final ValueChanged<String> onChanged;
   const PasswordFieldWidget(
      {Key? key,
      required this.hintText,
      required this.onChanged,
      this.marginBottom = 20,
      this.radius = 30})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var toggleStatus = Provider.of<PasswordToggleProvider>(context,listen: true).status;

    return Container(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(children: [
        TextField(
          obscureText: toggleStatus,
          decoration: InputDecoration(
              hintText:hintText ,
              suffixIcon: IconButton(
                  icon: Icon(
                      toggleStatus ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    Provider.of<PasswordToggleProvider>(context,listen: false).updateStatus();
                  }),
              contentPadding: const EdgeInsets.all(15),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius!))),
          onChanged: onChanged,
        ),
        SizedBox(
          height: marginBottom,
        ),
      ]),
    );
  }
}
