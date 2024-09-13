import 'package:flutter/material.dart';


class EntityPage extends StatelessWidget {
	const EntityPage({
		required this.content,
		this.actions
	});

	final List<Widget> content;
	final List<Widget>? actions;

	@override
	Widget build(BuildContext context) {
		return Scaffold(body: Stack(
			children: [
				Column(
					mainAxisAlignment: MainAxisAlignment.center,
					crossAxisAlignment: CrossAxisAlignment.start,
					children: content
				),
				if (actions != null) SafeArea(
					child: Row(
						mainAxisAlignment: MainAxisAlignment.end,
						children: actions!
					)
				)
			]	
		));
	}
}
