Map<String, dynamic> clientFixtures = {
  "success": true,
  "message": "Login successful",
  "data": {
    "user": {
      "_id": "1234",
      "full_name": "Pureheart",
      "username": "Pure",
    },
    "token": "1234",
  },
};

Map<String, dynamic> getUserPostFixtures = {
  "success": true,
  "message": "Post fetched successfully",
  "data": [
    {
      "_id": "62e0dde5379382222cdf2e39",
      "user": {
        "_id": "62e0d5008527692dedb7b255",
        "full_name": "John Doe",
        "username": "Johnny",
        "email": "norowir455@aregods.com",
        "country": "Brazil",
        "profile_picture":
            "https://bartrapp.s3.us-west-2.amazonaws.com/EB939577-EC79-4892-B8B9-754F6E982B8D.jpg",
        "followers": [],
        "createdAt": "2022-07-27T06:02:40.405Z",
        "expoPushToken": "ExponentPushToken[wzUWmqGIXHjtdXMr_o-HAy]"
      },
      "title": "MacBook Pro M1 2022",
      "description":
          "Neatly used MacBook Pro with M1 chip. Comment why you should get it.",
      "category": "PC",
      "location": "Brazil",
      "status": "Available",
      "visibility": "Public",
      "expireDate": "2022-07-28T18:40:14.437Z",
      "post_type": "Giveaway",
      "likes": 3,
      "liked_by": [
        "62e0d5008527692dedb7b255",
        "630890a083546bb26c822153",
        "632b339c2f99516378ed9179"
      ],
      "post_images": [
        "https://bartrapp.s3-us-west-2.amazonaws.com/0B6AD294-5669-476A-AB17-CFFA6F27805C.jpg",
        "https://bartrapp.s3.us-west-2.amazonaws.com/7830926C-EE72-484B-B2E4-B7C77C5F8AFE.jpg",
        "https://bartrapp.s3.us-west-2.amazonaws.com/D2BA7D82-848F-4D0E-859A-4176AFBA5E31.jpg"
      ],
      "bids": [],
      "comments": [],
      "createdAt": "2022-07-27T06:40:37.764Z",
      "__v": 69,
      "total_comments": 0
    }
  ]
};

Map<String, dynamic> loginFixtures = {
  "success": true,
  "message": "Login successful",
  "data": {
    "token":
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzNGVlNmVhNDM3M2RkN2I3YzZhNmRhOCIsInVzZXJuYW1lIjoieGNsdXNpdmVjeWJvcmciLCJwcm9maWxlX3BpY3R1cmUiOiJodHRwczovL2JhcnRyYXBwLnMzLnVzLXdlc3QtMi5hbWF6b25hd3MuY29tL2ltYWdlX3BpY2tlcl8yMDdCRTI2NS04MTQ4LTRCQ0YtODFDNi05MkQ2NEI1RkY4NzItMzkxNS0wMDAwMDI0MTk1QUY2OTlDLnBuZyIsImlhdCI6MTY2NjQ0OTUzNiwiZXhwIjoxNjY5MDQxNTM2fQ.YvK9c3Ux3Z9gynyFil5G7yyZPxAfQWzI2fP-MJcdUXM",
    "user": {
      "_id": "634ee6ea4373dd7b7c6a6da8",
      "full_name": "Ayodeji Ogundairo",
      "username": "xclusivecyborg",
      "email": "xclusivecyborg@gmail.com",
      "country": "Nigeria",
      "profile_picture":
          "https://bartrapp.s3.us-west-2.amazonaws.com/image_picker_207BE265-8148-4BCF-81C6-92D64B5FF872-3915-0000024195AF699C.png",
      "emailConfirmed": true,
      "signupCode": 7390,
      "terms": true,
      "createdAt": "2022-10-18T17:48:26.496Z",
      "__v": 13,
      "fcmPushToken":
          "dsOs34lLjUmxqit-BUZj4I:APA91bEVZ-_4WPJWXytaOZSB31JhDeixLW1_J_KnhfXm27Ad0gJitDYgcu9fP-oGiNlBM_J59Zu6Pd_uaI2vgmDZ1cArRId7w_7RNiFn5nYmg4ur6Xtuy6UoIb-VkySybnrFNojLsD_k",
      "cover_photo":
          "https://bartrapp.s3.us-west-2.amazonaws.com/image_picker_F825455A-D791-4863-BAAA-86C09F1D2456-4193-00000248DDD9AA08.jpg"
    }
  }
};

Map<String, dynamic> failedloginFixtures = {
  "success": false,
  "error": "Incorrect email or password",
};
