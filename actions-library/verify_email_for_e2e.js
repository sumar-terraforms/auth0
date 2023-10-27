/* eslint-disable */
// TODO: We might enable lint in the future

// Get the Auth0 Management API SDK instance
const managementApi = require('auth0').ManagementClient;

async function onExecutePostLogin(event, api) {
  const userId = event.user.user_id;
  const isE2E = isE2EUser(event.user.email);
  const userEmailVerified = event.user.email_verified;

  try {
    // Check if its E2E user and is logging in for the first time and if the 'email_verified' property is 'false'
    if (isE2E && !userEmailVerified) {
      await updateUserEmailVerified(event, userId);
    }
  } catch (error) {
    console.error('Error executing Post User Login action:', error.message);
  }
}

// Helper function to update the 'email_verified' property
async function updateUserEmailVerified(event, userId) {
  try {
    // Initialize the Management API client
    const managementApiClient = new managementApi({
      domain: event.secrets.domain,
      clientId: event.secrets.clientId,
      clientSecret: event.secrets.clientSecret
    });

    const result = await managementApiClient.updateUser(
      { id: userId },
      { email_verified: true }
    );

    console.log(`'email_verified' property updated to 'true' for user ${userId}`);
  } catch (error) {
    console.error('Error updating user email_verified property:', error.message);
  }
}

function isE2EUser(userEmail) {
  return (
    userEmail.startsWith('eddie+') &&
    userEmail.endsWith('@triniti.net')
  );
}

// Export the main action function
module.exports = { onExecutePostLogin };
