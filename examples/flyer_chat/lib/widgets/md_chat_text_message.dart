// import 'package:flutter/material.dart';
// import 'package:flutter_chat_core/flutter_chat_core.dart';
// import 'package:provider/provider.dart';
// import 'package:markdown_widget/markdown_widget.dart';

// import 'code_wrapper.dart';

// class ChatToolButton extends StatelessWidget {
//   final IconData icon;
//   final double? iconSize;
//   final Color? iconColor;
//   final VoidCallback? onPressed;

//   const ChatToolButton({
//     super.key,
//     required this.icon,
//     this.iconSize = 20,
//     this.iconColor,
//     this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       icon: Icon(
//         icon,
//         size: iconSize,
//         color: iconColor ?? Colors.grey[400],
//       ),
//       onPressed: onPressed,
//     );
//   }
// }

// class MdChatTextMessage extends StatelessWidget {
//   final TextMessage message;
//   final int index;
//   final EdgeInsetsGeometry? padding;
//   final BorderRadiusGeometry? borderRadius;
//   final double? onlyEmojiFontSize;
//   final Function(TextMessage)? onLongPress;
//   final List<Widget>? toolbarButtons;

//   static const _bubbleRadius = BorderRadius.all(Radius.circular(12));
//   static const _codeBlockRadius = BorderRadius.all(Radius.circular(8));
//   static const _defaultPadding = EdgeInsets.symmetric(horizontal: 4, vertical: 4);

//   const MdChatTextMessage({
//     super.key,
//     required this.message,
//     required this.index,
//     this.padding = const EdgeInsets.symmetric(
//       horizontal: 4,
//       vertical: 4,
//     ),
//     this.borderRadius = const BorderRadius.all(Radius.circular(12)),
//     this.onlyEmojiFontSize = 48,
//     this.onLongPress,
//     this.toolbarButtons,
//   });

//   PreConfig _getPreConfig(bool isDark) {
//     final language = RegExp(r'```(.*?)\n', dotAll: true).firstMatch(message.text)?.group(1) ?? 'javascript';
//     final baseConfig = isDark ? PreConfig.darkConfig : const PreConfig();

//     return baseConfig.copy(
//       textStyle: const TextStyle(fontSize: 14),
//       decoration: BoxDecoration(
//         color: isDark ? const Color(0xFF1b1b1b) : const Color.fromRGBO(105, 145, 214, 0.1215686275),
//         borderRadius: const BorderRadius.all(Radius.circular(8)),
//       ),
//       // theme: isDark ? githubDarkDimmedTheme : githubTheme,
//       wrapper: (child, code, language) => CodeWrapperWidget(child, code, language),
//       language: language,
//     );
//   }

//   BoxDecoration _getBubbleDecoration(bool isSentByMe, bool isDark) {
//     return BoxDecoration(
//       color: isSentByMe ? const Color(0xFF3B8AFF) : (isDark ? const Color(0xFF2C2C2C) : Colors.white),
//       borderRadius: _bubbleRadius,
//       border: Border.all(
//         color: isSentByMe ? Colors.transparent : (isDark ? Colors.grey[800]! : Colors.grey[300]!),
//         width: 0.3,
//       ),
//       boxShadow: const [
//         BoxShadow(
//           color: Colors.black12,
//           blurRadius: 1,
//           spreadRadius: 0,
//           offset: Offset(0, 0.5),
//         ),
//       ],
//     );
//   }

//   Widget _buildToolbar() {
//     if (toolbarButtons == null || toolbarButtons!.isEmpty) {
//       return const SizedBox.shrink();
//     }

//     return Container(
//       height: 40,
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: toolbarButtons!,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final textMessageTheme = context.select((ChatTheme theme) => theme.textMessageTheme);
//     final isSentByMe = context.watch<User>().id == message.author.id;
//     final paragraphStyle = isSentByMe ? textMessageTheme.sentTextStyle : textMessageTheme.receivedTextStyle;
//     print(message.text);
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final markdownConfig = (isDark ? MarkdownConfig.darkConfig : MarkdownConfig.defaultConfig).copy(
//       configs: [
//         PConfig(
//           textStyle: TextStyle(
//             fontSize: 16,
//             color: paragraphStyle?.color,
//           ),
//         ),
//         _getPreConfig(isDark),
//         const CodeConfig(
//           style: TextStyle(
//             inherit: false,
//             backgroundColor: Colors.transparent,
//             fontWeight: FontWeight.bold,
//             color: Colors.green,
//           ),
//         ),
//       ],
//     );

//     return GestureDetector(
//       onLongPress: () => onLongPress?.call(message),
//       child: Container(
//         padding: EdgeInsets.only(
//           left: isSentByMe ? 32 : 4,
//           right: 8,
//           top: 4,
//           bottom: 4,
//         ),
//         child: Container(
//           decoration: (message.isOnlyEmoji ?? false) ? null : _getBubbleDecoration(isSentByMe, isDark),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: MarkdownWidget(
//                   key: ValueKey('${index}_md_msg'),
//                   data: message.text,
//                   shrinkWrap: true,
//                   selectable: true,
//                   padding: EdgeInsets.zero,
//                   config: markdownConfig,
//                 ),
//               ),
//               if (!isSentByMe) _buildToolbar(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
