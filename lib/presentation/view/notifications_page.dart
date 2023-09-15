import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("requests")
                  .where("acceptedBy", isNull: true)
                  .where("isCompleted", isEqualTo: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Notifications",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const Text(
                      "A curated list of the requests you've recieved",
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    (snapshot.data?.docs
                                .where((element) => !element
                                    .get("rejectedBy")
                                    .contains(
                                        FirebaseAuth.instance.currentUser?.uid))
                                .isEmpty ??
                            true)
                        ? Expanded(
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    "assets/logo/mala-autogarage.png",
                                    height: 180,
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                  Text(
                                    "No requests at the moment",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  snapshot.data?.docs[index]["problem"] ??
                                      "Problem ABC",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(snapshot.data?.docs[index]
                                            ["model"] +
                                        " | " +
                                        snapshot.data?.docs[index]
                                            ["distance"] ??
                                    "Problem ABC"),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        snapshot.data?.docs[index].reference
                                            .update({
                                          "rejectedBy": FieldValue.arrayUnion([
                                            FirebaseAuth
                                                .instance.currentUser?.uid
                                          ])
                                        });
                                      },
                                      icon: Icon(
                                        Icons.cancel_outlined,
                                        color:
                                            Theme.of(context).colorScheme.error,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        snapshot.data?.docs[index].reference
                                            .update({
                                          "acceptedBy": FirebaseAuth
                                              .instance.currentUser?.uid
                                        });
                                      },
                                      icon: const Icon(
                                          Icons.check_circle_outlined),
                                    ),
                                  ],
                                ),
                                leading: Image.network(
                                  "https://www.yamaha-motor-india.com/theme/v3/image/fascino125fi-new/color/Disc/YELLOW-COCKTAIL-STD.png",
                                  height: 64,
                                  width: 64,
                                ),
                              );
                            },
                            itemCount: snapshot.data?.docs
                                .where((element) => !element
                                    .get("rejectedBy")
                                    .contains(
                                        FirebaseAuth.instance.currentUser?.uid))
                                .length,
                            shrinkWrap: true,
                            primary: false,
                          ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
