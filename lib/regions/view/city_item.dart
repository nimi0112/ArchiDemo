import 'package:flutter/material.dart';

import '../../uiconstants.dart';

class CityItem extends StatelessWidget {
  const CityItem({
    required this.city,
    Key? key,
  }) : super(key: key);

  final String city;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 30,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: city,
                              style: TextStyle(
                                color: Colors.black.withOpacity(.8),
                                fontSize: 20,
                                fontWeight: interMedium,
                                fontFamily: fontInter,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
