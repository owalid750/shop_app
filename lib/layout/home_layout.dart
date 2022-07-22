import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/screens/login/login_screen.dart';
import 'package:shop_app/screens/search/search.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayOutCubit, LayOutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        //
        var cubit = LayOutCubit.get(context);
        //
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Salla",
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTO(context, SearchScrean());
                  },
                  icon: Icon(Icons.search))
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
              items: cubit.items,
              currentIndex: cubit.selectedIndex,
              onTap: (index) {
                cubit.changeBottomNavBarIndex(index);
              }),
          body: cubit.screans[cubit.selectedIndex],
        );
      },
    );
  }
}
