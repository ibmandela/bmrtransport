import 'package:flutter/material.dart';
import 'package:site_bmr_transport/common/widget.dart';

class MycategoryCard extends StatefulWidget {
  const MycategoryCard({
    super.key,
    required this.name,
    required this.description,
    required this.imgUrl,
    required this.onSelected,
    required this.isSelected,
  });
  final String name;
  final String description;
  final String imgUrl;
  final ValueChanged<MycategoryCard>? onSelected;
  final bool isSelected;

  @override
  State<MycategoryCard> createState() => _MycategoryCardState();
}

class _MycategoryCardState extends State<MycategoryCard> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      // width: 40,
      // height: 50,
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.only(
        top: (_isHover) ? 3 : 5,
        bottom: !(_isHover) ? 3 : 5,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 3),
        child: Material(
          elevation: 10,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          color: widget.isSelected
              ? Theme.of(context).primaryColorLight
              : (_isHover ? Theme.of(context).primaryColor : null),
          // elevation: 5,
          // child: SizedBox(
          //   height: 45,
          //   width: 45,
          child: InkWell(
            onHover: (val) {
              setState(() {
                _isHover = val;
              });
            },
            onTap: () {
              widget.onSelected?.call(widget);
            },
            child: Row(
              children: [
                Expanded(
                  child: Image.network(
                    width: 120,
                    height: 80,
                    "${widget.imgUrl}.jpg",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.car_crash, size: 40),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        myTitleText(widget.name, 20),
                        mySubTitleText(widget.description, 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
