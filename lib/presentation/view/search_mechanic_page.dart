import 'package:autosmith/data/datasources/automobile_mechanics.dart';
import 'package:autosmith/domain/entities/automobile_issues.dart';
import 'package:autosmith/presentation/view/map_container.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/enums/workflow_status.dart';

class SearchMechanicPage extends StatefulWidget {
  // final AutomobileIssue issue;
  const SearchMechanicPage({super.key});

  @override
  State<SearchMechanicPage> createState() => _SearchMechanicPageState();
}

class _SearchMechanicPageState extends State<SearchMechanicPage> {
  var workflowStatus = WorkflowStatus.serviceProvider;
  var timer = 10;
  var rating = 0;
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
          Padding(
            padding: EdgeInsets.only(
                bottom: workflowStatus == WorkflowStatus.serviceProvider
                    ? 380
                    : 200),
            child: const MapsContainer(),
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
            child: workflowStatus == WorkflowStatus.serviceProvider
                ? Container(
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
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          "Choose a service provider",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        ListView.builder(
                          padding: EdgeInsets.only(top: 0.0),
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
                                        return const Center(
                                            child: Text("Oops"));
                                      }
                                      return StatefulBuilder(
                                          builder: (context, setCardState) {
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
                                                  mainAxisSize:
                                                      MainAxisSize.min,
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
                                                                  FontWeight
                                                                      .bold),
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
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          issue.title,
                                                          style: GoogleFonts
                                                              .bebasNeue(
                                                                  textStyle: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .titleLarge
                                                                      ?.copyWith(
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      )),
                                                        ),
                                                        Text(
                                                          issue.subtitle,
                                                          style:
                                                              Theme.of(context)
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
                                                            style: GoogleFonts
                                                                .poppins(
                                                              textStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .titleMedium,
                                                            ),
                                                          ),
                                                          subtitle: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
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
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .tertiary),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const Divider(),
                                                    ListTile(
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      leading: Icon(
                                                          Icons
                                                              .monetization_on_rounded,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .tertiary),
                                                      title: Text(
                                                        "Miscallaneous charges",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          textStyle:
                                                              Theme.of(context)
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
                                                            color: Theme.of(
                                                                    context)
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
                                                            const Text(
                                                                "Grand Total"),
                                                            Text(
                                                              "₹${(issue.credits * mechanic.pricePerCredit * 1.18).toStringAsFixed(2)}",
                                                              style: GoogleFonts.poppins(
                                                                  textStyle: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .titleLarge
                                                                      ?.copyWith(
                                                                          fontWeight: FontWeight
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
                                                            setCardState(() {});
                                                            Future.delayed(
                                                                const Duration(
                                                                    seconds: 2),
                                                                () {
                                                              isLoading = false;
                                                              workflowStatus =
                                                                  WorkflowStatus
                                                                      .success;
                                                              countdownTimer();
                                                              Future.delayed(
                                                                  const Duration(
                                                                      seconds:
                                                                          10),
                                                                  () {
                                                                workflowStatus =
                                                                    WorkflowStatus
                                                                        .inProgress;
                                                                timer = 20;
                                                                Future.delayed(
                                                                    const Duration(
                                                                        seconds:
                                                                            20),
                                                                    () {
                                                                  workflowStatus =
                                                                      WorkflowStatus
                                                                          .completed;

                                                                  setState(
                                                                      () {});
                                                                });
                                                              });
                                                              setState(() {});

                                                              setCardState(
                                                                  () {});
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              // Navigator.of(context)
                                                              //     .pop();
                                                              // Navigator.of(context)
                                                              //     .pushNamed(
                                                              //         "/success",
                                                              //         arguments:
                                                              //             issue);
                                                            });
                                                          },
                                                          child: const Text(
                                                              "Confirm"),
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
                                  textStyle:
                                      Theme.of(context).textTheme.titleMedium,
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
                                    color:
                                        Theme.of(context).colorScheme.tertiary),
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                            );
                          },
                          itemCount: 3,
                        ),
                      ],
                    ),
                  )
                : workflowStatus == WorkflowStatus.success
                    ? Container(
                        height: 300,
                        padding: const EdgeInsets.all(24),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton.filled(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.chevron_left_rounded,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              "We’re almost there!",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              "Just have a sip of coffee and we'll\nbe there in a jiffy.",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                OutlinedButton(
                                  onPressed: () {},
                                  child: const Text("Cancel"),
                                ),
                                const Spacer(),
                                FilledButton(
                                  onPressed: () {},
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.hourglass_top_rounded,
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Text("ETA: ${timer}.00 min"),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    : workflowStatus == WorkflowStatus.inProgress
                        ? Container(
                            height: 300,
                            padding: const EdgeInsets.all(24),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton.filled(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(
                                    Icons.chevron_left_rounded,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  "We're on it!",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  "Give us some time to analyze the issue and get your vehicle back to its best.",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    OutlinedButton(
                                      onPressed: () {},
                                      child: const Text("Cancel"),
                                    ),
                                    const Spacer(),
                                    FilledButton(
                                      onPressed: () {},
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.hourglass_top_rounded,
                                            size: 20,
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Text("ETA: ${timer}.00 min"),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        : Container(
                            height: 400,
                            padding: const EdgeInsets.all(24),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton.filled(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(
                                    Icons.chevron_left_rounded,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  "Eureka!",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "It's done and your vehicle is back to its best.\n\nHelp us serve you better by rating your experience.",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Center(
                                  child: SizedBox(
                                    height: 48,
                                    child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            rating = index + 1;
                                            setState(() {});
                                          },
                                          child: Icon(
                                            rating > index
                                                ? Icons.star_rounded
                                                : Icons.star_border_rounded,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            size: 48,
                                          ),
                                        );
                                      },
                                      primary: true,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 5,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    OutlinedButton(
                                      onPressed: () {},
                                      child: const Text("Cancel"),
                                    ),
                                    const Spacer(),
                                    FilledButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushReplacementNamed("/home");
                                      },
                                      child: const Row(
                                        children: [
                                          Icon(
                                            FeatherIcons.check,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Text("Submit"),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
          ),
        ],
      ),
    );
  }

  void countdownTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        timer--;
      });
      if (timer > 0) {
        countdownTimer();
      }
    });
  }
}
