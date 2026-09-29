import 'package:flutter/material.dart';
import 'package:site_bmr_transport/common/widget.dart';

class Mycarcard extends StatefulWidget {
  final String name;
  final String description;
  final String imgUrl;
  final int placeNumber;
  final int suitcaseNumber;
  final ValueChanged<Mycarcard>? onSelected;
  final bool isSelected;

  const Mycarcard({
    super.key,
    required this.name,
    required this.description,
    required this.imgUrl,
    required this.placeNumber,
    required this.suitcaseNumber,
    this.onSelected,
    required this.isSelected,
  });

  @override
  State<Mycarcard> createState() => _MycarcardState();
}

class _MycarcardState extends State<Mycarcard> {
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
      child: Material(
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        color: widget.isSelected
            ? Theme.of(context).primaryColorLight
            : (!_isHover ? null : Theme.of(context).primaryColor),
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
            setState(() {
              _isHover = !_isHover;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Image.network(
                  width: 200,
                  height: 160,
                  "${widget.imgUrl}.jpg",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.car_crash, size: 40),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        myTitleText(widget.name, 20),
                        mySubTitleText(widget.description, 10),
                        mydoubleText(
                          "Places: ",
                          widget.placeNumber.toString(),
                          10,
                        ),
                        mydoubleText(
                          "bagages: ",
                          widget.suitcaseNumber.toString(),
                          10,
                        ),
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
