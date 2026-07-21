String SRC   = 'CERMAT – Jednotná přijímací zkouška 2024, 1. náhradní termín (M9C)';
String STYPE = 'CERMAT';

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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes,String ccode,Integer yr){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',CERMAT_Code__c=ccode,Source_Year__c=yr,Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
  'CERMAT 2024 M9C · úloha 10',
  new List<String>{'V rovině je dána přímka $o$ a body $A$, $S$, které na $o$ neleží. Bod $A$ je vrchol rovnoramenného lichoběžníku $ABCD$, bod $S$ je střed strany $BC$ a přímka $o$ je osa souměrnosti lichoběžníku (viz obrázek).','Sestrojte lichoběžník $ABCD$.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 462 569"><path d="M4 4L5 4L5 565L4 565Z" style="fill:#000000"/><path d="M456 4L458 4L458 565L456 565Z" style="fill:#000000"/><path d="M264 158L219 432M306 312L299 320M299 312L306 320" style="fill:none;stroke:#000000;stroke-width:2"/><text x="70" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">V rovině je dána přímka</text><text x="133" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">o</text><text x="156" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a body</text><text x="179" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="188" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a</text><text x="197" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">S,</text><text x="258" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">které neleží na přímce</text><text x="318" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">o</text><text x="336" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">. Bod</text><text x="353" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="381" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">je vrchol</text><text x="89" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">rovnoramenného lichoběžníku</text><text x="181" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">ABCD</text><text x="208" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">, bod</text><text x="225" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">S</text><text x="265" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">je střed strany</text><text x="310" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">BC</text><text x="337" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">. Přímka</text><text x="361" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">o</text><text x="381" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">je osa</text><text x="77" y="55" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">souměrnosti lichoběžníku.</text><text x="316" y="323" font-size="14" fill="#000" text-anchor="middle" font-family="sans-serif">S</text><text x="255" y="172" font-size="14" fill="#000" text-anchor="middle" font-family="sans-serif">o</text></svg>',
  'obr.svg',
  'Přímka o a body A, S, které na ní neleží.',
  '',
  new List<String>{'Osová souměrnost podle $o$ zobrazuje $A$ na $B$; vrchol $B$ je obrazem $A$ v souměrnosti podle $o$.','Bod $S$ je střed strany $BC$; vrchol $C$ dopočteme na polopřímce $BS$ tak, aby $|BS|=|SC|$, a $D$ jako obraz $C$ podle $o$.'},
  'Vrchol $B$ je obraz $A$ v souměrnosti podle osy $o$; $C$ dopočteme ze středu $S$ strany $BC$ a $D$ jako obraz $C$ podle $o$.',
  3, 5, '4',
  new List<String>{'zs2','r9','konstrukce','geometrie','planimetrie','konstrukcni','rysovani','bez-kontextu'},
  'M9PCD24C0T03', 2024
);

System.debug('Vytvořeno úloh: '+c.created);
