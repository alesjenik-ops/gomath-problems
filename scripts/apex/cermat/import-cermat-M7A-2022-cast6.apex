String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD22C0T01';
Integer YEAR = 2022;

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
  'CERMAT M7A 2022 – úloha 12',
  new List<String>{'Podstavou kolmého trojbokého hranolu $ABCDEF$ s výškou $10$ cm je rovnoramenný trojúhelník $ABC$, jehož obsah je $12$ cm², obvod je $16$ cm a délka základny $AB$ je $6$ cm (viz obrázek).','Jaký je objem hranolu $ABCDEF$?'},
  new List<String>{'A) $120$ cm³','B) $125$ cm³','C) $180$ cm³','D) $240$ cm³','E) jiný objem'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 240" font-family="sans-serif"> <polygon points="70,80 150,45 210,85" fill="#f2f2f2" stroke="#000" stroke-width="1.5"/> <line x1="70" y1="80" x2="70" y2="200" stroke="#000" stroke-width="1.5"/> <line x1="210" y1="85" x2="210" y2="205" stroke="#000" stroke-width="1.5"/> <line x1="70" y1="200" x2="210" y2="205" stroke="#000" stroke-width="1.5"/> <line x1="150" y1="45" x2="150" y2="165" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/> <line x1="70" y1="200" x2="150" y2="165" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/> <line x1="210" y1="205" x2="150" y2="165" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/> <text x="58" y="80" font-size="13" font-style="italic">D</text> <text x="147" y="38" font-size="13" font-style="italic">F</text> <text x="216" y="86" font-size="13" font-style="italic">E</text> <text x="56" y="214" font-size="13" font-style="italic">A</text> <text x="214" y="221" font-size="13" font-style="italic">B</text> <text x="150" y="184" font-size="13" font-style="italic">C</text> </svg>',
  'hranol.svg',
  'Kolmý trojboký hranol ABCDEF s dolní podstavou ABC a horní podstavou DEF.',
  'Kolmý trojboký hranol ABCDEF',
  new List<String>{'Objem $=$ obsah podstavy $\\times$ výška $=12\\cdot 10=120$ cm³.'},
  'A) $120$ cm³',
  2, 3, '2',
  new List<String>{'zs2','r7','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2022 – úloha 13',
  new List<String>{'Podstavou kolmého trojbokého hranolu $ABCDEF$ s výškou $10$ cm je rovnoramenný trojúhelník $ABC$, jehož obsah je $12$ cm², obvod je $16$ cm a délka základny $AB$ je $6$ cm (viz obrázek).','Jaký je povrch hranolu $ABCDEF$?'},
  new List<String>{'A) $160$ cm²','B) $184$ cm²','C) $190$ cm²','D) $204$ cm²','E) jiný povrch'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 240" font-family="sans-serif"> <polygon points="70,80 150,45 210,85" fill="#f2f2f2" stroke="#000" stroke-width="1.5"/> <line x1="70" y1="80" x2="70" y2="200" stroke="#000" stroke-width="1.5"/> <line x1="210" y1="85" x2="210" y2="205" stroke="#000" stroke-width="1.5"/> <line x1="70" y1="200" x2="210" y2="205" stroke="#000" stroke-width="1.5"/> <line x1="150" y1="45" x2="150" y2="165" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/> <line x1="70" y1="200" x2="150" y2="165" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/> <line x1="210" y1="205" x2="150" y2="165" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/> <text x="58" y="80" font-size="13" font-style="italic">D</text> <text x="147" y="38" font-size="13" font-style="italic">F</text> <text x="216" y="86" font-size="13" font-style="italic">E</text> <text x="56" y="214" font-size="13" font-style="italic">A</text> <text x="214" y="221" font-size="13" font-style="italic">B</text> <text x="150" y="184" font-size="13" font-style="italic">C</text> </svg>',
  'hranol13.svg',
  'Kolmý trojboký hranol ABCDEF s dolní podstavou ABC a horní podstavou DEF.',
  'Kolmý trojboký hranol ABCDEF',
  new List<String>{'Povrch $=$ dvě podstavy $+$ plášť $=2\\cdot 12+16\\cdot 10=24+160=184$ cm².'},
  'B) $184$ cm²',
  2, 4, '3',
  new List<String>{'zs2','r7','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2022 – úloha 14',
  new List<String>{'Na Dračí horu přiletěli dvouhlaví a tříhlaví draci. Dohromady měli $115$ hlav. Dvouhlavých draků přiletělo o $35$ více než tříhlavých.','Kolik draků přiletělo na Dračí horu?'},
  new List<String>{'A) $53$ draků','B) $50$ draků','C) $45$ draků','D) $40$ draků','E) jiný počet draků'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Označme počet tříhlavých draků $t$, dvouhlavých $t+35$. Pro počet hlav platí $3t+2(t+35)=115$, tj. $5t+70=115$, $t=9$. Dvouhlavých je $44$, celkem $9+44=53$ draků.'},
  'A) $53$ draků',
  2, 4, '3',
  new List<String>{'zs2','r7','rovnice','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
