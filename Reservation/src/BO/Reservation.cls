/// Description
Class BS.Reservation Extends Ens.BusinessOperation
{

Property Adapter As Ens.OutboundAdapter;

Parameter ADAPTER = "Ens.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method checkDispo(pRequest As msg.checkDispoDmde, Output pResponse As msg.checkDispoRpse) As %Status
{
    Set pResponse = ##class(msg.checkDispoRpse).%New()

    Set tStatement = ##class(%SQL.Statement).%New()
    Set sql = "select count(*) from data.Reservation where voiture not in "
        +"(select voiture from data.Reservation where "+
        " (dateDebut between "_pRequest.dateDebut_" and "_pRequest.dateFin_")"+
        " or (dateFin between "_pRequest.dateDebut_" and "_pRequest.dateFin_") "+
        "or ("_pRequest.dateDebut_" between dateDebut and dateFin)"

    Do tStatement.%Prepare(sql)
    Set treq = tStatement.%Execute()
    If treq.%Next()
    {
        If treq.%Get(1) > 0
        {
            Set pResponse.codeRetour = "KO"
            Set pResponse.libErreur = "Reservation impossible"
        }
        Else
        {
         Set pResponse.codeRetour = "OK"
        }
    }
    Else
    {
            Set pResponse.codeRetour = "KO"
    
    }
    Quit $$$OK
}

Method reserverVoiture(pRequest As msg.reservationDmde, Output pResponse As msg.reservationRpse) As %Status
{
  Set pResponse = ##class(msg.reservationRpse).%New()
    set reservation = ##class(data.Reservation).%New()
    set sql = "select nom, plaque from data.Voiture "

    set tStatement = ##class(%SQL.Statement).%New()
    do tStatement.%Prepare(sql)
    set treq = tStatement.%Execute()
    while treq.%Next()
    {
      set voiture = ##class(data.Voiture).%New()
        set voiture.nom = treq.%Get("nom")
        set voiture.plaque = treq.%Get("plaque")
        set voiture.categorie = pRequest.categorie
        do reservation.%Add(voiture)
    }
    set reservation.dateDebut = pRequest.dateDebut
    set reservation.dateFin = pRequest.dateFin
    do reservation.%Save()

    set pResponse.codeRetour = "OK"
    Quit $$$OK
}

}
