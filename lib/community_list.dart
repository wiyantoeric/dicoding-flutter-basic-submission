class Community {
  String name;
  String? description;
  int members;
  List<PostItem>? posts;
  String? communityImage;

  Community(
      {required this.name,
      this.description,
      required this.members,
      this.posts,
      this.communityImage = 'images/default-community-logo.jpg'});
}

class PostItem {
  String publisher;
  String content;
  int time;
  String? publisherImage;

  PostItem(
      {required this.publisher,
      required this.content,
      required this.time,
      this.publisherImage = 'images/default-profile-image.png'});
}

final communityList = <Community>[
  Community(
      name: 'Interaction Designer',
      description: 'UI/UX Designer Community',
      members: 1144,
      communityImage: 'images/interaction-designer-community-logo.png',
      posts: [
        PostItem(
            publisher: 'Budi',
            content:
                'Hello everyone, I\'d like to share mockup I created for my portfolio project.\n\nhttps://desainnyasibudi.com/desainbaru\nOpen for feedback! Thank you',
            time: 3600,
            publisherImage: 'images/budi-profile-image.jpg'),
        PostItem(
            publisher: 'Udin',
            content:
                'Lately, I\'ve been working on some research about UX design with the latest UI trends.\nPlease go ahead to link below for the research paper, any share would be appreciated. Thank you!\n\nhttps://researchnyaudin.library.com/12412513',
            time: 7200,
            publisherImage: 'images/udin-profile-image.jpg'),
      ]),
  Community(
      name: 'Jimms Gym',
      description: 'Jimms Gymnasium Jakarta',
      members: 1502,
      communityImage: 'images/jimms-gym-logo.png',
      posts: [
        PostItem(
            publisher: 'Budi',
            content:
                'Hello everyone!',
            time: 9600,
            publisherImage: 'images/budi-profile-image.jpg'),
        PostItem(
            publisher: 'Udin',
            content:
                'Testing this app...',
            time: 3600,
            publisherImage: 'images/udin-profile-image.jpg'),
      ],
  ),
];
