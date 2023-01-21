+++
title = "Add New User Sign Up and Sign In"
date = 2020
weight = 4
chapter = false
pre = "<b>4.4. </b>"
+++
#### Add New User Sign Up and Sign In

1. Go to [**Amazon Cognito Console**](https://console.aws.amazon.com/cognito/home).
* Click **Federated Identities**
![Add New User Sign Up and Sign In](/images/4-configure-aaa/4.4-add-new-user-signup_signin/add-new-user-signup_signin-001.png?featherlight=false&width=90pc)
2. Click **TravelBuddy**
![Add New User Sign Up and Sign In](/images/4-configure-aaa/4.4-add-new-user-signup_signin/add-new-user-signup_signin-002.png?featherlight=false&width=90pc)
3. Click **Edit identity pool**
![Add New User Sign Up and Sign In](/images/4-configure-aaa/4.4-add-new-user-signup_signin/add-new-user-signup_signin-003.png?featherlight=false&width=90pc)
4. Here we can set up **Unauthenticated** roles (roles which are assumed when a user is not signed in), and **Authenticated** roles (roles which are assumed when a user is signed in).
* Verify that the **Unauthenticated** role is set to the role that contains the string **CognitoIAMUnauthenticatedRole**. This was created during lab setup.
* Verify that the **Authenticated** role is set to the role that contains the string **CognitoIAMAuthenticatedRole**. This was created during lab setup.
![Add New User Sign Up and Sign In](/images/4-configure-aaa/4.4-add-new-user-signup_signin/add-new-user-signup_signin-004.png?featherlight=false&width=90pc)

You now have everything in place to register and sign-in as a user, and then test the signed-in behaviour of the /trips microservice now that it is protected by requiring authorization.

5. In the **TravelBuddy** page, click **Login or Register**
![Add New User Sign Up and Sign In](/images/4-configure-aaa/4.4-add-new-user-signup_signin/add-new-user-signup_signin-005.png?featherlight=false&width=90pc)
6. Click **Sign-up here!**
![Add New User Sign Up and Sign In](/images/4-configure-aaa/4.4-add-new-user-signup_signin/add-new-user-signup_signin-006.png?featherlight=false&width=90pc)
7. In the **First Name** section, type your first name
* In the **Last Name** section, type your last name
* In the **Email Address** section, type your email
{{% notice note %}} 
You must provide a valid email address and one that you have access to immediately, in order to retrieve the verification code you will be sent.
{{% /notice %}}
* In the **Password** section, type your password
* Click **Register**
![Add New User Sign Up and Sign In](/images/4-configure-aaa/4.4-add-new-user-signup_signin/add-new-user-signup_signin-007.png?featherlight=false&width=90pc)
8. Check your email, save the **verification code**
![Add New User Sign Up and Sign In](/images/4-configure-aaa/4.4-add-new-user-signup_signin/add-new-user-signup_signin-008.png?featherlight=false&width=90pc)
9. In the **Verification Code** section, type the **verification code** we saved in step 8
* Click **Verify**
![Add New User Sign Up and Sign In](/images/4-configure-aaa/4.4-add-new-user-signup_signin/add-new-user-signup_signin-009.png?featherlight=false&width=90pc)
10. Sign-in using the credentials (email address and password) you provided during registration.
![Add New User Sign Up and Sign In](/images/4-configure-aaa/4.4-add-new-user-signup_signin/add-new-user-signup_signin-010.png?featherlight=false&width=90pc)
11. You will now be signed in and the banner will change to show **My Account**
* Click **My Account**, we will see the only feature that is implemented is the Logout option.
![Add New User Sign Up and Sign In](/images/4-configure-aaa/4.4-add-new-user-signup_signin/add-new-user-signup_signin-011.png?featherlight=false&width=90pc)
12. Click **Go!** without any text entered. We are shown the full trips list in a dialog
![Add New User Sign Up and Sign In](/images/4-configure-aaa/4.4-add-new-user-signup_signin/add-new-user-signup_signin-012.png?featherlight=false&width=90pc)
13. Sign out and click **Go!** without any text entered. We will see the error message again.
![Add New User Sign Up and Sign In](/images/4-configure-aaa/4.4-add-new-user-signup_signin/add-new-user-signup_signin-013.png?featherlight=false&width=90pc)