import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regions_data/regions_data.dart';

import '../../uiconstants.dart';
import '../bloc/regions_bloc.dart';

class CountryItem extends StatelessWidget {
  const CountryItem({
    Key? key,
    required this.country,
  }) : super(key: key);

  final Country country;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context
            .read<RegionsBloc>()
            .add(GetStatesList(countryName: country.name));
      },
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
                            text: country.unicodeFlag, // non-emoji characters
                            style: const TextStyle(
                              fontFamily: fontNotoColorEmoji,
                            ),
                          ),
                          TextSpan(
                              text: ' ${country.name}',
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
                  Container(
                    margin: EdgeInsets.only(left: 5, right: 10),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 238, 242, 246),
                        shape: BoxShape.circle),
                    child: Text(country.iso2,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: interMedium,
                          fontFamily: fontInter,
                        )),
                  )
                ],
              ),
            ),
            Container(
                decoration: BoxDecoration(
                    color: Colors.pink.withOpacity(.8), shape: BoxShape.circle),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}
