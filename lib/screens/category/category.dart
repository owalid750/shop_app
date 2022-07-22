import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';

class CategoryScrean extends StatelessWidget {
  const CategoryScrean({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayOutCubit, LayOutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildCatList(
                  LayOutCubit.get(context).categoriesModel.data.data[index]),
              separatorBuilder: (context, index) => Divider(),
              itemCount:
                  LayOutCubit.get(context).categoriesModel.data.data.length);
        });
  }

  Widget buildCatList(
    DataModel? model,
  ) =>
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage('${model?.image}'), 

              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "${model?.name}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Spacer(),
            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_sharp))
          ],
        ),
      );
}
