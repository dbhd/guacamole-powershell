Function Add-GuacUserGroupConnection()
{
    param(
        [ValidateNotNullOrEmpty()]
        [Parameter(
            Position = 0,
            Mandatory = $true
        )]
        [System.String]
        $DataSource,

        [ValidateNotNullOrEmpty()]
        [Parameter(
            Position = 2,
            Mandatory = $true
        )]
        [System.String]
        $Group,


        [ValidateNotNullOrEmpty()]
        [Parameter(
            Position = 2,
            Mandatory = $true
        )]
        [System.String]
        $ConnectionId
    )

    begin
    {
        $Body = @{
            "op"= "add"
            "path"= "/connectionPermissions/$($ConnectionId)"
            "value"= "READ"
        } | ConvertTo-Json

        $Body = "[$($Body)]"

        $Uri = "$Server/api/session/data/$($DataSource)/userGroups/$Group/permissions?token=$($Token)"

    }
    process
    {

        try
        {
            $RestCall = Invoke-RestMethod -Method PATCH -Uri $Uri -ContentType 'application/json' -Body $Body
        }
        catch
        {
            Write-Warning $_.Exception.Message
            return $False
        }

    }
    end
    {
        return $RestCall
    }
}

<#
Add-GuacUserGroupConnection -DataSource mysql -ConnectionId 52 -Group "test"
#>
