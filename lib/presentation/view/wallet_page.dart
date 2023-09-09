import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WalletPage extends StatelessWidget {
  final paymentMethod = const [
    "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d6/Visa_2021.svg/320px-Visa_2021.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Mastercard_2019_logo.svg/320px-Mastercard_2019_logo.svg.png",
    "https://seeklogo.com/images/G/google-pay-logo-BFDEA14F81-seeklogo.com.png",
    "https://www.edigitalagency.com.au/wp-content/uploads/PayPal-icon-full-colour-png.png"
  ];
  final paymentMethodData = const [
    "••••  ••••  4564",
    "••••  ••••  5453",
    "••••• •••16",
    "mana••••@••••.com",
  ];
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 72,
          ),
          Text(
            "Wallet",
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(
            height: 24,
          ),
          Card(
            color: Theme.of(context).colorScheme.primary,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "AutoSmith Cash",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      Text(
                        "₹800.00",
                        style: GoogleFonts.poppins(
                          textStyle: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      FilledButton(
                          style: FilledButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor:
                                  Theme.of(context).colorScheme.onPrimary),
                          onPressed: () {},
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                FeatherIcons.plus,
                                size: 16,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text("add money"),
                            ],
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 24,
            ),
            child: Divider(),
          ),
          Text(
            "Payment Methods",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(
            height: 16,
          ),
          ListView.builder(
            padding: const EdgeInsets.only(top: 0.0),
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Image.network(
                  paymentMethod[index],
                  height: index == 0 ? 10 : 16,
                ),
                title: Text(paymentMethodData[index]),
                subtitle:
                    const Opacity(opacity: 0.5, child: Text("Expires 08/23")),
              );
            },
            itemCount: 4,
            primary: false,
            shrinkWrap: true,
          ),
          const ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              Icons.add_card_rounded,
              size: 24,
            ),
            title: Padding(
              padding: EdgeInsets.only(left: 24),
              child: Text("Add card"),
            ),
          ),
        ]),
      ),
    );
  }
}
