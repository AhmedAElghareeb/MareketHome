import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_home/core/themes.dart';
import 'package:market_home/core/widgets.dart';
import 'package:market_home/views/base/search/cubit.dart';
import 'package:market_home/views/base/search/states.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});

  final search = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = SearchCubit.get(context);
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Search",
                ),
              ),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsetsDirectional.all(16),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      appInput(
                        context,
                        label: "Search",
                        controller: search,
                        textInputType: TextInputType.text,
                        prefixIcon: Icons.search,
                        onSubmit: (text) {
                          cubit.searchData(
                            text: text,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (state is LoadingSearchState)
                        const LinearProgressIndicator(
                          minHeight: 7,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (state is SuccessSearchState)
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) => buildSearchItem(
                              context,
                              cubit.model!.data.list[index],
                            ),
                            separatorBuilder: (context, index) =>
                                buildDivider(),
                            itemCount: cubit.model!.data.list.length,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSearchItem(BuildContext context,model) => Padding(
        padding: const EdgeInsetsDirectional.all(16),
        child: Container(
          clipBehavior: Clip.antiAlias,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: cachedImage(
                  imageUrl: model.image,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      model.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${model.price} EGP",
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
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
