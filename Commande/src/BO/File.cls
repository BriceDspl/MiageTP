Class BO.File Extends Ens.BusinessOperation
{

Property Adapter As EnsLib.File.OutboundAdapter;

Parameter ADAPTER = "EnsLib.File.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method pushVoitureFile(pRequest As msg.pushVoitureFileDmde, Output pResponse As msg.pushVoitureFileRpse) As %Status
{
    Set pResponse = ##class(msg.deleteVoitureRpse).%New()
    Set pStream = ##class(%Library.FileBinaryStream).%New()
    Do pStream.Write(pRequest.voiture.marque_":"_pRequest.voiture.modele_":"_pRequest.voiture.categorie_":"_pRequest.voiture.plaque_":"_pRequest.voiture.nbPlaces)
    Do ..Adapter.PutStream("FILE", pStream)

    Set pResponse.codeRetour = "OK"

    Quit $$$OK
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="msg.pushVoitureFileDmde">
        <Method>pushVoitureFile</Method>
    </MapItem>
</MapItems>
}

}
