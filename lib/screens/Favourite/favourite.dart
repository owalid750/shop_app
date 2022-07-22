import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/get_favorite_model.dart';
import 'package:shop_app/shared/styles/colors.dart';

import '../../shared/components/components.dart';

class FavouriteScrean extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayOutCubit, LayOutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: state is! LayOutGetFavoriteDataLoading,
            builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildFavItem(
                    LayOutCubit.get(context).favoriteModel.data.data[index],
                    context),
                separatorBuilder: (context, index) => Divider(),
                itemCount:
                    LayOutCubit.get(context).favoriteModel.data.data.length),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        });
  }



  Widget buildFavItem(
    FavoritesData? model,
    context,
     {bool isOldPrice = true}
  ) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        alignment: Alignment.center,
        // color:
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model?.product.img}'),
                width: 120,
                height: 120,
              ),
              if (model?.product.discount != 0)
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
                  "${model?.product.name}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(height: 1.3, fontSize: 14.4),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      "${model?.product.price}",
                      style: TextStyle(fontSize: 15.4, color: defaultcolor),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if (model?.product.discount != 0)
                      Text(
                        "${model?.product.oldPrice}",
                        style: TextStyle(
                            fontSize: 10.4,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          LayOutCubit.get(context)
                              .changeFavoriteData(model?.product.id);
                        },
                        icon: CircleAvatar(
                            radius: 15,
                            backgroundColor: LayOutCubit.get(context)
                                        .favourite[model?.product.id] ==
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
      ),
    );
  }


}
