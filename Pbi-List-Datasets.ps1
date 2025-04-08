# Variables
$tenantId = "6b35a93e-60ae-4273-851c-72617364ff23"
#PbiFabric
#$clientId = "a51fbe33-8c2c-4377-89af-09314b977841"
#$clientSecret = "m4t8Q~vp7ek4cl1mueZxJGLxy5fUGTzkIbBQda1Q"
#PbiApiDoca
$clientId = "b7062b56-d451-423a-bfd4-a42507d81396"
$clientSecret = "7YE8Q~wPlerXp7E5AX1lqs_fpQTN2zW7SkjndcXn"
$resource = "https://analysis.windows.net/powerbi/api"
$authority = "https://login.microsoftonline.com/$tenantId/oauth2/token"

# Obtenir le token d'accès
$body = @{
    grant_type    = "client_credentials"
    client_id     = $clientId
    client_secret = $clientSecret
    resource      = $resource
}

$response = Invoke-RestMethod -Method Post -Uri $authority -ContentType "application/x-www-form-urlencoded" -Body $body
$accessToken = $response.access_token

# Afficher le token d'accès
#Write-Output "Access Token: $accessToken"

# Variables
#Xcd13
#$groupId = "4026126f-9e5b-40ff-acd2-7e3e3889fd4e"

#[OG2] - auditlog - [PROD]
$groupId = "354e5555-e950-45b1-9683-d5d4b3c5cb60"
$apiUrl = "https://api.powerbi.com/v1.0/myorg/groups/$groupId/datasets"

# En-têtes de la requête
$headers = @{
    Authorization = "Bearer $accessToken"
}

# Envoyer la requête
$response = Invoke-RestMethod -Method Get -Uri $apiUrl -Headers $headers

# Afficher les datasets
$response.value | ForEach-Object {
    Write-Output ("Dataset : {0} | ID : {1}" -f $_.name, $_.id)
}
