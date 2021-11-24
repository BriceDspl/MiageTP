/// 
Class Transform.bpm Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='msg.commandeVoitureDmde' response='msg.commandeVoitureRpse' height='2000' width='2000' >
<context>
<property name='Voiture' type='webObjet.wsVoiture' instantiate='0' />
<property name='Catalogue' type='webObjet.wsCatalogue' instantiate='0' />
<property name='Plaque' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
</context>
<sequence xend='200' yend='1000' >
<call name='Catalogue if exists' target='Catalogue' async='1' xpos='200' ypos='250' >
<request type='msg.consulterVoitureCatalogueDmde' >
<assign property="callrequest.marque" value="request.marque" action="set" />
<assign property="callrequest.modele" value="request.model" action="set" />
</request>
<response type='msg.consulterVoitureCatalogueRpse' >
<assign property="context.Catalogue" value="callresponse.voiture" action="set" />
</response>
</call>
<if condition='response.codeRetour = "OK"' xpos='200' ypos='350' xend='200' yend='900' >
<true>
<call name='Plaque' target='Plaque' async='1' xpos='335' ypos='500' >
<request type='msg.generationPlaqueDmde' />
<response type='msg.generationPlaqueRpse' >
<assign property="context.Plaque" value="callresponse.plaque" action="set" />
</response>
</call>
<transform name='transfo' class='Transform.CatalogueToVoiture' source='context.Catalogue' target='context.Voiture' xpos='335' ypos='600' />
<call name='voiture' target='Voiture' async='1' xpos='335' ypos='700' >
<request type='msg.creerVoitureDmde' >
<assign property="callrequest.voiture.marque" value="request.marque" action="set" />
<assign property="callrequest.voiture.modele" value="request.model" action="set" />
<assign property="callrequest.voiture.couleur" value="request.couleur" action="set" />
<assign property="callrequest.voiture.plaque" value="context.Plaque" action="set" />
<assign property="callrequest.voiture.categorie" value="context.Voiture.categorie" action="set" />
<assign property="callrequest.voiture.nbPlaces" value="context.Voiture.nbPlaces" action="set" />
</request>
<response type='msg.creerVoitureRpse' />
</call>
<call name='file' target='File' async='1' xpos='335' ypos='800' >
<request type='msg.pushVoitureFileDmde' >
<assign property="callrequest.voiture.plaque" value="context.Plaque" action="set" />
<assign property="callrequest.voiture.marque" value="request.marque" action="set" />
<assign property="callrequest.voiture.modele" value="request.model" action="set" />
<assign property="callrequest.voiture.couleur" value="request.couleur" action="set" />
<assign property="callrequest.voiture.categorie" value="context.Voiture.categorie" action="set" />
<assign property="callrequest.voiture.nbPlaces" value="context.Voiture.nbPlaces" action="set" />
</request>
<response type='msg.pushVoitureFileRpse' >
<assign property="response.codeRetour" value="callresponse.codeRetour" action="set" />
<assign property="response.libErreur" value="callresponse.libErreur" action="set" />
</response>
</call>
</true>
</if>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
