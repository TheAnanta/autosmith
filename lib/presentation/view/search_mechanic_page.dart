import 'package:autosmith/data/datasources/automobile_mechanics.dart';
import 'package:autosmith/domain/entities/automobile_issues.dart';
import 'package:autosmith/presentation/view/map_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchMechanicPage extends StatelessWidget {
  // final AutomobileIssue issue;
  const SearchMechanicPage({super.key});

  @override
  Widget build(BuildContext context) {
    AutomobileIssue? issue =
        ModalRoute.of(context)?.settings.arguments as AutomobileIssue?;
    var mechanics = automobileMechanic
      ..shuffle()
      ..take(3);
    // ..sort((a, b) => b.rating.compareTo(a.rating));
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 380),
              child: MapsContainer(),
            ),
          ),
          Card(
            elevation: 16,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            surfaceTintColor: Colors.white,
            color: Colors.white,
            child: Container(
              height: 480,
              padding: const EdgeInsets.all(24),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.chevron_left_rounded,
                    ),
                  ),
                  Text(
                    "Choose a service provider",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    "Choose a service provider",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var mechanic = mechanics[index];
                      return ListTile(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                var isLoading = false;
                                if (issue == null) {
                                  return const Center(child: Text("Oops"));
                                }
                                return StatefulBuilder(
                                    builder: (context, setState) {
                                  return Card(
                                      child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(24.0),
                                    child: isLoading
                                        ? Center(
                                            child: Image.asset(
                                                "assets/logo/lets-go-mala.png"),
                                          )
                                        : Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Checkout",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineLarge
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              Text(
                                                "Let’s hit the roads very soon",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              ),
                                              const SizedBox(
                                                height: 24,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    issue.title,
                                                    style:
                                                        GoogleFonts.bebasNeue(
                                                            textStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleLarge
                                                                ?.copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                )),
                                                  ),
                                                  Text(
                                                    issue.subtitle,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium,
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  ListTile(
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    leading: Image.asset(
                                                      mechanic.logo,
                                                      height: 48,
                                                    ),
                                                    title: Text(
                                                      mechanic.name,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        textStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .titleMedium,
                                                      ),
                                                    ),
                                                    subtitle: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        const Opacity(
                                                          opacity: 0.7,
                                                          child: Text(
                                                            "1.5 km away",
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              mechanic.rating >=
                                                                      1
                                                                  ? Icons
                                                                      .star_rounded
                                                                  : Icons
                                                                      .star_outline_rounded,
                                                              size: 16,
                                                            ),
                                                            Icon(
                                                              mechanic.rating >=
                                                                      2
                                                                  ? Icons
                                                                      .star_rounded
                                                                  : Icons
                                                                      .star_outline_rounded,
                                                              size: 16,
                                                            ),
                                                            Icon(
                                                              mechanic.rating >=
                                                                      3
                                                                  ? Icons
                                                                      .star_rounded
                                                                  : Icons
                                                                      .star_outline_rounded,
                                                              size: 16,
                                                            ),
                                                            Icon(
                                                              mechanic.rating >=
                                                                      4
                                                                  ? Icons
                                                                      .star_rounded
                                                                  : Icons
                                                                      .star_outline_rounded,
                                                              size: 16,
                                                            ),
                                                            Icon(
                                                              mechanic.rating >=
                                                                      5
                                                                  ? Icons
                                                                      .star_rounded
                                                                  : Icons
                                                                      .star_outline_rounded,
                                                              size: 16,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    trailing: Text(
                                                      "₹${((issue.credits) * mechanic.pricePerCredit).toStringAsFixed(2)}",
                                                      style: GoogleFonts.poppins(
                                                          textStyle: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .titleLarge
                                                              ?.copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .tertiary),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Divider(),
                                              ListTile(
                                                contentPadding: EdgeInsets.zero,
                                                leading: Icon(
                                                    Icons
                                                        .monetization_on_rounded,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .tertiary),
                                                title: Text(
                                                  "Miscallaneous charges",
                                                  style: GoogleFonts.poppins(
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium,
                                                  ),
                                                ),
                                                subtitle: const Opacity(
                                                  opacity: 0.7,
                                                  child: Text(
                                                    "18% taxes and service charges",
                                                  ),
                                                ),
                                                trailing: Text(
                                                  "₹${((issue?.credits ?? 0.0) * mechanic.pricePerCredit * 0.18).toStringAsFixed(2)}",
                                                  style: GoogleFonts.poppins(
                                                      textStyle: Theme.of(
                                                              context)
                                                          .textTheme
                                                          .titleLarge
                                                          ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .tertiary),
                                                ),
                                              ),
                                              const Divider(),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              Row(
                                                children: [
                                                  // Spacer(),
                                                  Column(
                                                    children: [
                                                      const Text("Grand Total"),
                                                      Text(
                                                        "₹${(issue.credits * mechanic.pricePerCredit * 1.18).toStringAsFixed(2)}",
                                                        style: GoogleFonts.poppins(
                                                            textStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleLarge
                                                                ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .tertiary),
                                                      )
                                                    ],
                                                  ),
                                                  const Spacer(
                                                      // flex: 2,
                                                      ),
                                                  Column(
                                                    children: [
                                                      const Text(
                                                          "Payment Method"),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Image.network(
                                                        "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/PayPal.svg/320px-PayPal.svg.png",
                                                        height: 24,
                                                      )
                                                    ],
                                                  ),

                                                  const Spacer(),
                                                  FilledButton(
                                                    onPressed: () {
                                                      isLoading = true;
                                                      setState(() {});
                                                      Future.delayed(
                                                          const Duration(
                                                              seconds: 2), () {
                                                        isLoading = false;
                                                        setState(() {});
                                                        Navigator.of(context)
                                                            .pop();
                                                        Navigator.of(context)
                                                            .pop();
                                                        Navigator.of(context)
                                                            .pushNamed(
                                                                "/success",
                                                                arguments:
                                                                    issue);
                                                      });
                                                    },
                                                    child:
                                                        const Text("Confirm"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                  ));
                                });
                              });
                        },
                        leading: Image.asset(
                          mechanic.logo,
                          height: 48,
                        ),
                        title: Text(
                          mechanic.name,
                          style: GoogleFonts.poppins(
                            textStyle: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Opacity(
                              opacity: 0.7,
                              child: Text(
                                "1.5 km away",
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  mechanic.rating >= 1
                                      ? Icons.star_rounded
                                      : Icons.star_outline_rounded,
                                  size: 16,
                                ),
                                Icon(
                                  mechanic.rating >= 2
                                      ? Icons.star_rounded
                                      : Icons.star_outline_rounded,
                                  size: 16,
                                ),
                                Icon(
                                  mechanic.rating >= 3
                                      ? Icons.star_rounded
                                      : Icons.star_outline_rounded,
                                  size: 16,
                                ),
                                Icon(
                                  mechanic.rating >= 4
                                      ? Icons.star_rounded
                                      : Icons.star_outline_rounded,
                                  size: 16,
                                ),
                                Icon(
                                  mechanic.rating >= 5
                                      ? Icons.star_rounded
                                      : Icons.star_outline_rounded,
                                  size: 16,
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: Text(
                          "₹${(issue?.credits ?? 0.0) * mechanic.pricePerCredit}",
                          style: GoogleFonts.poppins(
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.w500),
                              color: Theme.of(context).colorScheme.tertiary),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 8),
                      );
                    },
                    itemCount: 3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
