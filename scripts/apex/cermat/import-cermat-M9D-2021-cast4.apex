String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD21C0T04';
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
  'CERMAT M9D 2021 – úloha 12',
  new List<String>{'Na obrázku jsou přímky; shodnými značkami jsou vyznačeny dvojice navzájem rovnoběžných přímek. Velikosti úhlů neměřte, ale vypočtěte.','Jaká je velikost úhlu $\\varphi$?'},
  new List<String>{'A) $128^\\circ$','B) $126^\\circ$','C) $118^\\circ$','D) $114^\\circ$','E) jiná velikost'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 470" font-family="sans-serif"><line x1="100.0" y1="80.0" x2="300.0" y2="430.0" stroke="#000" stroke-width="2"/><line x1="350.0" y1="80.0" x2="525.0" y2="430.0" stroke="#000" stroke-width="2"/><line x1="40.0" y1="120.0" x2="420.0" y2="175.0" stroke="#000" stroke-width="2"/><line x1="150.0" y1="250.0" x2="605.0" y2="250.0" stroke="#000" stroke-width="2"/><line x1="110.0" y1="380.0" x2="565.0" y2="380.0" stroke="#000" stroke-width="2"/><line x1="166.1" y1="181.5" x2="153.9" y2="188.5" stroke="#000" stroke-width="1.6"/><line x1="178.1" y1="202.5" x2="165.9" y2="209.5" stroke="#000" stroke-width="1.6"/><line x1="408.8" y1="181.9" x2="396.2" y2="188.1" stroke="#000" stroke-width="1.6"/><line x1="419.3" y1="202.9" x2="406.7" y2="209.1" stroke="#000" stroke-width="1.6"/><line x1="523.1" y1="243.0" x2="523.1" y2="257.0" stroke="#000" stroke-width="1.6"/><line x1="550.4" y1="243.0" x2="550.4" y2="257.0" stroke="#000" stroke-width="1.6"/><line x1="483.1" y1="373.0" x2="483.1" y2="387.0" stroke="#000" stroke-width="1.6"/><line x1="510.4" y1="373.0" x2="510.4" y2="387.0" stroke="#000" stroke-width="1.6"/><text x="138" y="162" font-size="17">62°</text><text x="291" y="372" font-size="17">66°</text><text x="404" y="240" font-size="18" font-style="italic">φ</text></svg>',
  'uhly-rovnobezky.svg',
  'Soustava přímek se dvěma dvojicemi rovnoběžek (vyznačenými shodnými značkami); jsou vyznačeny úhly 62°, 66° a hledaný úhel φ.',
  'Výchozí obrázek k úloze 12',
  new List<String>{'Přímky svírající úhel $\\varphi$ jsou rovnoběžné s přímkami, které svírají úhel $66^\\circ$ (shodné značky). Úhel $\\varphi$ a úhel $66^\\circ$ jsou proto úhly přilehlé a jejich součet je $180^\\circ$, takže $\\varphi=180^\\circ-66^\\circ=114^\\circ$. Úhel $62^\\circ$ náleží přímce, která s ostatními rovnoběžná není, a k výpočtu jej nepotřebujeme.'},
  'D) $114^\\circ$',
  2, 4, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
