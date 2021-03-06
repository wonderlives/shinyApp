library(RCurl)

# This function gives the POLYGON url for WalkScore
urlPolyWS = function(apiKey, lat, lon, mode, time) {
      baseDomain = "http://api2.walkscore.com/api/v1/traveltime_polygon/json?wsapikey="
      result = paste0(baseDomain,apiKey,"&origin=",lat,"%2C",lon,"8&mode=",mode,"&time=",time)
      return (result)
}

# This function gives the GEOJSON file for POLYGON
# Cannot use readJSON, otherwise file would be currupted.
parseJsonToString = function(url) {
      rawString = getURL(url) 
      # Parse
      head = regexpr('metry\":', rawString)
      startIndex = head[1] + attr(head,"match.length")
      toe = regexpr(',\"mode\"', rawString)
      endIndex = toe[1] - 1
      goodString = substr(rawString, startIndex, endIndex)
      return (goodString)
}

# This function returns a poly file
getWSPolyJson = function(apiKey, lat, lon, mode, time) {
    url = urlPolyWS(apiKey, lat, lon, mode, time)
    result = parseJsonToString(url)
    return(result)
}


# This function gives the url for COMMON request from WalkScore.
urlWalkScoreCommon = function(apiKey, lat, lon) {
  baseDomain = "http://api.walkscore.com/score?format=json&"
  result = paste0(baseDomain,"&lat=",lat,"&lon=",lon,"&transit=1&bike=1&wsapikey=",apiKey)
  return (result)
}

# This function returns the JSON for COMMON WalkScore request.
getWalkScoreJson = function(url) {
  result = fromJSON(url)
  return(result$walkscore)
}

getObjectWS = function(apiKey, lat, lon) {
    url = urlWalkScoreCommon(apiKey, lat, lon)
    result = fromJSON(url)
    return (result)
}