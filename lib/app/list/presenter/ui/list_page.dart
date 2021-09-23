import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:github_stars/app/list/presenter/store/list_store.dart';
import 'package:github_stars/app/list/presenter/ui/widgets/user_info_row.dart';
import 'package:github_stars/constants/theme.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final store = ListStore();

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Observer(
          builder: (_) {
            if (store.searchVisible) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                color: Colors.white,
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                  ),
                  onChanged: store.setSearchText,
                ),
              );
            }
            return Text('Lista de usuários');
          },
        ),
        centerTitle: true,
        actions: [
          Observer(
            builder: (_) => IconButton(
              onPressed: store.toggleSearchVisible,
              icon: Icon(store.searchVisible ? Icons.close : Icons.search),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Stack(
        children: [
          Observer(
            builder: (_) {
              if (store.loading) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(kSecondaryColor),
                  ),
                );
              }
              if (store.error != null) {
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Center(
                    child: Text(
                      store.error!,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
              if (store.selected == null) {
                return Container();
              }
              final user = store.list[store.selected!];
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          user.avatar!,
                          width: 70,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            children: [
                              UserInfoRow(
                                icon: Icons.badge_outlined,
                                text: user.name!,
                              ),
                              Divider(height: 0),
                              UserInfoRow(
                                icon: Icons.alternate_email,
                                text: user.nickName,
                              ),
                              Divider(height: 0),
                              UserInfoRow(
                                icon: Icons.details,
                                text: user.bio,
                              ),
                              Divider(height: 0),
                              UserInfoRow(
                                icon: Icons.location_on_outlined,
                                text: user.location,
                              ),
                              Divider(height: 0),
                              UserInfoRow(
                                icon: Icons.email_outlined,
                                text: user.email,
                              ),
                              Divider(height: 0),
                              UserInfoRow(
                                icon: Icons.code_outlined,
                                text: user.url,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: user.repositories!.length,
                      itemBuilder: (context, index) {
                        final repo = user.repositories![index];
                        return ListTile(
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.star_border),
                              Text('${repo.starCount!}'),
                            ],
                          ),
                          title: Text(repo.name!),
                          subtitle: Text(repo.description!),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          Observer(
            builder: (_) {
              if (store.loading) {
                return Container(
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Card(
                    margin: const EdgeInsets.all(0),
                    elevation: 8,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(kSecondaryColor),
                      ),
                    ),
                  ),
                );
              }
              if (!store.searchVisible || store.list.isEmpty) {
                return Container();
              }
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Card(
                  margin: const EdgeInsets.all(0),
                  elevation: 8,
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (_, __) => Divider(
                      height: 0,
                    ),
                    itemCount: store.list.length,
                    itemBuilder: (context, index) {
                      final user = store.list[index];
                      return GestureDetector(
                        onTap: () {
                          store.setSelected(index);
                          controller.clear();
                          store.toggleSearchVisible();
                        },
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            children: [
                              Image.network(user.avatar!),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${user.name}'),
                                    Text(
                                      '${user.nickName}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
