import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestateapp/models/chatmodel.dart';
import 'package:realestateapp/models/post_model.dart';
import 'package:realestateapp/models/user_model.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:realestateapp/modules/videoandphoneCall/audioCallScreen.dart';
import 'package:realestateapp/modules/videoandphoneCall/videoCallScreen.dart';
import 'package:realestateapp/shared/components/components.dart';

class ChatDetailsScreen extends StatelessWidget {
  var messageController = TextEditingController();
  UserModel? userModel;
  MessageModel ?messageModel;


  ChatDetailsScreen({
    this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        AppCubit.get(context).getMessages(receiverId: userModel!.uid!);
        AppCubit.get(context).getAllUsers();

        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                title: Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          '${userModel!.image}',
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        '${userModel!.name}',
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          var message = AppCubit.get(context).Messages[index];
                          if (AppCubit.get(context).userModel!.uid ==
                              message.senderId) return buildMyMessage(message);
                          return buildMessage(message);
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 15,
                        ),
                        itemCount: AppCubit.get(context).Messages.length,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      //  color: Colors.grey[300],
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: messageController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: ' Write your message ...',
                                //  labelText: 'Write your Message ...',
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            color: Colors.blue,
                            child: MaterialButton(
                              minWidth: 1,
                              onPressed: () {},
                              child: IconButton(
                                icon: Icon(Icons.send),
                                onPressed: () {
                                  AppCubit.get(context).sendMessage(
                                      receiverId: userModel!.uid!,
                                      text: messageController.text,
                                      dateTime: DateTime.now().toString());
                                  messageController.clear();

                                  AppCubit.get(context).sendNotification(userModel!,messageModel!);
                                },
                                color: Colors.white,
                                iconSize: 18,
                              ),
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
        );
      },
    );
  }

  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.topStart,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(20.0),
                topEnd: Radius.circular(20.0),
                bottomEnd: Radius.circular(20.0),
              )),
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          child: Text(
            model.text.toString(),
          ),
        ),
      );

  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.topEnd,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(20.0),
                topEnd: Radius.circular(20.0),
                bottomStart: Radius.circular(20.0),
              )),
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          child: Text(
            model.text.toString(),
          ),
        ),
      );
}
