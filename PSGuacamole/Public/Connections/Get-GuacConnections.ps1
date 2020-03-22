Function Get-GuacConnections()
{
    param(
        [ValidateNotNullOrEmpty()]
        [Parameter(
            Position = 0,
            Mandatory = $true
        )]
        [System.String]
        $DataSource
    )

    begin
    {
        $Uri = "$Server/api/session/data/$($DataSource)/connections/?token=$Token"
    }
    process
    {

        try
        {
            $RestCall = Invoke-RestMethod -Method GET -Uri $Uri -ContentType 'application/json'
        }
        catch
        {

            Write-Warning $_.Exception.Message
            return $False
        }

    }
    end
    {

        return $RestCall.PsObject.Properties.Value
    }
}

<#
Get-GuacConnections -DataSource mysql
#>
