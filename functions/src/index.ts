import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

// FCM
export const sendFcm = functions.https.onRequest(async (req, res) => {
  console.log(JSON.stringify(req.body));
  const message: admin.messaging.Message = {
    topic: "chat",
    data: {
      title: req.body.title,
      body: req.body.body,
    },
    apns: {
      headers: {
        "apns-priority": "5",
        "apns-push-type": "background",
      },
      payload: {
        aps: {
          "content-available": 1,
        },
      },
    },
  };

  admin.messaging().send(message)
      .then((response) => {
        console.log("Successful send message : ", response);
      }).catch((error) => {
        console.log("Error send message : ", error);
      });

  res.status(200).send();
});
