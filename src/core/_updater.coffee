class EsyUpdater

# ----------------------------------------
# constructor
# ----------------------------------------
  constructor: (opts) ->
    { @repo, @file, @destination } = opts

    @localVersion = opts.version
    @username = encodeURIComponent system.userName
    @data
    @remoteVersion
    @connection

# ----------------------------------------
# initialize
# ----------------------------------------
  initialize: () ->



# ----------------------------------------
# makeConnection
# ----------------------------------------
  makeConnection: () ->
    # url        = encodeURIComponent "https://api.github.com/repos/#{@repo}/releases"
    # connection = eval esy.http.get "http://hyle.io/proxy?url=#{url}&username=#{@username}"
    # return connection

# ----------------------------------------
# getLatestVersion
# ----------------------------------------
  getLatestVersion: () ->
    # @data          = @connection[0]
    # @remoteVersion = @data.tag_name
    # return @remoteVersion


# ----------------------------------------
# checkIfLatest
# ----------------------------------------
  checkIfLatest: () ->
    # @remoteVersion ?= @getLatestVersion()
    # return @remoteVersion is @localVersion


# ----------------------------------------
# checkForUpdate
# ----------------------------------------
  checkForUpdate: () ->
    # @connection = @makeConnection()
    # if @connection
    #   if not @checkIfLatest()
    #     if confirm "An update is available for #{@repo} (#{@remoteVersion}). Do you want to download the update?"
    #       @update()
    # else
    #   return true

# ----------------------------------------
# update
# ----------------------------------------
  update: () ->
    # url = encodeURIComponent "https://raw.githubusercontent.com/#{@repo}/master/#{@file}"
    # content = esy.http.get "http://hyle.io/proxy?url=#{url}&username=#{@username}"
    # esy.file.create "#{@destination}/esy_#{@remoteVersion}.jsx", content
    # log "delete #{@destination}/esy_#{@localVersion}.jsx"
    # esy.file.delete "#{@destination}/esy_#{@localVersion}.jsx"
