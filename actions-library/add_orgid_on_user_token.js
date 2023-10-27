/* eslint-disable */
// TODO: We might enable lint in the future

exports.onExecutePostLogin = async (event, api) => {

  try {
    if (event.user?.user_metadata?.organizations?.length) {
      api.accessToken.setCustomClaim(`organizationIds`, event.user.user_metadata.organizations?.map(org => org.id))
    }
    if (event.user?.user_metadata?.workspaces?.length) {
      api.accessToken.setCustomClaim(`workspaceIds`, event.user.user_metadata.workspaces?.map(org => org.id))
    }
  } catch(error) {
    console.log('Could not update user data', error);
  }
};