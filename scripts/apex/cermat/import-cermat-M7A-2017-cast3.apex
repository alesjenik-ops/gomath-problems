String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD17C0T01';
Integer YEAR = 2017;

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; String ccode; Integer yr; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype, String ccode, Integer yr){this.tx=tx;this.have=have;this.src=src;this.stype=stype;this.ccode=ccode;this.yr=yr;}
  Id sv(String t,String fn,String s){ContentVersion cv=new ContentVersion(Title=t,PathOnClient=fn,VersionData=Blob.valueOf(s),Origin='H');insert cv;return [SELECT ContentDocumentId FROM ContentVersion WHERE Id=:cv.Id].ContentDocumentId;}
  void lk(Id d,Id r){try{insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='AllUsers');}catch(Exception e){insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='InternalUsers');}}
  String para(String t){return '{"type":"paragraph","text":'+JSON.serialize(t)+'}';}
  String content(List<String> zad, Id d, String alt, String cap, List<String> opts, Integer ln){
    String s='{"schemaVersion":1,"blocks":[';
    for(Integer i=0;i<zad.size();i++){if(i>0)s+=',';s+=para(zad[i]);}
    if(d!=null){s+=',{"type":"image","contentDocumentId":"'+d+'","alt":'+JSON.serialize(alt)+',"caption":'+JSON.serialize(cap)+',"widthPercent":75,"align":"center"}';}
    if(opts!=null && !opts.isEmpty()){s+=',{"type":"list","items":[';for(Integer i=0;i<opts.size();i++){if(i>0)s+=',';s+=JSON.serialize(opts[i]);}s+=']}';}
    if(ln!=null && ln>0){s+=',{"type":"answerSpace","lines":'+ln+'}';}
    s+=']}';return s;
  }
  String solution(List<String> ps){String s='{"schemaVersion":1,"blocks":[';for(Integer i=0;i<ps.size();i++){if(i>0)s+=',';s+=para(ps[i]);}s+=']}';return s;}
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,CERMAT_Code__c=ccode,Source_Year__c=yr,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
    insert pub;
    List<Problem_Taxon__c> ls=new List<Problem_Taxon__c>();
    for(String code:codes){Id ti=tx.get(code);if(ti==null)continue;ls.add(new Problem_Taxon__c(Problem_Version__c=pub.Id,Taxon__c=ti,Unique_Key__c=pub.Id+'_'+ti));}
    if(!ls.isEmpty())insert ls;
    if(d!=null)lk(d,mp.Id);
    created++;
  }
}
Map<String,Id> tx=new Map<String,Id>();
for(Taxon__c t:[SELECT Id,Code__c FROM Taxon__c])tx.put(t.Code__c,t.Id);
Set<String> have=new Set<String>();
for(Math_Problem__c p:[SELECT Name FROM Math_Problem__c])have.add(p.Name);
C c=new C(tx,have,SRC,STYPE,CCODE,YEAR);

