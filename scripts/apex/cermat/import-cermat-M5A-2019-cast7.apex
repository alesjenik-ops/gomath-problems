String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD19C0T01';
Integer YEAR = 2019;

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
  'CERMAT M5A 2019 – úloha 13',
  new List<String>{'Z malých krychliček byly slepeny tři stejné kvádry o rozměrech $3\\times 2\\times 2$ krychličky. Z každého kvádru jsme odstranili dvě malé krychličky a vytvořili tak tři nová tělesa. Na každé nové těleso jsme doprostřed každého čtverečku na jeho povrchu (i zespodu) nalepili jeden černý puntík (viz obrázek).','Přiřaďte ke každé otázce (13.1–13.3) správnou odpověď (A–F).','13.1 Kolik puntíků je na 1. tělese?','13.2 Kolik puntíků je na 2. tělese?','13.3 Kolik puntíků je na 3. tělese?'},
  new List<String>{'A) $30$','B) $31$','C) $32$','D) $34$','E) $36$','F) jiný počet'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 210" font-family="sans-serif"><text x="95" y="54" font-size="12" text-anchor="middle">1. těleso</text><polygon points="50,80 78,62 168,62 140,80" fill="#eee" stroke="#000" stroke-width="1.5"/><polygon points="140,80 168,62 168,122 140,140" fill="#e0e0e0" stroke="#000" stroke-width="1.5"/><rect x="50" y="80" width="90" height="60" fill="#fff" stroke="#000" stroke-width="1.5"/><line x1="80" y1="80" x2="80" y2="140" stroke="#000" stroke-width="0.8"/><line x1="110" y1="80" x2="110" y2="140" stroke="#000" stroke-width="0.8"/><line x1="50" y1="110" x2="140" y2="110" stroke="#000" stroke-width="0.8"/><circle cx="65" cy="95" r="3" fill="#000"/><circle cx="65" cy="125" r="3" fill="#000"/><circle cx="95" cy="95" r="3" fill="#000"/><circle cx="95" cy="125" r="3" fill="#000"/><circle cx="125" cy="95" r="3" fill="#000"/><circle cx="125" cy="125" r="3" fill="#000"/><text x="310" y="54" font-size="12" text-anchor="middle">2. těleso</text><polygon points="265,80 293,62 383,62 355,80" fill="#eee" stroke="#000" stroke-width="1.5"/><polygon points="355,80 383,62 383,122 355,140" fill="#e0e0e0" stroke="#000" stroke-width="1.5"/><rect x="265" y="80" width="90" height="60" fill="#fff" stroke="#000" stroke-width="1.5"/><line x1="295" y1="80" x2="295" y2="140" stroke="#000" stroke-width="0.8"/><line x1="325" y1="80" x2="325" y2="140" stroke="#000" stroke-width="0.8"/><line x1="265" y1="110" x2="355" y2="110" stroke="#000" stroke-width="0.8"/><circle cx="280" cy="95" r="3" fill="#000"/><circle cx="280" cy="125" r="3" fill="#000"/><circle cx="310" cy="95" r="3" fill="#000"/><circle cx="310" cy="125" r="3" fill="#000"/><circle cx="340" cy="125" r="3" fill="#000"/><rect x="328" y="83" width="24" height="24" fill="#cfcfcf" stroke="#000" stroke-width="0.8"/><text x="525" y="54" font-size="12" text-anchor="middle">3. těleso</text><polygon points="480,80 508,62 598,62 570,80" fill="#eee" stroke="#000" stroke-width="1.5"/><polygon points="570,80 598,62 598,122 570,140" fill="#e0e0e0" stroke="#000" stroke-width="1.5"/><rect x="480" y="80" width="90" height="60" fill="#fff" stroke="#000" stroke-width="1.5"/><line x1="510" y1="80" x2="510" y2="140" stroke="#000" stroke-width="0.8"/><line x1="540" y1="80" x2="540" y2="140" stroke="#000" stroke-width="0.8"/><line x1="480" y1="110" x2="570" y2="110" stroke="#000" stroke-width="0.8"/><circle cx="495" cy="125" r="3" fill="#000"/><circle cx="525" cy="95" r="3" fill="#000"/><circle cx="525" cy="125" r="3" fill="#000"/><circle cx="555" cy="95" r="3" fill="#000"/><rect x="483" y="83" width="24" height="24" fill="#cfcfcf" stroke="#000" stroke-width="0.8"/><rect x="543" y="113" width="24" height="24" fill="#cfcfcf" stroke="#000" stroke-width="0.8"/><text x="310" y="198" font-size="10" text-anchor="middle" fill="#555">schematický nákres, počty puntíků viz řešení</text></svg>',
  'telesa.svg',
  'Tři tělesa vzniklá z kvádru 3 krát 2 krát 2 odebráním dvou krychliček, s černými puntíky na čtverečcích povrchu (schematicky).',
  'schematický nákres',
  new List<String>{'Počet puntíků se rovná počtu jednotkových čtverečků na celém povrchu tělesa (i zespodu). Celý kvádr $3\\times 2\\times 2$ má povrch $2\\cdot(3\\cdot 2+3\\cdot 2+2\\cdot 2)=32$ čtverečků.','13.1 U 1. tělesa jsou obě odebrané krychličky rohové (každá měla na povrchu $3$ čtverečky), povrch se nezmění: $32$ – odpověď C.','13.2 U 2. tělesa vznikne odebráním dvou sousedních krychliček výklenek a počet čtverečků povrchu klesne na $30$ – odpověď A.','13.3 U 3. tělesa se odebráním dvou krychliček počet čtverečků povrchu zvětší na $36$ – odpověď E.'},
  '13.1: C ($32$); 13.2: A ($30$); 13.3: E ($36$)',
  5, 6, '4',
  new List<String>{'zs1','stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
