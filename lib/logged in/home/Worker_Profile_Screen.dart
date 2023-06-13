import 'package:flutter/material.dart';
import 'package:test_app/repository/Worker_Repository.dart';
import 'package:test_app/data_models/Worker_Account_Model.dart';
import 'package:test_app/Assets.dart';
import 'package:test_app/Shakoosh_icons.dart';
import 'package:test_app/logged in/home/Worker_Time_Table.dart';
import 'package:test_app/Custom_Page_Route.dart';

class WorkerProfile extends StatelessWidget {
  final int workerIndex;
  const WorkerProfile({required this.workerIndex, super.key});

  void _onProceed(BuildContext context) {
    Navigator.of(context).push(
        CustomPageRoute(child: WorkerTimePicker(workerIndex: workerIndex)));
  }

  @override
  Widget build(context) {
    double screenHeight = (MediaQuery.of(context).size.height) -
        (MediaQuery.of(context).padding.top) -
        (MediaQuery.of(context).padding.bottom);
    double screenWidth = (MediaQuery.of(context).size.width);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * 0.07),
          child: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                )),
            title: Text("Worker profile",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge),
          )),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        tooltip: "Book",
        onPressed: () {
          _onProceed(context);
        },
        backgroundColor: Colors.green,
        child: Icon(
          ShakooshIcons.logo_transparent_black_2,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          //color: Color.fromARGB(255, 245, 196, 63),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: screenWidth,
                  height: screenHeight * 0.32,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Stack(
                        children: [
                          SizedBox(
                            height: screenHeight * 0.2,
                            width: screenHeight * 0.2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child:
                                  WorkerRepository.getWorkersList()[workerIndex]
                                      .getProfilePic(),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color:
                                        Theme.of(context).colorScheme.tertiary),
                                child: Icon(
                                  WorkerRepository.getWorkersList()[workerIndex]
                                      .getIconData(),
                                  size: 25,
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "${WorkerRepository.getWorkersList()[workerIndex].getProfession()}",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "${WorkerRepository.getWorkersList()[workerIndex].getFirstName()} ${WorkerRepository.getWorkersList()[workerIndex].getLastName()}",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
                (WorkerRepository.getWorkersList()[workerIndex].reviews.isEmpty)
                    ? Column(
                        children: [
                          ContactInfo(
                              context: context, workerIndex: workerIndex),
                          Container(
                            height: screenHeight * 0.4,
                            width: screenWidth,
                            child: Center(child: Text('No reviews yet')),
                          ),
                        ],
                      )
                    : SizedBox(
                        height: screenHeight * 0.61,
                        child: SingleChildScrollView(
                            child: Column(children: [
                          ContactInfo(
                              context: context, workerIndex: workerIndex),
                          const SizedBox(height: 5),
                          Column(
                            children: [
                              ...WorkerRepository.getWorkersList()[workerIndex]
                                  .getReviews()
                                  .map((review) {
                                return ReviewCard(review: review);
                              })
                            ],
                          )
                        ])),
                      )
              ]),
        ),
      ),
    );
  }
}

class ContactInfo extends StatelessWidget {
  final int workerIndex;
  final BuildContext context;
  ContactInfo({required this.workerIndex, required this.context, super.key});
  @override
  Widget build(context) {
    double screenWidth = (MediaQuery.of(context).size.width);
    return Container(
      width: screenWidth,
      child: Column(
        children: [
          const SizedBox(height: 10),
          SizedBox(
            width: screenWidth * 0.75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenWidth / 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          WorkerRepository.getWorkersList()[workerIndex]
                              .getRate()
                              .toString(),
                          style: Theme.of(context).textTheme.bodyLarge),
                      const SizedBox(
                        width: 2,
                      ),
                      SizedBox(
                          width: 15,
                          height: 15,
                          child: WorkerRepository.getWorkersList()[workerIndex]
                              .getStar()),
                    ],
                  ),
                ),
                SizedBox(
                    width: screenWidth / 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(WorkerRepository.getWorkersList()[workerIndex]
                            .getHourlyRate()),
                        SizedBox(
                          width: 2,
                        ),
                        Text('EGP',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 2,
                        ),
                        Icon(Icons.av_timer_sharp)
                      ],
                    )),
                SizedBox(
                  width: screenWidth / 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          WorkerRepository.getWorkersList()[workerIndex]
                              .getRaters()
                              .toString(),
                          style: Theme.of(context).textTheme.bodyLarge),
                      SizedBox(width: 2),
                      const Icon(Icons.people_alt, size: 18)
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            WorkerRepository.getWorkersList()[workerIndex].getEmail(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.phone, size: 18),
            const SizedBox(
              width: 5,
            ),
            Text(
              WorkerRepository.getWorkersList()[workerIndex]
                  .getPhoneNumberFormatted(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ]),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final Review review;
  const ReviewCard({required this.review, super.key});

  List<Widget> getRatingStars() {
    List<Widget> stars = [];
    for (int i = 0; i < review.rate; i++) {
      stars.add(Container(
          padding: EdgeInsets.only(right: 2),
          child: SizedBox(
              width: 15, height: 15, child: Assets.ratingStarsImages[5])));
    }
    for (int i = 0; i < (5 - review.rate); i++) {
      stars.add(Container(
          padding: EdgeInsets.only(right: 2),
          child: SizedBox(
              width: 15, height: 15, child: Assets.ratingStarsImages[6])));
    }
    return stars;
  }

  @override
  Widget build(context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.all(10),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Color.fromARGB(255, 245, 196, 63)),
                    child: Icon(
                      Icons.person,
                      color: Colors.black87,
                      size: 50,
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      Text(review.getReviewerName()),
                      SizedBox(height: 5),
                      Row(children: getRatingStars())
                    ],
                  )
                ],
              ),
              const SizedBox(
                width: 8,
              ),
              Container(
                  padding: EdgeInsets.only(left: 30, bottom: 10, top: 10),
                  child: Text(
                    review.reviewText,
                    style: Theme.of(context).textTheme.bodySmall,
                  )),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text(
                  review.date,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.grey),
                )
              ])
            ]),
      ),
    );
  }
}
