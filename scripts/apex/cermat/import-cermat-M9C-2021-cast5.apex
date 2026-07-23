String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PCD21C0T03';
Integer YEAR = 2021;

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
  'CERMAT M9C 2021 – úloha 12',
  new List<String>{'V rovině leží čtyři přímky, z nichž dvě jsou rovnoběžné (vyznačeny ryskami). Jsou vyznačeny úhly $\\alpha$, $2\\alpha$ a $36^\\circ$ (viz obrázek).','Jaká je velikost úhlu $\\alpha$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) $18^\\circ$','B) $36^\\circ$','C) $44^\\circ$','D) $48^\\circ$','E) jiná velikost'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 360" font-family="sans-serif"> <line x1="70" y1="150" x2="400" y2="120" stroke="#000" stroke-width="1.8"/> <line x1="100" y1="270" x2="410" y2="240" stroke="#000" stroke-width="1.8"/> <line x1="110" y1="115" x2="360" y2="300" stroke="#000" stroke-width="1.8"/> <line x1="130" y1="300" x2="390" y2="110" stroke="#000" stroke-width="1.8"/> <line x1="346" y1="118" x2="356" y2="132" stroke="#000" stroke-width="1.5"/> <line x1="358" y1="117" x2="368" y2="131" stroke="#000" stroke-width="1.5"/> <line x1="356" y1="238" x2="366" y2="252" stroke="#000" stroke-width="1.5"/> <line x1="368" y1="237" x2="378" y2="251" stroke="#000" stroke-width="1.5"/> <text x="150" y="134" font-size="16" font-style="italic">α</text> <text x="255" y="207" font-size="16" font-style="italic">2α</text> <text x="150" y="256" font-size="16">36°</text> </svg>',
  'ctyri-primky.svg',
  'Čtyři přímky – dvě rovnoběžné s ryskami a dvě různoběžné; vyznačeny úhly α, 2α a 36°.',
  'Schematický nákres k úloze 12',
  new List<String>{'Obě různoběžky spolu s jednou z rovnoběžek tvoří trojúhelník. Díky rovnoběžnosti přímek se úhel $\\alpha$ přenese k této rovnoběžce, takže vnitřními úhly trojúhelníku jsou $\\alpha$, $2\\alpha$ a $36^\\circ$. Platí $\\alpha+2\\alpha+36^\\circ=180^\\circ$, tedy $3\\alpha=144^\\circ$ a $\\alpha=48^\\circ$.'},
  'D) $48^\\circ$',
  2, 4, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2021 – úloha 13',
  new List<String>{'Kolmý šestiboký hranol byl vytvořen opracováním krychle o hraně délky 8 cm. Podstava hranolu vznikne ze čtvercové stěny původní krychle oddělením 4 shodných pravoúhlých trojúhelníků s odvěsnami délek 3 cm a 4 cm. Výška hranolu je 8 cm (viz obrázek).','Jaký je objem šestibokého hranolu?'},
  new List<String>{'A) $128$ cm³','B) $320$ cm³','C) $416$ cm³','D) $488$ cm³','E) jiný objem'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 210" font-family="sans-serif"><text x="92" y="16" font-size="13" text-anchor="middle">Podstava hranolu</text><rect x="20" y="30" width="144" height="144" fill="#ededed" stroke="#999" stroke-width="1"/><polygon points="74,30 110,30 164,102 110,174 74,174 20,102" fill="#c9c9c9" stroke="#000" stroke-width="1.8"/><text x="137" y="24" font-size="13" text-anchor="middle">3 cm</text><text x="170" y="72" font-size="13">4 cm</text><text x="92" y="192" font-size="13" text-anchor="middle">8 cm</text><polygon points="441,25 463,25 496,69 463,113 441,113 408,69" fill="#f2f2f2" stroke="#777" stroke-width="1.2"/><line x1="415" y1="55" x2="463" y2="25" stroke="#777" stroke-width="1.2"/><line x1="448" y1="99" x2="496" y2="69" stroke="#777" stroke-width="1.2"/><line x1="415" y1="143" x2="463" y2="113" stroke="#777" stroke-width="1.2"/><line x1="393" y1="55" x2="441" y2="25" stroke="#777" stroke-width="1.2"/><polygon points="393,55 415,55 448,99 415,143 393,143 360,99" fill="#c9c9c9" stroke="#000" stroke-width="1.8"/><text x="470" y="50" font-size="13">8 cm</text></svg>',
  'sestiboky-hranol.svg',
  'Podstava – šestiúhelník vzniklý ze čtverce 8×8 cm oddělením rohových trojúhelníků (odvěsny 3 a 4 cm) – a šestiboký hranol výšky 8 cm.',
  'Podstava a šestiboký hranol (výška 8 cm)',
  new List<String>{'Obsah podstavy: čtverec $8\\cdot 8=64$ cm² zmenšený o 4 trojúhelníky o obsahu $\\dfrac{3\\cdot 4}{2}=6$ cm², tj. $64-4\\cdot 6=40$ cm². Objem $V=S_{p}\\cdot v=40\\cdot 8=320$ cm³.'},
  'B) $320$ cm³',
  2, 4, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
