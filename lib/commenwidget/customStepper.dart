import 'package:flutter/material.dart';
import 'package:forgeapp/configuration/theme.dart';

// class CustomStepper extends StatefulWidget {
//   final List<Step> steps;
//   final int currentStep;
//   final void Function(int)? onStepTapped;
//   final void Function()? onStepContinue;
//   final void Function()? onStepCancel;
//   final Widget? customStep;
//
//   CustomStepper({
//     required this.steps,
//     required this.currentStep,
//     this.onStepTapped,
//     this.onStepContinue,
//     this.onStepCancel,
//     this.customStep,
//   });
//
//   @override
//   _CustomStepperState createState() => _CustomStepperState();
// }
//
// class _CustomStepperState extends State<CustomStepper> {
//   @override
//   Widget build(BuildContext context) {
//     return Stepper(
//       steps: widget.steps,
//       currentStep: widget.currentStep,
//       onStepTapped: widget.onStepTapped,
//       onStepContinue: widget.onStepContinue ?? ()=> print("onStepContinue"),
//       onStepCancel: widget.onStepCancel ?? ()=> print("onStepCancel"),
//       controlsBuilder: (BuildContext context, ControlsDetails details) {
//         return widget.customStep ??
//             Row(
//               children: <Widget>[
//                 MaterialButton(
//                   onPressed: widget.onStepContinue,
//                   color: Colors.green,
//                   child: const Text('Continue'),
//                 ),
//                 MaterialButton(
//                   onPressed: widget.onStepCancel,
//                   color: Colors.red,
//                   child: const Text('Cancel'),
//                 ),
//               ],
//             );
//       },
//     );
//   }
// }


class CustomStepper extends StatefulWidget {
  final List<Step> steps;
  final int currentStep;
  final String cancelText;
  final String continueText;
  final void Function(int)? onStepTapped;
  final void Function()? onStepContinue;
  final void Function()? onStepCancel;
  final Widget? customStep;

  CustomStepper({
    required this.steps,
    required this.currentStep,
    this.onStepTapped,
    this.onStepContinue,
    this.onStepCancel,
    this.customStep,
    this.cancelText = "",
    this.continueText = "",
  });

  @override
  _CustomStepperState createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: Theme_Information.Primary_Color,
        ),
      ),
      child: Stepper(
        steps: widget.steps,
        currentStep: widget.currentStep,
        onStepTapped: widget.onStepTapped ?? (index) {},
        onStepContinue: widget.onStepContinue ?? () {},
        onStepCancel: widget.onStepCancel ?? () {},
        controlsBuilder: (BuildContext context, ControlsDetails controls) {
          return widget.customStep ??
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      onPressed: controls.onStepCancel,
                      color: Theme_Information.Second_Color,
                      child: Text(widget.cancelText , style: ourTextStyle(color: Colors.white , ),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      onPressed: controls.onStepContinue,
                      color: Theme_Information.Primary_Color,
                      child: Text(widget.continueText , style: ourTextStyle(color: Colors.white , ),),
                    ),
                  ),

                ],
              );
        },
      ),
    );
  }
}

