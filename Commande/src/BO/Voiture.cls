Class BO.Voiture Extends Ens.BusinessOperation
{

Property Adapter As Ens.OutboundAdapter;

Parameter ADAPTER = "Ens.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method creerVoiture(pRequest As msg.creerVoitureDmde, Output pResponse As msg.creerVoitureRpse) As %Status
{
    
    Set pResponse = ##class(msg.creerVoitureRpse).%New()
    Set voiture = ##class(data.Voiture).%New()
    Do ##class(Transform.WsVoitureToVoiture).Transform(pRequest.voiture,.voiture)
    Set tsc = voiture.%Save()

    Set pResponse.codeRetour = "OK"

    Quit $$$OK
}

Method deleteVoiture(pRequest As msg.deleteVoitureDmde, Output pResponse As msg.deleteVoitureRpse) As %Status
{
    
    Set pResponse = ##class(msg.deleteVoitureRpse).%New()
    Do ##class(data.Voiture).consulterParPlaqueExists(pRequest.plaque, .id)
    Do ##class(data.Voiture).%DeleteId(id)

    Set pResponse.codeRetour = "OK"

    Quit $$$OK
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="msg.creerVoitureDmde">
        <Method>creerVoiture</Method>
    </MapItem>
    <MapItem MessageType="msg.deleteVoitureDmde">
        <Method>deleteVoiture</Method>
    </MapItem>
</MapItems>
}

}
