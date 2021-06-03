+++
title = "User Sign Up/Sign In"
date = 2021
weight = 4
chapter = false
pre = "<b>3.4. </b>"
+++

**Add new User Sign Up and Sign In**

We almost have everything we need to sign up and login as a user. Lets check whether the Cognito federated identities have been set up correctly.

1. Open **Amazon Cognito** in the console and click on **Manage Identity Pools**
2. Open the **TravelBuddy identity pool** by clicking on its **title**.
3. Click on **Edit identity pool** in the top right hand corner

Here we can set up ```Unauthenticated``` roles (roles which are assumed when a user is not signed in), and ```Authenticated``` roles (roles which are assumed when a user is signed in).

4. Verify that the **Unauthenticated** role is set to the role that contains the string ```CognitoIAMUnauthenticatedRole```. This was created during lab setup.
5. Verify that **Authenticated** role is set to the role that contains the string ```CognitoIAMAuthenticatedRole```. This was also created during lab setup.

![TravelBuddy](/images/3/7.png?width=90pc)

You now have everything in place to register and sign-in as a user, and then test the signed-in behaviour of the /trips microservice now that it is protected by requiring authorization.

6. In the **TravelBuddy** web page, click **Login or Register** in the top navigation bar
7. Click **Sign-up here!**
8. Fill out the details to create your account. 

{{% notice note %}}
Note that you must provide a **valid email address** and one that you have access to immediately, in order to **retrieve the verification code** you will be sent.
{{% /notice %}}

![TravelBuddy](/images/3/8.png?width=90pc)

9. Check your email, retrieve the verification code, and enter it into the **Registration Verification Code** dialog that appears. Click **Verify**.

![TravelBuddy](/images/3/9.png?width=90pc)

10. Sign-in using the credentials (email address and password) you provided during registration.

![TravelBuddy](/images/3/10.png?width=90pc)

11. You will now be signed in, and the banner will change to show **My Account**. Click the link - the only feature that is implemented is the Logout option. 

![TravelBuddy](/images/3/11.png?width=90pc)

{{% notice tip %}}
You can log out and then log back in again as you wish.
{{% /notice %}}

12. Now that you are signed in, click the **Go!** button again without any text entered. 

{{% notice note %}}
Note that you are shown the full trips list in a dialog, as before we secured the call. 
{{% /notice %}}

Now, sign out using the **My Account** menu link, and try the **Go!** button again. 

{{% notice note %}}
Note that you see the error message again, indicating that you must be signed-in to use the ```/trips``` microservice.
{{% /notice %}}

![TravelBuddy](/images/3/12.png?width=90pc)