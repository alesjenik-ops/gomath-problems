String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD18C0T01';
Integer YEAR = 2018;

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
  'CERMAT M5A 2018 – úloha 8',
  new List<String>{'Čtvercová síť je tvořena čtverečky s délkou strany $1$ cm a obsahem $1$ cm$^2$. Ve čtvercové síti jsou zakresleny bílé obrazce $A$, $B$ s vrcholy v mřížových bodech (viz obrázek).','Rozhodněte o každém z tvrzení 8.1–8.3, zda je pravdivé (A), či nikoli (N).','8.1 Obsah obrazce $A$ je $10$ cm$^2$.','8.2 Obsah obrazce $B$ je třikrát menší než obsah obrazce $A$.','8.3 Obvod obrazce $B$ je o $4$ cm menší než obvod obrazce $A$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 416 285" font-family="sans-serif"><rect x="264" y="208" width="32" height="32" fill="#d9d9d9"/><line x1="40" y1="16" x2="40" y2="240" stroke="#555" stroke-width="1"/><line x1="72" y1="16" x2="72" y2="240" stroke="#555" stroke-width="1"/><line x1="104" y1="16" x2="104" y2="240" stroke="#555" stroke-width="1"/><line x1="136" y1="16" x2="136" y2="240" stroke="#555" stroke-width="1"/><line x1="168" y1="16" x2="168" y2="240" stroke="#555" stroke-width="1"/><line x1="200" y1="16" x2="200" y2="240" stroke="#555" stroke-width="1"/><line x1="232" y1="16" x2="232" y2="240" stroke="#555" stroke-width="1"/><line x1="264" y1="16" x2="264" y2="240" stroke="#555" stroke-width="1"/><line x1="296" y1="16" x2="296" y2="240" stroke="#555" stroke-width="1"/><line x1="40" y1="16" x2="296" y2="16" stroke="#555" stroke-width="1"/><line x1="40" y1="48" x2="296" y2="48" stroke="#555" stroke-width="1"/><line x1="40" y1="80" x2="296" y2="80" stroke="#555" stroke-width="1"/><line x1="40" y1="112" x2="296" y2="112" stroke="#555" stroke-width="1"/><line x1="40" y1="144" x2="296" y2="144" stroke="#555" stroke-width="1"/><line x1="40" y1="176" x2="296" y2="176" stroke="#555" stroke-width="1"/><line x1="40" y1="208" x2="296" y2="208" stroke="#555" stroke-width="1"/><line x1="40" y1="240" x2="296" y2="240" stroke="#555" stroke-width="1"/><polygon points="40,48 200,48 104,176 72,176" fill="#fff" stroke="#000" stroke-width="2.5"/><polygon points="232,48 296,48 200,176" fill="#fff" stroke="#000" stroke-width="2.5"/><text x="98" y="112" font-size="18" font-weight="bold">A</text><text x="240" y="108" font-size="18" font-weight="bold">B</text><text x="304" y="228" font-size="12">1 cm²</text><text x="6" y="234" font-size="12">1 cm</text></svg>',
  'sit-obrazce-AB.svg',
  'Čtvercová síť 8 krát 7; vlevo bílý čtyřúhelník A, vpravo bílý trojúhelník B, vrcholy v mřížových bodech.',
  'schematický nákres',
  new List<String>{'8.1 Obrazec $A$ je čtyřúhelník o obsahu $12$ cm$^2$ (nikoli $10$ cm$^2$). Tvrzení je nepravdivé (N).','8.2 Obrazec $B$ je trojúhelník o obsahu $\\frac{1}{2}\\cdot 2\\cdot 4=4$ cm$^2$; $12:3=4$, obsah $B$ je třikrát menší než obsah $A$. Pravdivé (A).','8.3 Obvod $A$ je $5+5+1+\\sqrt{17}=11+\\sqrt{17}$ cm, obvod $B$ je $2+5+\\sqrt{17}=7+\\sqrt{17}$ cm; rozdíl je právě $4$ cm. Pravdivé (A).'},
  '8.1: N (nepravdivé); 8.2: A (pravdivé); 8.3: A (pravdivé)',
  4, 6, '3',
  new List<String>{'zs1','planimetrie','argumentace','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2018 – úloha 9',
  new List<String>{'Chlapci a dívky ve třídě vytvořili beze zbytku pětice, v nichž jsou $2$ dívky a $3$ chlapci. K vytvoření smíšených párů ($1$ chlapec a $1$ dívka) chybí $6$ dívek.','Kolik dívek je ve třídě?'},
  new List<String>{'A) méně než 10','B) 10','C) 11','D) více než 11','E) Nelze jednoznačně určit.'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Je-li pětic $n$, je ve třídě $2n$ dívek a $3n$ chlapců. Pro smíšené páry by muselo být dívek stejně jako chlapců; chybí $3n-2n=n$ dívek, tedy $n=6$. Dívek je $2\\cdot 6=12$, což je více než $11$.'},
  'D) více než 11',
  2, 3, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2018 – úloha 10',
  new List<String>{'Koberec je ručně vázaný. Každý měsíc se zhotovil stejný díl koberce. Vázání pětiny koberce trvalo půl roku.','Kolik měsíců trvalo vázání poloviny koberce?'},
  new List<String>{'A) méně než 14 měsíců','B) 14 měsíců','C) 15 měsíců','D) 16 měsíců','E) jiný počet měsíců'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Pětina koberce trvala půl roku, tj. $6$ měsíců; měsíčně se tak zhotoví $\\frac{1}{5}:6=\\frac{1}{30}$ koberce. Polovina koberce trvá $\\frac{1}{2}:\\frac{1}{30}=15$ měsíců.'},
  'C) 15 měsíců',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
