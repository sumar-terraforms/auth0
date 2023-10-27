/* eslint-disable */
// TODO: We might enable lint in the future

const managementApi = require('auth0').ManagementClient

const getClient = (event) => {
  const client = new managementApi({
    domain: event.secrets.domain,
    clientId: event.secrets.clientId,
    clientSecret: event.secrets.clientSecret
  })
  return client
}

const getUserPermissions = async (event) => {
  const client = await getClient(event)
  const results = []
  const perPage = 100
  let page = 0

  let response = await client.getUserPermissions({
    id: event.user.user_id,
    page,
    per_page: perPage,
    include_totals: true
  })
  results.push(...response.permissions)

  const total = response.total
  const totalPages = Math.ceil(total / perPage)

  while (page < totalPages - 1) {
    page++
    response = await client.getUserPermissions({
      id: event.user.user_id,
      page,
      per_page: perPage,
      include_totals: true
    })
    results.push(...response.permissions)
  }

  const resultMap = results?.map((r) => r.permission_name)
  return resultMap
}

exports.onExecutePostLogin = async (event, api) => {
  try {
    if (event.user.user_metadata?.permissions?.length) {
      console.log('Permissions have already been added to user metadata')
      return
    }

    const permissions = await getUserPermissions(event)
    if (permissions?.length) {
      api.user.setUserMetadata('permissions', permissions)
      console.log(`${permissions?.length} migrated`)
    } else {
      console.log('No permission found')
    }
  } catch (error) {
    console.error('Error:', error.message)
  }
}
