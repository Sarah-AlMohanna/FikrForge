//
//
// import 'package:flutter/material.dart';
// import 'package:forgeapp/configuration/theme.dart';
//
// class CustomDropdown extends StatefulWidget {
//   String? title ;
//   String? selectedValue = "" ;
//   List<String>? data ;
//   Function(String)? onSelect ;
//   CustomDropdown({this.title, this.selectedValue, this.data , this.onSelect});
//
//   @override
//   _CustomDropdownState createState() => _CustomDropdownState();
// }
//
// class _CustomDropdownState extends State<CustomDropdown> {
//   // String selectedValue = ''; // Initialize with an empty string
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: size_W(120),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15.0),
//           color: Theme_Information.Color_1,
//           border: Border.all(
//               color: Theme_Information.Primary_Color,
//               width: 1.0,
//           ),
//         ),
//       child:
//       DropdownButtonFormField(
//         value: widget.selectedValue!.isNotEmpty ? widget.selectedValue : null, // Use null when no selection
//         isExpanded: true,
//         onChanged: (newValue) {
//           setState(() {
//             widget.selectedValue = newValue ?? "";
//             if(widget.onSelect != null) {
//               widget.onSelect!(newValue!);
//             }
//           });
//         },
//         decoration: InputDecoration(
//           hintText: '${widget.title}', // Hint text when nothing is selected
//           hintStyle: ourTextStyle(),
//           fillColor: Theme_Information.Color_1,
//           contentPadding: EdgeInsets.all(12),
//
//           border: InputBorder.none
//         ),
//         // items: items(),
//         items: List.generate(widget.data!.length, (index) {
//           final item = widget.data![index];
//           return   DropdownMenuItem(
//             value: '${item}',
//             child: Text('${item}', maxLines: 1,  style: ourTextStyle(fontSize: 12),),
//           );
//         }),
//
//       )
//       ,
//     );
//   }
//
// }