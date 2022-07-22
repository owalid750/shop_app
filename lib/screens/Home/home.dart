import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class HomeScrean extends StatelessWidget {
  const HomeScrean({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayOutCubit, LayOutStates>(
      listener: (context, state) {
        if (state is LayOutChangeFavoriteDataSuccess) {
          if (state.model.status == false) {
            showToast(msg: state.model.message, state: ToastStates.ERRROR);
          }
          // } else {
          //   showToast(msg: state.model.message, state: ToastStates.SUCCESS);
          // }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
            condition: LayOutCubit.get(context).homeModel != null &&
                LayOutCubit.get(context).categoriesModel != null,
            builder: (context) => homeBuilder(
                LayOutCubit.get(context).homeModel,
                LayOutCubit.get(context).categoriesModel,
                context),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget homeBuilder(
          HomeModel? model, CategoriesModel? categoriesModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model?.data?.banners
                    ?.map((e) => Image(
                          image: NetworkImage('${e.img}'),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ))
                    .toList(),
                options: CarouselOptions(
                    height: 250,
                    initialPage: 0,
                    viewportFraction: 1,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal)),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Categories",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: ((context, index) => buildCategoryItem(
                            categoriesModel?.data.data[index])),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 10,
                            ),
                        itemCount: categoriesModel!.data.data.length),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "New Products",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1.2,
                crossAxisSpacing: 1.2,
                childAspectRatio: 1 / 1.52, //   width/height
                children: List.generate(
                    model!.data!.products!.length,
                    (index) => buildGridProduct(
                        model.data!.products![index], context)),
              ),
            )
          ],
        ),
      );
}

Widget buildCategoryItem(DataModel? model) => Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
          image: NetworkImage('${model?.image}'),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        Container(
            width: 100,
            color: Colors.black.withOpacity(.8),
            child: Text(
              "${model?.name}",
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
Widget buildGridProduct(ProductModel model, context) => Container(
      color: Colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image(
              image: NetworkImage('${model.img}'),
              width: double.infinity,
              height: 200,
            ),
            if (model.discount != 0)
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  color: Colors.red,
                  child: Text(
                    "DISCOUNT",
                    style: TextStyle(color: Colors.white),
                  ))
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${model.name}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(height: 1.3, fontSize: 14.4),
              ),
              Row(
                children: [
                  Text(
                    "${model.price}",
                    style: TextStyle(fontSize: 15.4, color: defaultcolor),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if (model.discount != 0)
                    Text(
                      "${model.oldPrice}",
                      style: TextStyle(
                          fontSize: 10.4,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        LayOutCubit.get(context).changeFavoriteData(model.id);
                      },
                      icon: CircleAvatar(
                          radius: 15,
                          backgroundColor:
                              LayOutCubit.get(context).favourite[model.id] ==
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
