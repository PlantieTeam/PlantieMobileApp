import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantie/bloc/post_bloc.dart';
import 'package:plantie/bloc/user_profile_bloc.dart';
import 'package:plantie/pages/comment_page.dart';
import 'package:plantie/shared/loader.dart';
import 'package:plantie/shared/post_card.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _MyWidgetState();
}
var Language = "en";
class _MyWidgetState extends State<CommunityPage> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
        var state = BlocProvider.of<UserProfileBloc>(context).state;
    if (state is UserProfileLoaded) {
      if(state.userProfile.language =='en') {
        Language  = "en";
      } else{
        Language  =  "ar";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      decoration: const BoxDecoration(
        color: Colors.white12,
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.only(top: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    onSubmitted: (value) {
                      BlocProvider.of<PostBloc>(context)
                          .add(Search(text: value));
                    },
                    decoration: InputDecoration(
                      hintText: Language  == 'en'?'Search':"بحث",
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
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color(0xffF6F6F6),
            ),
            margin: const EdgeInsets.only(bottom: 50),
            child: BlocBuilder<PostBloc, PostState>(
                bloc: BlocProvider.of<PostBloc>(context),
                builder: (context, state) {
                  if (state is PostLoaded) {
                    return RefreshIndicator(
                        triggerMode: RefreshIndicatorTriggerMode.anywhere,
                        onRefresh: () async {
                          setState(() {
                            isLoading = true;
                          });
                          Future.delayed(const Duration(seconds: 2), () {
                            setState(() {
                              isLoading = false;
                            });
                          });
                          BlocProvider.of<PostBloc>(context)
                              .add(const GetPosts());
                        },
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.98,
                            child: ListView.builder(
                                itemCount: state.posts.length + 1,
                                itemBuilder: (context, index) {
                                  if (index == state.posts.length) {
                                    return state.posts.length % 5 == 0
                                        ? Center(
                                            child: TextButton.icon(
                                                onPressed: () {
                                                  setState(() {
                                                    isLoading = true;
                                                  });
                                                  Future.delayed(
                                                      const Duration(
                                                          seconds: 2), () {
                                                    setState(() {
                                                      isLoading = false;
                                                    });
                                                  });
                                                  BlocProvider.of<PostBloc>(
                                                          context)
                                                      .add(GetMorePosts(
                                                          limit: state.posts
                                                                  .length +
                                                              5));
                                                },
                                                style: TextButton.styleFrom(
                                                  foregroundColor: Colors.white,
                                                  backgroundColor:
                                                      const Color(0xff47B88A),
                                                ),
                                                icon:
                                                    const Icon(Icons.post_add),
                                                label: const Text("Load More")))
                                        : const SizedBox();
                                  }
                                  return PostCard(
                                      post: state.posts[index],
                                      onCommentPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CommentPage(
                                                      post: state.posts[index],
                                                    )));
                                      },
                                      onLikePressed: () {
                                        context.read<PostBloc>().add(LikePost(
                                            id: state.posts[index].id));
                                      });
                                })));
                  }
                  return const Loader();
                }),
          ))
        ],
      ),
    ));
  }
}
