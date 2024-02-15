import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/get/fetch_bloc.dart';
import '../controller/get/fetch_event.dart';
import '../controller/get/fetch_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FetchBloc>(context).add(FetchDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final descriptionController = TextEditingController();
    final imgLinkController = TextEditingController();
    final titleController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mansoor Task'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(Icons.edit),
          )
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(hintText: 'Email'),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: 'Description'),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: imgLinkController,
            decoration: const InputDecoration(hintText: 'Image Link'),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'title'),
          ),
          const SizedBox(height: 5),
          ElevatedButton(
            onPressed: () {
              final email = emailController.text;
              final title = titleController.text;
              final description = descriptionController.text;
              final imgLink = imgLinkController.text;

              BlocProvider.of<FetchBloc>(context).add(CreateListEvent(
                email: email,
                description: description,
                title: title,
                imgLink: imgLink,
              ));
            },
            child: const Text("Create"),
          ),
          const SizedBox(height: 10),
          BlocBuilder<FetchBloc, FetchState>(
            builder: (context, state) {
              if (state is FetchInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FetchLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FetchSuccess) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      final item = state.data[index];
                      return ListTile(
                        leading: Container(
                          width: 70,
                          height: 70,
                          color: Colors.grey,
                          child: item.imgLink != null
                              ? Image.network(
                                  item.imgLink!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.error);
                                  },
                                )
                              : null,
                        ),
                        title: Text(item.title ?? ""),
                        subtitle: Text(item.description ?? ""),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            final itemId = item.id;
                            BlocProvider.of<FetchBloc>(context).add(DeleteItemEvent(itemId!));
                          },
                        ),
                      );
                    },
                  ),
                );
              } else if (state is FetchError) {
                return Center(child: Text(state.message));
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
