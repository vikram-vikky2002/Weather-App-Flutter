import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_intern_app/src/constants/app_colors.dart';
import 'package:google_intern_app/src/features/weather/application/providers.dart';
import 'package:google_intern_app/src/features/weather/application/sharedPref.dart';

class CitySearchBox extends ConsumerStatefulWidget {
  const CitySearchBox({super.key});
  @override
  ConsumerState<CitySearchBox> createState() => _CitySearchRowState();
}

class _CitySearchRowState extends ConsumerState<CitySearchBox> {
  static const _radius = 30.0;

  late final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.text = ref.read(cityProvider);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextField(
                controller: _searchController,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.transparent,
                ),
                // decoration: InputDecoration(
                //   fillColor: Color.fromARGB(184, 255, 255, 255),
                //   filled: true,
                //   border: OutlineInputBorder(
                //     borderRadius: BorderRadius.circular(20),
                //   ),
                // ),
                onSubmitted: (value) {
                  ref.read(cityProvider.notifier).state = value;
                },
              ),
            ),
            IconButton(
                onPressed: () async {
                  await SharedPreferencesUtil()
                      .saveCityName(_searchController.text);
                  FocusScope.of(context).unfocus();
                  ref.read(cityProvider.notifier).state =
                      _searchController.text;
                },
                icon: Icon(
                  Icons.search,
                ))

            // InkWell(
            //   child: Container(
            //     alignment: Alignment.center,
            //     decoration: const BoxDecoration(
            //       color: AppColors.accentColor,
            //       borderRadius: BorderRadius.only(
            //         topRight: Radius.circular(_radius),
            //         bottomRight: Radius.circular(_radius),
            //       ),
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 15.0),
            //       child: Text('search',
            //           style: Theme.of(context).textTheme.bodyLarge),
            //     ),
            //   ),
            // onTap: () async {
            //   print(_searchController.text);
            //   await SharedPreferencesUtil()
            //       .saveCityName(_searchController.text);
            //   FocusScope.of(context).unfocus();
            //   ref.read(cityProvider.notifier).state = _searchController.text;
            // },
            // )
          ],
        ),
      ),
    );
  }
}
