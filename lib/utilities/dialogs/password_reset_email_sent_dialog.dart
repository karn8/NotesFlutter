import 'package:flutter/material.dart';
import 'package:mynote/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context){
  return showGenericDialog<void>(
    context: context, 
    title: "Password Reset", 
    content: "Password reset link was sent to your email id.", 
    optionsBuilder: () => {
      'OK': null}
    );
}