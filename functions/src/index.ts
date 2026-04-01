import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import Stripe from "stripe";

admin.initializeApp();

// Initialize Stripe with your Secret Key.
// IMPORTANT: Replace this with your actual Stripe Secret Key via environment variables in production.
const stripeSecretKey = process.env.STRIPE_SECRET_KEY || "sk_test_12345";
const stripe = new Stripe(stripeSecretKey, {
  apiVersion: "2023-10-16",
});

// A webhook secret allows Stripe to securely communicate with this endpoint.
const endpointSecret = process.env.STRIPE_WEBHOOK_SECRET || "whsec_12345";

export const createStripeCheckout = functions.https.onCall(async (data, context) => {
  // 1. Verify Authentication
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "The function must be called while authenticated."
    );
  }

  const uid = context.auth.uid;
  const { plan } = data; // Expected: 'pro' or 'enterprise'

  if (!['pro', 'enterprise'].includes(plan)) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "The valid plan values are 'pro' or 'enterprise'."
    );
  }

  try {
    // 2. Create Stripe Checkout Session
    // You should hardcode your actual Price IDs from the Stripe Dashboard here
    const priceId = plan === 'pro' ? 'price_pro_id' : 'price_enterprise_id';

    const session = await stripe.checkout.sessions.create({
      payment_method_types: ['card'],
      mode: 'subscription',
      line_items: [
        {
          price: priceId,
          quantity: 1,
        },
      ],
      success_url: 'https://zenith-ai-app.web.app/success', // Update with actual success URL
      cancel_url: 'https://zenith-ai-app.web.app/cancel',   // Update with actual cancel URL
      metadata: {
        firebaseUID: uid,
        plan: plan,
      },
    });

    // 3. Return the sessionId and url
    return {
      id: session.id,
      url: session.url,
    };
  } catch (error) {
    console.error("Error creating stripe checkout session:", error);
    throw new functions.https.HttpsError("internal", "Unable to create checkout session.");
  }
});

export const stripeWebhook = functions.https.onRequest(async (req, res) => {
  const sig = req.headers['stripe-signature'];

  let event;

  try {
    // 1. Verify Stripe signature
    if (!sig) throw new Error('Missing stripe-signature header');
    event = stripe.webhooks.constructEvent(req.rawBody, sig, endpointSecret);
  } catch (err: any) {
    console.error(`Webhook signature verification failed.`, err.message);
    res.status(400).send(`Webhook Error: ${err.message}`);
    return;
  }

  // 2. Handle specific Stripe events
  if (event.type === 'checkout.session.completed') {
    const session = event.data.object as Stripe.Checkout.Session;
    const metadata = session.metadata;

    if (metadata && metadata.firebaseUID && metadata.plan) {
      const { firebaseUID, plan } = metadata;
      
      try {
        // 3. Update Firestore Document
        const userRef = admin.firestore().collection('users').doc(firebaseUID);
        
        await userRef.set({
          plan: plan,
          credits: 500, // Or conditional based on plan
          subscriptionStatus: 'active',
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        }, { merge: true });

        console.log(`Successfully updated user ${firebaseUID} with plan ${plan}`);
      } catch (error) {
        console.error("Error updating Firestore:", error);
        res.status(500).send("Database Update Failed");
        return;
      }
    } else {
        console.error("Metadata missing from session");
    }
  }

  // 4. Return a 200 res to acknowledge receipt
  res.status(200).send({received: true});
});