c.add(
  'CERMAT M7A 2017 – úloha 8',
  new List<String>{'V každém rohu papírového čtverce odstřihneme bílý čtverec o obsahu $4$ dm². Přehneme hrany, složíme krabici a spoje přelepíme izolepou. Dno krabice má obsah $25$ dm². Uveďte postup řešení.','8.1 Vypočtěte v dm obvod papírového čtverce (před odstřižením v rozích).','8.2 Vypočtěte v dm³ objem krabice.'},
  null,
  6,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 300" font-family="sans-serif"> <rect x="40" y="40" width="216" height="216" fill="#fff" stroke="#000" stroke-width="2.5"/> <rect x="88" y="40" width="120" height="48" fill="#d9d9d9"/> <rect x="88" y="208" width="120" height="48" fill="#d9d9d9"/> <rect x="40" y="88" width="48" height="120" fill="#d9d9d9"/> <rect x="208" y="88" width="48" height="120" fill="#d9d9d9"/> <rect x="88" y="88" width="120" height="120" fill="#a8a8a8" stroke="#000" stroke-width="2"/> <line x1="88" y1="40" x2="88" y2="256" stroke="#000" stroke-width="2" stroke-dasharray="8 6"/> <line x1="208" y1="40" x2="208" y2="256" stroke="#000" stroke-width="2" stroke-dasharray="8 6"/> <line x1="40" y1="88" x2="256" y2="88" stroke="#000" stroke-width="2" stroke-dasharray="8 6"/> <line x1="40" y1="208" x2="256" y2="208" stroke="#000" stroke-width="2" stroke-dasharray="8 6"/> <text x="44" y="74" font-size="13">4 dm²</text> <text x="148" y="153" font-size="15" text-anchor="middle">25 dm²</text> <polygon points="330,90 480,90 530,130 380,130" fill="#d9d9d9" stroke="#000" stroke-width="2.5"/> <polygon points="330,90 380,130 380,210 330,170" fill="#e6e6e6" stroke="#000" stroke-width="2.5"/> <polygon points="380,130 530,130 530,210 380,210" fill="#bdbdbd" stroke="#000" stroke-width="2.5"/> <text x="455" y="245" font-size="14" text-anchor="middle">krabice</text> </svg>',
  'krabice.svg',
  'Papírový čtverec s odstřiženými rohovými čtverci o obsahu 4 dm² a vyznačeným dnem o obsahu 25 dm², vedle složená krabice.',
  'Výchozí obrázek k úloze 8',
  new List<String>{'8.1 Dno má obsah $25$ dm², jeho strana je $5$ dm. Odstřižený čtverec má obsah $4$ dm², jeho strana (= výška krabice) je $2$ dm. Strana papírového čtverce je $2+5+2=9$ dm, obvod $4\\cdot 9=36$ dm.','8.2 Objem $=25\\cdot 2=50$ dm³.'},
  '8.1: $36$ dm; 8.2: $50$ dm³',
  3, 6, '3',
  new List<String>{'zs2','r7','stereometrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2017 – úloha 9 (konstrukce)',
  new List<String>{'V rovině leží pravoúhlý trojúhelník $ABC$ (viz obrázek).','9.1 Vrcholy trojúhelníku $ABC$ jsou současně vrcholy rovnoběžníku $ABCD$. Sestrojte chybějící vrchol $D$ rovnoběžníku $ABCD$ a rovnoběžník narýsujte.','9.2 V trojúhelníku $ABC$ sestrojte výšku na stranu $AB$. Průsečík výšky a přímky $AB$ označte $P$. Bod $P$ se nazývá pata výšky.','9.3 V trojúhelníku $ABD$ sestrojte výšku na stranu $AB$ a patu výšky označte $Q$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 280" font-family="sans-serif"> <polygon points="120,230 430,200 330,60" fill="none" stroke="#000" stroke-width="2.5"/> <text x="104" y="248" font-size="17" font-style="italic">A</text> <text x="440" y="204" font-size="17" font-style="italic">B</text> <text x="326" y="46" font-size="17" font-style="italic">C</text> </svg>',
  'trojuhelnik-abc.svg',
  'Pravoúhlý trojúhelník ABC v rovině s vrcholy A vlevo dole, B vpravo a C nahoře.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'9.1 V rovnoběžníku $ABCD$ platí $AB \\parallel DC$ a $AD \\parallel BC$. Vrchol $D$ leží v průsečíku rovnoběžky s $AB$ vedené bodem $C$ a rovnoběžky s $BC$ vedené bodem $A$.','9.2 Výška z vrcholu $C$ je kolmice k přímce $AB$ procházející bodem $C$; její průsečík s přímkou $AB$ je pata výšky $P$ (leží uvnitř strany $AB$).','9.3 Výška trojúhelníku $ABD$ na stranu $AB$ je kolmice k přímce $AB$ vedená bodem $D$; pata výšky $Q$ leží na přímce $AB$ vně strany $AB$ (za bodem $A$).'},
  'Rovnoběžník $ABCD$ ($D$ je průsečík rovnoběžky s $AB$ bodem $C$ a rovnoběžky s $BC$ bodem $A$), pata výšky $P$ na straně $AB$ z vrcholu $C$ a pata výšky $Q$ na přímce $AB$ z vrcholu $D$ – viz obrázek v klíči.',
  3, 7, '3',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
