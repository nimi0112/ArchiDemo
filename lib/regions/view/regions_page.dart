import 'package:arch_demo/regions/bloc/regions_bloc.dart';
import 'package:arch_demo/regions/view/city_item.dart';
import 'package:arch_demo/regions/view/country_item.dart';
import 'package:arch_demo/regions/view/state_item.dart';
import 'package:arch_demo/uiconstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regions_data/regions_data.dart';
import 'package:regions_domain/regions_domain.dart';

class RegionsPage extends StatelessWidget {
  const RegionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final aP = ApiProvider();
    return BlocProvider(
      create: (_) => RegionsBloc(
        apiProvider: aP,
        regionUseCase: RegionUseCase(aP),
      ),
      child: const RegionsView(),
    );
  }
}

class RegionsView extends StatefulWidget {
  const RegionsView({super.key});

  @override
  State<RegionsView> createState() => _CounterViewState();
}

class _CounterViewState extends State<RegionsView> {
  @override
  void initState() {
    super.initState();
    context.read<RegionsBloc>().add(GetCountriesList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          'Country State City DB Demo',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: interBold,
            fontFamily: fontInter,
          ),
        )),
        backgroundColor: Colors.white,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 150, vertical: 50),
          child: BlocBuilder<RegionsBloc, RegionsState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 400,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(.2))),
                    child: Column(
                      children: [
                        Text(
                          'Countries ${state.countries.length}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: interBold,
                            fontFamily: fontInter,
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.black.withOpacity(.1),
                        ),
                        const SizedBox(height: 5),
                        state.isCountriesLoading
                            ? Expanded(child: CircularProgressIndicator())
                            : Expanded(
                                child: ListView.separated(
                                  itemCount: state.countries.length,
                                  shrinkWrap: true,
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          Divider(
                                    height: 1,
                                    color: Colors.black.withOpacity(.1),
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return CountryItem(
                                        country: state.countries[index]);
                                  },
                                ),
                              )
                      ],
                    ),
                  ),
                  Container(
                    width: 400,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(.2))),
                    child: Column(
                      children: [
                        Text(
                          'States ${state.states.length}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: interBold,
                            fontFamily: fontInter,
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.black.withOpacity(.1),
                        ),
                        const SizedBox(height: 5),
                        state.isStatesLoading
                            ? Center(child: CircularProgressIndicator())
                            : Expanded(
                                child: ListView.separated(
                                  itemCount: state.states.length,
                                  shrinkWrap: true,
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          Divider(
                                    height: 1,
                                    color: Colors.black.withOpacity(.1),
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return RegionStateItem(
                                        state: state.states[index]);
                                  },
                                ),
                              )
                      ],
                    ),
                  ),
                  Container(
                    width: 400,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(.2))),
                    child: Column(
                      children: [
                        Text(
                          'Cities ${state.cities.length}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: interBold,
                            fontFamily: fontInter,
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.black.withOpacity(.1),
                        ),
                        const SizedBox(height: 5),
                        state.isCitiesLoading
                            ? Center(child: CircularProgressIndicator())
                            : Expanded(
                                child: ListView.separated(
                                  itemCount: state.cities.length,
                                  shrinkWrap: true,
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          Divider(
                                    height: 1,
                                    color: Colors.black.withOpacity(.1),
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return CityItem(city: state.cities[index]);
                                  },
                                ),
                              )
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }
}
