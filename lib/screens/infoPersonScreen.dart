import 'package:profinfo/controllers/profileController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/userModel.dart';

class InfoPersonScreen extends StatelessWidget {
  static const routeName = "/infoPersonScreen";
  const InfoPersonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfilerController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(), 
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          "Edite seu Perfil",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:  const EdgeInsets.all(8),
          child: FutureBuilder<List<User>>(
            future: controller.getAllUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (c, index){
                      return Column(
                        children: <Widget>[
                          ListTile(
                            iconColor: Colors.purple,
                            leading: Icon(Icons.person),
                            title: Text("Nome: ${snapshot.data![index].fullName}"),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(snapshot.data![index].celular),
                                Text(snapshot.data![index].email),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                        ],
                      );
                    },
                  );
                }else if(snapshot.hasError){
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }else{
                  return const Center(
                    child: Text("Ocorreu algo de errado"),
                  );
                }
              }else{
                return const Center(
                  child: CircularProgressIndicator()
                );
              }
            },
          )
        )
      )
    );
  }
}