import 'package:autosmith/data/datasources/automobile_issues.dart';
import 'package:autosmith/domain/entities/automobile_issues.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/enums/automobile_type.dart';
import 'bottom_call_to_action.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var automobileType = AutomobileType.fourWheeler;
  var automobileIssues = fourWheelerIssues;
  var selectedIssueIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed("/profile");
                    },
                    child: ClipOval(
                      child: Image.network(
                        "https://github.com/ManasMalla.png",
                        width: 54,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (searchParam) {
                        automobileIssues =
                            (automobileType == AutomobileType.fourWheeler
                                    ? fourWheelerIssues
                                    : twoWheelerIssues)
                                .where((issue) =>
                                    issue.title.contains(searchParam) ||
                                    issue.subtitle.contains(searchParam))
                                .toList();
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: "Search",
                        filled: true,
                        isDense: true,
                        fillColor: Theme.of(context)
                            .colorScheme
                            .primaryContainer
                            .withOpacity(0.5),
                        prefixIcon: const Icon(FeatherIcons.search),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 36,
              ),
              Text(
                "What seems\nto be the\nissue?",
                style: GoogleFonts.unicaOne(
                  textStyle: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              InkWell(
                onTap: () {
                  selectedIssueIndex = 0;
                  setState(() {});
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: selectedIssueIndex == 0
                        ? Theme.of(context).colorScheme.primary
                        : null,
                    border: Border.all(
                        color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.water_drop_rounded,
                      color: selectedIssueIndex == 0
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.primary,
                    ),
                    title: Text(
                      "Out of petrol",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: selectedIssueIndex == 0
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    subtitle: Text(
                      "Did your car just run out of petrol?",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: (selectedIssueIndex == 0
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(context).colorScheme.primary)
                                .withOpacity(0.6),
                          ),
                    ),
                    trailing: Icon(
                      selectedIssueIndex == 0
                          ? FeatherIcons.check
                          : FeatherIcons.clock,
                      color: selectedIssueIndex == 0
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                height: 280,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 0.35),
                  itemBuilder: (context, index) {
                    final issue = automobileIssues[index];
                    final isSelected = selectedIssueIndex == index + 1;
                    return ListTile(
                      onTap: () {
                        selectedIssueIndex = index + 1;
                        setState(() {});
                      },
                      tileColor: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : null,
                      iconColor: isSelected
                          ? Theme.of(context).colorScheme.onPrimary
                          : null,
                      textColor: isSelected
                          ? Theme.of(context).colorScheme.onPrimary
                          : null,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      selectedColor: Colors.white,
                      leading: Icon(issue.icon),
                      title: Text(issue.title),
                      subtitle: Text(issue.subtitle),
                    );
                  },
                  itemCount: automobileIssues.length,
                ),
              ),
              const SizedBox(
                height: 72,
              ),
              // const Spacer(),
              BottomCallToAction(
                onWheelerChange: (AutomobileType type) {
                  automobileIssues = type == AutomobileType.fourWheeler
                      ? fourWheelerIssues
                      : twoWheelerIssues;
                  automobileType = type;
                  setState(() {});
                },
                automobileIssue: selectedIssueIndex == 0
                    ? const AutomobileIssue(
                        title: "Out of petrol",
                        subtitle: "Did your car just run out of petrol?",
                        icon: Icons.water_drop_rounded,
                        credits: 2)
                    : automobileIssues[selectedIssueIndex - 1],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
