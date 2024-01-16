import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({super.key, required this.snap});
  final snap;
  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      elevation: 1,
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, bottom: 12, top: 12),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(widget.snap['profilePic']),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: widget.snap['userName'],
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                          TextSpan(
                            text: ' : ' + widget.snap['comment'],
                          ),
                        ]),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          DateFormat('dd-MM-yyyy')
                              .format(widget.snap['datePublished'].toDate())
                              .toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 12),
                        ),
                      )
                    ]),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_border,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
