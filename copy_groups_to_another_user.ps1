#copy groups to another existing user use:
get-aduser -identity USER1 -properties memberof | select-object memberof -expandproperty memberof | Add-AdGroupMember -Members USER2