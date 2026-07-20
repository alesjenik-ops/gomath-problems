String SRC   = 'Matematika - Zelený';
String STYPE = 'Jiné';

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
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
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE);

c.add(
  'Zelený K12 – plášť kužele',
  new List<String>{'Na obrázku je kužel o výšce $8$ cm a průměru podstavy $12$ cm.','Jaký je obsah pláště kužele (bez podstavy)?'},
  new List<String>{'A) $30\\pi$ cm²','B) $40\\pi$ cm²','C) $60\\pi$ cm²','D) $100\\pi$ cm²','E) jiný výsledek'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 440" font-family="sans-serif"> <ellipse cx="230" cy="340" rx="170" ry="35" fill="none" stroke="#000" stroke-width="2"/> <line x1="230" y1="60" x2="60" y2="340" stroke="#000" stroke-width="2.5"/> <line x1="230" y1="60" x2="400" y2="340" stroke="#000" stroke-width="2.5"/> <line x1="230" y1="60" x2="230" y2="340" stroke="#000" stroke-width="1.5" stroke-dasharray="6 5"/> <line x1="230" y1="340" x2="400" y2="340" stroke="#000" stroke-width="1.5" stroke-dasharray="6 5"/> <line x1="430" y1="60" x2="430" y2="340" stroke="#444" stroke-width="1"/> <polygon points="430,60 426,68 434,68" fill="#444"/><polygon points="430,340 426,332 434,332" fill="#444"/> <text x="450" y="205" font-size="16" text-anchor="middle" transform="rotate(-90 450 205)">8 cm</text> <line x1="60" y1="390" x2="400" y2="390" stroke="#444" stroke-width="1"/> <polygon points="60,390 68,386 68,394" fill="#444"/><polygon points="400,390 392,386 392,394" fill="#444"/> <text x="230" y="382" font-size="15" text-anchor="middle">12 cm</text> </svg>',
  'kuzel.svg',
  'Kužel o výšce 8 cm a průměru podstavy 12 cm.',
  'Kužel o výšce 8 cm a průměru podstavy 12 cm',
  new List<String>{'Poloměr podstavy $r=6$ cm, výška $v=8$ cm. Strana kužele $s=\\sqrt{r^2+v^2}=\\sqrt{36+64}=10$ cm. Plášť $S=\\pi r s=\\pi\\cdot 6\\cdot 10=60\\pi$ cm².'},
  'C) $60\\pi$ cm²',
  2, 4, '2',
  new List<String>{'zs2','r9','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený K13 – úhel v rovnoramenném trojúhelníku',
  new List<String>{'Na obrázku je úhel označený symbolem „?". Nekonvexní (nevypuklý) úhel u pravého dolního vrcholu je $324°$; dvě strany označené shodnými značkami jsou stejně dlouhé (trojúhelník je rovnoramenný).','Jak velký je úhel na obrázku označený symbolem „?"?'},
  new List<String>{'A) $108^\\circ$','B) $112^\\circ$','C) $124^\\circ$','D) $144^\\circ$','E) jiný výsledek'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 380" font-family="sans-serif"> <line x1="70" y1="320" x2="470" y2="320" stroke="#000" stroke-width="2"/> <line x1="140" y1="320" x2="275" y2="222" stroke="#000" stroke-width="2.5"/> <line x1="410" y1="320" x2="275" y2="222" stroke="#000" stroke-width="2.5"/> <circle cx="410" cy="320" r="42" fill="none" stroke="#000" stroke-width="1.5"/> <text x="452" y="336" font-size="17" font-weight="bold">324°</text> <text x="268" y="256" font-size="20" font-weight="bold">?</text> <line x1="200" y1="264" x2="214" y2="278" stroke="#000" stroke-width="2"/> <line x1="206" y1="258" x2="220" y2="272" stroke="#000" stroke-width="2"/> <line x1="332" y1="272" x2="346" y2="258" stroke="#000" stroke-width="2"/> <line x1="338" y1="278" x2="352" y2="264" stroke="#000" stroke-width="2"/> </svg>',
  'uhel.svg',
  'Rovnoramenný trojúhelník se základnou na vodorovné přímce; u pravého dolního vrcholu je vyznačen nekonvexní úhel 324°, u hlavního vrcholu úhel označený otazníkem, ramena mají shodné značky.',
  'Schematický nákres k úloze 13',
  new List<String>{'Nekonvexní úhel 324° znamená vnitřní úhel 360° - 324° = 36° u pravého dolního vrcholu. Trojúhelník je rovnoramenný, oba úhly při základně mají 36°. Hledaný úhel při hlavním vrcholu má 180° - 2 × 36° = 108°.'},
  'A) $108^\\circ$',
  2, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
