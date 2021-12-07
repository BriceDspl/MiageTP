/// Description
Class BS.Reservation Extends Ens.BusinessOperation
{

Property Adapter As Ens.OutboundAdapter;

Parameter ADAPTER = "Ens.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method checkDispo(pRequest As msg.checkDispoDmde, Output pResponse As msg.checkDispoRpse) As %Status
{
    Set pResponse = ##class(msg.checkDispoRpse).%New()
    Set sql = "select count(*) from data.Reservation where voiture not in (select voiture from data.Reservation where  (dateDebut between "_pRequest.dateDebut_" and "_pRequest.dateFin_") or (dateFin between "_pRequest.dateDebut_" and "_pRequest.dateFin_") or ("_pRequest.dateDebut_" between dateDebut and dateFin)"

    Set statement=##class(%SQL.Statement).%New() 
	Do statement.%Prepare(sql)
	Set SQLrequest = statement.%Execute()
    While SQLrequest.%Next(){

    }
    Set pResponse.codeRetour = "OK"

    Quit $$$OK
}

Method reserverVoiture(pRequest As msg.reservationDmde, Output pResponse As msg.reservationRpse) As %Status
{
  Set pResponse = ##class(msg.reservationRpse).%New()
    Set reservation = ##class(data.Reservation).%New()
    Set sql = "select nom, plaque from data.Voiture where categorie = "_pRequest.categorie_" "

    Set tStatement = ##class(%SQL.Statement).%New()
    Do tStatement.%Prepare(sql)
    Set treq = tStatement.%Execute()
    While treq.%Next()
    {
        Set voiture = ##class(data.Voiture).%New()
        Set voiture.nom = treq.%Get("nom")
        Set voiture.plaque = treq.%Get("plaque")
        Set voiture.categorie = pRequest.categorie
        Set reservation.voiture = voiture
    }
    Set reservation.dateDebut = pRequest.dateDebut
    Set reservation.dateFin = pRequest.dateFin
    Do reservation.%Save()

    Set pResponse.codeRetour = "OK"
    Quit $$$OK
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="msg.checkDispoDmde">
        <Method>checkDispo</Method>
    </MapItem>
      <MapItem MessageType="msg.reservationDmde">
        <Method>reserverVoiture</Method>
    </MapItem>
</MapItems>
}

}
