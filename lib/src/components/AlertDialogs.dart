import 'package:flutter/material.dart';
import 'package:project_kidplanner/src/classes/user.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:project_kidplanner/src/libraries/globals.dart' as globals;
import 'dart:math';

mixin AlertDialogs {
  static Future<void> askNameDialog(context, _keyDialogForm, setState) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('HP_AlertDialog_Title').tr(),
          content: SingleChildScrollView(
            child: Form(
              key: _keyDialogForm,
              child: ListBody(
                children: <Widget>[
                  TextFormField(
                    textAlign: TextAlign.center,
                    onSaved: (val) {
                      globals.currentParticipant.name = val;
                      Participant()
                          .insertParticipant(globals.currentParticipant);
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: tr('HP_AlertDialog_Form_LabelText'),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return tr('HP_AlertDialog_Form_ValidationText');
                      }
                      return null;
                    },
                  )
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('General_go').tr(),
              onPressed: () {
                if (_keyDialogForm.currentState!.validate()) {
                  _keyDialogForm.currentState!.save();
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> verifyParentDialog(
      context, _keyDialogForm, setState) async {
    var rng = Random();
    var l = List.generate(3, (_) => rng.nextInt(5) + rng.nextInt(5));
    String question = tr('verifyParentDialog.question') +
        ((l[0]).toString() + '*' + l[1].toString() + '+' + l[2].toString());
    num goodAnswer = l[0] * l[1] + l[2];
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text('verifyParentDialog.title').tr(),
            content: SingleChildScrollView(
              child: Form(
                key: _keyDialogForm,
                child: ListBody(
                  children: <Widget>[
                    Text(question),
                    TextFormField(
                      textAlign: TextAlign.center,
                      onSaved: (value) {
                        setState(() {});
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ], // Only numbers can be entered
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: tr('verifyParentDialog.placeholder'),
                      ),
                      autovalidateMode: AutovalidateMode.disabled,
                      validator: (value) {
                        if (value!.isNotEmpty &&
                            (int.parse(value.toString()) ==
                                goodAnswer.toInt())) {
                          return null;
                        }
                        return tr('verifyParentDialog.validation');
                      },
                    )
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              Column(children: <Widget>[
                TextButton(
                  child: const Text('verifyParentDialog.validate').tr(),
                  onPressed: () {
                    if (_keyDialogForm.currentState!.validate()) {
                      _keyDialogForm.currentState!.save();
                      Navigator.pop(context);
                    }
                  },
                ),
                TextButton(
                  child: Text(
                    tr('verifyParentDialog.go_back'),
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ]),
            ]);
      },
    );
  }
}
