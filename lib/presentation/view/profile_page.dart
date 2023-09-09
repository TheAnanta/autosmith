import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePage extends StatelessWidget {
  final actions = const [
    "Plus Membership",
    "My vehicles",
    "Join as partner",
    "Settings",
    "Sign out"
  ];
  final actionIcons = const [
    Icons.add_rounded,
    Icons.directions_car_outlined,
    Icons.verified_rounded,
    FeatherIcons.settings,
    FeatherIcons.logOut,
  ];
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 24,
            ),
            Opacity(
              opacity: 0.3,
              child: SvgPicture.asset(
                "assets/app-icon.svg",
                height: 48,
              ),
            ),
            SizedBox(
              height: 48,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Manas Malla",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(
                          Icons.verified_rounded,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                    Text(
                      "Plus Member",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
                Spacer(),
                ClipOval(
                  child: Image.network(
                    "https://github.com/ManasMalla.png",
                    height: 64,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  width: 100,
                  padding: EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Icon(
                        FeatherIcons.helpCircle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text("Help"),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed("/wallet"),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    width: 100,
                    padding: EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Icon(
                          Icons.wallet_rounded,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text("Wallet"),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  width: 100,
                  padding: EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Icon(
                        FeatherIcons.refreshCcw,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text("History"),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.all(24),
              child: Row(
                children: [
                  Text(
                    "Earn ₹100 for inviting a friend\nand book a mechanic",
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  Column(
                    children: [
                      Icon(
                        FeatherIcons.share,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Invite friends",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Divider(),
            ),
            ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    actionIcons[index],
                  ),
                  title: Text(actions[index]),
                );
              },
              itemCount: actions.length,
            ),
          ],
        ),
      ),
    );
  }
}
