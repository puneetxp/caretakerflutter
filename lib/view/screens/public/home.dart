import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class MyHomePageScreen extends StatefulWidget {
  const MyHomePageScreen({super.key, required this.title});

  final String title;

  @override
  State<MyHomePageScreen> createState() => _MyHomePageScreenState();
}

class _MyHomePageScreenState extends State<MyHomePageScreen> {
  /// After a click, increment the counter state and
  /// asynchronously save it to persistent storage.

  @override
  Widget build(BuildContext context) {
    const double gap = 10;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final router = GoRouter.of(context);
    return Scaffold(
        body: ListView(children: <Widget>[
      Container(
          color: Color.fromARGB(84, 105, 176, 39),
          width: width,
          height: height > 450 ? 400 : height - 40,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Center(
                child: Wrap(
              children: [
                Text(
                  "Start You Experience",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )),
            const SizedBox(height: gap),
            Center(
              child: FilledButton.tonal(
                onPressed: () {
                  router.go('/login');
                },
                child: const Text('Get Start'),
              ),
            )
          ])),
      const Center(
          child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        runSpacing: smallSpacing,
        spacing: smallSpacing,
        children: <Widget>[
          Card(child: _SampleCard(cardName: 'Elevated Card')),
          Card(child: _SampleCard(cardName: 'Elevated Card')),
          Card(child: _SampleCard(cardName: 'Elevated Card')),
          Card(child: _SampleCard(cardName: 'Elevated Card')),
          Card(child: _SampleCard(cardName: 'Elevated Card')),
          SizedBox(height: gap),
          Card(child: _SampleCard(cardName: 'Filled Card')),
          SizedBox(height: gap),
          Card(child: _SampleCard(cardName: 'Outlined Card')),
          SizedBox(height: gap),
        ],
      ))
    ]));
  }
}

class _SampleCard extends StatelessWidget {
  const _SampleCard({required this.cardName});
  final String cardName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 100,
      child: Center(child: Text(cardName)),
    );
  }
}

// class ComponentDecoration extends StatefulWidget {
//   const ComponentDecoration({
//     super.key,
//     required this.label,
//     required this.child,
//     this.tooltipMessage = '',
//   });

//   final String label;
//   final Widget child;
//   final String? tooltipMessage;

//   @override
//   State<ComponentDecoration> createState() => _ComponentDecorationState();
// }

const rowDivider = SizedBox(width: 20);
const colDivider = SizedBox(height: 10);
const tinySpacing = 3.0;
const smallSpacing = 10.0;
const double cardWidth = 115;
const double widthConstraint = 450;

// class _ComponentDecorationState extends State<ComponentDecoration> {
//   final focusNode = FocusNode();

//   @override
//   Widget build(BuildContext context) {
//     return RepaintBoundary(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: smallSpacing),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(widget.label,
//                     style: Theme.of(context).textTheme.titleSmall),
//                 Tooltip(
//                   message: widget.tooltipMessage,
//                   child: const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 5.0),
//                       child: Icon(Icons.info_outline, size: 16)),
//                 ),
//               ],
//             ),
//             ConstrainedBox(
//               constraints:
//                   const BoxConstraints.tightFor(width: widthConstraint),
//               // Tapping within the a component card should request focus
//               // for that component's children.
//               child: Focus(
//                 focusNode: focusNode,
//                 canRequestFocus: true,
//                 child: GestureDetector(
//                   onTapDown: (_) {
//                     focusNode.requestFocus();
//                   },
//                   behavior: HitTestBehavior.opaque,
//                   child: Card(
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(
//                       side: BorderSide(
//                         color: Theme.of(context).colorScheme.outlineVariant,
//                       ),
//                       borderRadius: const BorderRadius.all(Radius.circular(12)),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 5.0, vertical: 20.0),
//                       child: Center(
//                         child: widget.child,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
