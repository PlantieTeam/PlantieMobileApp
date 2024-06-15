import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:plantie/bloc/post_bloc.dart';
import 'package:plantie/pages/comment_page.dart';
import 'package:plantie/shared/post_card.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CommunityPage> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.only(top: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              height: 50,
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xffE6E6E6)),
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(Icons.notifications_outlined),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(Icons.more_vert),
                ],
              )),
          Divider(
            color: Colors.grey.shade300,
          ),
          Expanded(
              child: Container(
            width: MediaQuery.of(context).size.width * 0.98,
            margin: const EdgeInsets.only(bottom: 50),
            child: BlocBuilder<PostBloc, PostState>(
                bloc: BlocProvider.of<PostBloc>(context),
                builder: (context, state) {
                  if (state is PostLoaded) {
                    print(state.posts.length);
                    return RefreshIndicator(
                        triggerMode: RefreshIndicatorTriggerMode.anywhere,
                        onRefresh: () async {
                          setState(() {
                            isLoading = true;
                          });
                          Future.delayed(Duration(seconds: 2), () {
                            setState(() {
                              isLoading = false;
                            });
                          });
                          BlocProvider.of<PostBloc>(context)
                              .add(GetPosts(limit: state.posts.length + 5));
                        },
                        child: ListView.builder(
                            itemCount: state.posts.length + 1,
                            itemBuilder: (context, index) {
                              if (index == state.posts.length) {
                                return Center(
                                    child: TextButton.icon(
                                        onPressed: () {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          Future.delayed(Duration(seconds: 2),
                                              () {
                                            setState(() {
                                              isLoading = false;
                                            });
                                          });
                                          BlocProvider.of<PostBloc>(context)
                                              .add(GetPosts(
                                                  limit:
                                                      state.posts.length + 5));
                                        },
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: Color(0xff47B88A),
                                        ),
                                        icon: const Icon(Icons.post_add),
                                        label: Text("Load More")));
                              }
                              return PostCard(
                                  post: state.posts[index],
                                  onCommentPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => CommentPage(
                                                  post: state.posts[index],
                                                )));
                                  },
                                  onLikePressed: () {
                                    context.read<PostBloc>().add(
                                        LikePost(id: state.posts[index].id));
                                  });
                            }));
                  }
                  return const Center(
                      child: SpinKitFadingFour(
                    color: Color(0xff47B88A),
                    size: 40,
                  ));
                }),
          ))
        ],
      ),
    ));
  }
}
