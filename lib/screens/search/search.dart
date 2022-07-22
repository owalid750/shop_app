import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shop_app/models/get_favorite_model.dart';
// import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/screens/search/cubit/cubit.dart';
import 'package:shop_app/screens/search/cubit/states.dart';


import '../../layout/cubit/cubit.dart';
import '../../shared/styles/colors.dart';

class SearchScrean extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((context) => SearchCubit()),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                  key: formKey,
                  child: Column(children: [
                    TextFormField(
                      controller: searchController,
                      onFieldSubmitted: (String? text) {
                        SearchCubit.get(context).getSearchData(text);
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        label: Text("search"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    if (state is SearchLoadingData) LinearProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    if (state is SearchDataSuccess)
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => buildSearchItem(
                                SearchCubit.get(context)
                                    .searchModel
                                    .data
                                    .data[index],
                                context,
                                isOldPrice: false),
                            separatorBuilder: (context, index) => Divider(),
                            itemCount: SearchCubit.get(context)
                                .searchModel
                                .data
                                .data
                                .length),
                      ),
                  ])),
            ),
          );
        },
      ),
    );
  }

  Widget buildSearchItem(Product? model, context, {bool isOldPrice = true}) {
    return Container(
      height: 120,
      alignment: Alignment.center,
      // color:
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage('${model?.img}'),
              width: 120,
              height: 120,
            ),
            if (model?.discount != 0 && isOldPrice == true)
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  color: Colors.red,
                  child: Text(
                    "DISCOUNT",
                    style: TextStyle(color: Colors.white),
                  ))
          ],
        ),
        SizedBox(
          width: 30,
        ),
        Expanded(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${model?.name}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(height: 1.3, fontSize: 14.4),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    "${model?.price}",
                    style: TextStyle(fontSize: 15.4, color: defaultcolor),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if (model?.discount != 0 && isOldPrice == true)
                    Text(
                      "${model?.oldPrice}",
                      style: TextStyle(
                          fontSize: 10.4,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        LayOutCubit.get(context).changeFavoriteData(model?.id);
                      },
                      icon: CircleAvatar(
                          radius: 15,
                          backgroundColor:
                              LayOutCubit.get(context).favourite[model?.id] ==
                                      true
                                  ? defaultcolor
                                  : Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          )))
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
