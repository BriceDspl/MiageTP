Class msg.checkDispoDmde Extends (Ens.Request, %JSON.Adaptor)
{

Property dateDebut As %String;

Property dateFin As %String;

Property categorie As %String;

Storage Default
{
<Data name="checkDispoDmdeDefaultData">
<Subscript>"checkDispoDmde"</Subscript>
<Value name="1">
<Value>dateDebut</Value>
</Value>
<Value name="2">
<Value>dateFin</Value>
</Value>
<Value name="3">
<Value>categorie</Value>
</Value>
</Data>
<DefaultData>checkDispoDmdeDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
