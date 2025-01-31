Function Set-HaloOpportunity {
    <#
        .SYNOPSIS
            Updates an opportunity via the Halo API.
        .DESCRIPTION
            Function to send an opportunity update request to the Halo API
        .OUTPUTS
            Outputs an object containing the response from the web request.
    #>
    [CmdletBinding( SupportsShouldProcess = $True )]
    [OutputType([Object])]
    Param (
        # Object containing properties and values used to update an existing opportunity.
        [Parameter( Mandatory = $True, ValueFromPipeline )]
        [Object]$Opportunity
    )
    Invoke-HaloPreFlightCheck
    try {
        $ObjectToUpdate = Get-HaloOpportunity -OpportunityID $Opportunity.id
        if ($ObjectToUpdate) {
            if ($PSCmdlet.ShouldProcess("Opportunity '$($ObjectToUpdate.summary)'", 'Update')) {
                New-HaloPOSTRequest -Object $Opportunity -Endpoint 'opportunities' -Update
            }
        } else {
            Throw 'Opportunity was not found in Halo to update.'
        }
    } catch {
        New-HaloError -ErrorRecord $_
    }
}