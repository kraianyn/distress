import 'package:flutter/material.dart';


// class EntityList<E> extends StatelessWidget {
// 	const EntityList(
// 		this.entities, {
// 			required this.tileBuilder
// 		}
// 	);

// 	final List<E> entities;
// 	final Widget Function(E) tileBuilder;

// 	@override
// 	Widget build(BuildContext context) {
// 		return ListView(
// 			children: entities.map(tileBuilder).toList()
// 		);
// 	}
// }

class EntityTile extends StatelessWidget {
	const EntityTile({
		required this.title,
		this.subtitle,
		this.trailing,
		required this.pageBuilder
	});

	final String title;
	final String? subtitle;
	final String? trailing;
	final Widget Function(BuildContext) pageBuilder;

	@override
	Widget build(BuildContext context) {
		return ListTile(
			title: Text(title),
			trailing: trailing != null ? Text(trailing!) : null,
			onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: pageBuilder))
		);
	}
}
